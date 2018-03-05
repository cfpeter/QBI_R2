SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspActivateCustomer]
@customerID int,
@isActive int,
@isActivationEmailSent int ,
@email varchar(50)

AS 
BEGIN	
 
	BEGIN TRY
		BEGIN TRAN	
	
	UPDATE [Customer].[Customer] 
		SET
		   [IsActive] = @isActive,
		   [isActivationEmailSent] = @isActivationEmailSent

	   	WHERE CustomerID = @customerID

	
	
	UPDATE [Customer].[Login] 
		SET
		   [IsActive] = @isActive

	   	WHERE CustomerID = @customerID
	
	
	
	DECLARE @personID int = ( SELECT personID FROM [Customer].[Customer]  WHERE CustomerID = @customerID )
	if( @email is not null )
	BEGIN

		UPDATE [Customer].[Person] 
			SET
			   [Email] = @email
			WHERE PersonID = @personID
	END		

										
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
