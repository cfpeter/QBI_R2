SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<insert trustee with address and phone>
-- =============================================
CREATE PROC [Business].[uspInsertTrusteeAndPhone]
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



			DECLARE @UpdatedDateTime datetime =  CURRENT_TIMESTAMP
			execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID, @userName, @UpdatedDateTime , @Notes 

			SELECT t.TrusteeID, t.TrusteeTypeID, t.FirstName, t.LastName, t.PersonTitleTypeID, t.CompanyName, t.CompanyAlias, t.Email, t.Note, p.PhoneID, p.PhoneTypeID, p.Number, p.NumberExt
 				FROM [Map].[ProductTrusteeMap] m
				INNER JOIN [Business].[Trustee] t ON m.TrusteeID = t.TrusteeID
				LEFT JOIN [Customer].[Phone] p ON p.PhoneID = (SELECT tpm.PhoneID FROM [Map].[TrusteePhoneMap] tpm WHERE tpm.TrusteeID = t.TrusteeID)
				WHERE m.TrusteeID = @trusteeID;

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
