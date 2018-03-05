SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [Business].[uspUpdateTrusteeAddressPhone]
	@trusteeID int,
	@customerID varchar(50),
	@productID varchar(50),
	@trusteeTypeID int,
	@prefixID int = NULL,
	@firstName varchar(50) = NULL,
	@middleName varchar(50) = NULL,
	@lastName varchar(50) = NULL,
	@suffix int = NULL,
	@personTitleTypeID int = NULL,
	@companyName varchar(150) = NULL,
	@companyAlias varchar(50) = NULL,
	@addressTypeID int,
	@directionTypeID int,
	@streetTypeID int,
	@countryID int,
	@address1 varchar(100),
	@address2 varchar(100),
	@city varchar(50),
	@stateID int,
	@zipcode varchar(10),
	@zipcodeExt varchar(5),
	@email varchar(50) = NULL,
	@number varchar(25) = NULL,
	@numberExt [varchar](10) = NULL,
	@phoneTypeID int = NULL,
	@notes [dbo].[NOTE] = 'inserted Trustee',
	
	@name varchar(50) = NULL,
	@description text = NULL,

 	@userName varchar(50)										
 

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			EXEC [Business].[uspUpdateTrustee] 
				@TrusteeID 			= @trusteeID, 
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
				@UserName 			= @userName

			EXEC [Business].[uspUpdateTrusteePhone] 
				@TrusteeID 			= @trusteeID, 
				@Number 			= @number, 
				@NumberExt 			= @numberExt, 
				@PhoneTypeID 		= @phoneTypeID, 
				@UserName 			= @userName

			EXEC [Business].[uspUpdateTrusteeAddress] 
				@TrusteeID 			= @trusteeID, 
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
				@UserName 			= @userName
			
			DECLARE @UpdatedDateTime datetime = CURRENT_TIMESTAMP
			execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID, @UserName, @UpdatedDateTime , @notes 

			SELECT t.*, p.*, a.*
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
