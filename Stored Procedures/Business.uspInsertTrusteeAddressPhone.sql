SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<insert trustee with address and phone>
-- =============================================
CREATE PROC [Business].[uspInsertTrusteeAddressPhone]
	@customerID [varchar](50),
	@productID [varchar](50),
	@trusteeTypeID [int],
	@prefixID [int] = NULL,
	@firstName [varchar](50) = NULL,
	@middleName [varchar](50) = NULL,
	@lastName [varchar](50) = NULL,
	@suffix [int] = NULL,
	@personTitleTypeID [int] = NULL,
	@companyName [varchar](150) = NULL,
	@companyAlias [varchar](50) = NULL,
	@addressTypeID [int],
	@directionTypeID [int] = NULL,
	@streetTypeID [int] = NULL,
	@countryID [int],
	@address1 [varchar](100),
	@address2 [varchar](100),
	@city [varchar](50),
	@stateID [int],
	@zipcode [varchar](10),
	@zipcodeExt [varchar](5),
	@email [varchar](50) = NULL,
	@number [varchar](25) = NULL,
	@numberExt [varchar](10) = NULL,
	@phoneTypeID [int] = NULL,
	@notes [dbo].[note] = 'inserted Trustee',
	
	@name [varchar](50) = NULL,
	@description [text] = NULL,

 	@userName [varchar](50)	
	

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			

			DECLARE @phoneID bigint
			EXEC [Business].[uspInsertTrusteePhone] 
				@Number 			= @number, 
				@NumberExt 			= @numberExt, 
				@PhoneTypeID 		= @phoneTypeID, 
				@UserName 			= @userName, 
				@phoneID			= @phoneID OUT 

			DECLARE @addressID bigint
			EXEC [Business].[uspInsertTrusteeAddress] 
				@AddressTypeID 		= @addressTypeID,
				@DirectionTypeID 	= @directionTypeID,
				@StreetTypeID 		= @streetTypeID, 
				@CountryID 			= @countryID, 
				@Address1 			= @address1, 
				@Address2 			= @address2, 
				@City 				= @city, 
				@StateID 			= @stateID, 
				@Zipcode 			= @zipcode, 
				@ZipcodeExt			= @zipcodeExt, 
				@UserName 			= @userName,
				@addressID			= @addressID out
			
			DECLARE @trusteeID bigint
			EXEC [Business].[uspInsertTrustee] 
				@TrusteeTypeID 		= @trusteeTypeID, 
				@PrefixID 			= @prefixID, 
				@FirstName 			= @firstName, 
				@MiddleName 		= @middleName, 
				@LastName 			= @lastName, 
				@Suffix 			= @suffix, 
				@PersonTitleTypeID 	= @personTitleTypeID, 
				@CompanyName 		= @companyName, 
				@CompanyAlias 		= @companyAlias, 
				@Email 				= @email, 
				@Notes 				= @notes, 
				@Name 				= @name, 
				@Description 		= @description, 
				@UserName 			= @userName,
				@TrusteeID			= @trusteeID out
			
			

			INSERT INTO [Map].[ProductTrusteeMap] (ProductID,TrusteeID, UpdatedBy, CreatedBy, UpdatedDateTime, CreatedDateTime)
				VALUES ( @productID, @trusteeID, @userName, @userName, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

			INSERT INTO [Map].[TrusteePhoneMap] (TrusteeID, PhoneID, UpdatedBy, CreatedBy, UpdatedDateTime, CreatedDateTime)
				VALUES  (@trusteeID, @phoneID, @userName, @userName, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

			INSERT INTO [Map].[TrusteeAddressMap] (TrusteeID, AddressID, UpdatedBy, CreatedBy, UpdatedDateTime, CreatedDateTime)
				VALUES ( @trusteeID, @addressID, @userName, @userName, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


			DECLARE @UpdatedDateTime datetime =  CURRENT_TIMESTAMP
			execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID, @userName, @UpdatedDateTime , @Notes 

			SELECT t.TrusteeID, t.TrusteeTypeID, t.FirstName, t.LastName, t.PersonTitleTypeID, t.CompanyName, t.CompanyAlias, t.Email, t.Note, p.PhoneID, p.PhoneTypeID, p.Number, p.NumberExt, a.AddressID, a.AddressTypeID, a.Address1, a.Address2, a.City, a.StateID, a.Zipcode, a.ZipcodeExt
 				FROM [Map].[ProductTrusteeMap] m
				INNER JOIN [Business].[Trustee] t ON m.TrusteeID = t.TrusteeID
				LEFT JOIN [Customer].[Phone] p ON p.PhoneID = (SELECT tpm.PhoneID FROM [Map].[TrusteePhoneMap] tpm WHERE tpm.TrusteeID = t.TrusteeID)
				LEFT JOIN [Customer].[Address] a ON a.AddressID = (SELECT tam.AddressID FROM [Map].[TrusteeAddressMap] tam WHERE tam.TrusteeID = t.TrusteeID)
				WHERE m.ProductID = @ProductID;

		COMMIT
	
	 END TRY
	 BEGIN CATCH
		if(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			exec dbo.uspRethrowError
		END
	 END CATCH
END




GO
