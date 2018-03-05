SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [Business].[uspUpdateTrusteeAndPhone]
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
			DECLARE @addTrusteeToMap_true_false int = (	SELECT count(ProductTrusteeID)  from [Map].ProductTrusteeMap  where ProductID = @productID and TrusteeID = @trusteeID )


			IF( @addTrusteeToMap_true_false = 0 )
				BEGIN  

				INSERT INTO [Map].[ProductTrusteeMap]
					   (
						[ProductID]
					   ,[TrusteeID]
					   ,[Description]
					   ,[CreatedDateTime]
					   ,[CreatedBy]
					   ,[UpdatedDateTime]
					   ,[UpdatedBy]
					   )
				 VALUES
					   (
						@productID
					   ,@trusteeID
					   ,null
					   ,CURRENT_TIMESTAMP
					   ,@userName
					   ,CURRENT_TIMESTAMP
					   ,@userName
					   )
				END

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

			
			
			DECLARE @UpdatedDateTime datetime = CURRENT_TIMESTAMP
			--execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID, @UserName, @UpdatedDateTime , @notes 

			SELECT t.TrusteeID, t.TrusteeTypeID, t.FirstName, t.LastName, t.PersonTitleTypeID, t.CompanyName, t.CompanyAlias, t.Email, t.Note, t.UpdatedDateTime, p.PhoneID, p.PhoneTypeID, p.Number, p.NumberExt
 				FROM [Map].[ProductTrusteeMap] m
				INNER JOIN [Business].[Trustee] t ON m.TrusteeID = t.TrusteeID
				LEFT JOIN [Customer].[Phone] p ON p.PhoneID = (SELECT tpm.PhoneID FROM [Map].[TrusteePhoneMap] tpm WHERE tpm.TrusteeID = t.TrusteeID)
				WHERE m.TrusteeID = @trusteeID AND m.ProductID = @productID;

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
