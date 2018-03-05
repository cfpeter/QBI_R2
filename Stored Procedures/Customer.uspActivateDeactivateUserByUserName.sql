SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian> 
-- =============================================
CREATE PROCEDURE [Customer].[uspActivateDeactivateUserByUserName] 
	 @userName varchar(45)
	,@isActive int
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			SET NOCOUNT ON;
			DECLARE @DateTimeStamp datetime = CURRENT_TIMESTAMP
			UPDATE [Customer].[Login]
				SET
					 [IsActive]			= @isActive
					,[UpdatedDateTime]	= @DateTimeStamp
					,[Note]				= 'This user status/isActive has been changed '
				WHERE UserName		= @userName
	
	
			DECLARE @CustomerID bigint = ( SELECT CustomerID FROM [Customer].[Login] WHERE UserName = @userName )
			DECLARE @Note varchar(100) = 'User login activation status changed to ' +  Convert(CHAR(1),  @isActive )

				 execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @DateTimeStamp , @Note
		COMMIT	
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			EXEC dbo.uspRethrowError
		END
	END CATCH
END





GO
