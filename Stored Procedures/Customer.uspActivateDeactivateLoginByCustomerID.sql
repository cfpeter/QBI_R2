SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspActivateDeactivateLoginByCustomerID]
@customerID int,
@isActive int

AS
BEGIN	
 
	BEGIN TRY
		BEGIN TRAN	
			DECLARE @isCustomerPrimary bit = (SELECT MainClient FROM [Customer].[Customer] WHERE CustomerID = @customerID);
			
			IF (@isCustomerPrimary != 1 OR (@isCustomerPrimary = 1 AND @isActive = 1 ))
				BEGIN
					UPDATE [Customer].[Login] 
						SET
						   [IsActive] = @isActive
	   					WHERE CustomerID = @customerID
				END
			ELSE 
				BEGIN
					IF (@isActive = 1)
						BEGIN
							SET @isActive = 0;
						END
					ELSE
						BEGIN
							SET @isActive = 1;
						END
					
				END

			SELECT @isActive isActive;
			
										
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
