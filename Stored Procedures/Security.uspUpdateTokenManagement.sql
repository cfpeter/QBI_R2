SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian	>
-- Create date: <05/09/2016>
-- Description:	<Update token status>
-- =============================================
CREATE PROCEDURE [Security].[uspUpdateTokenManagement]
	@TokenManagementID bigint,
	@Token varchar(250),
	@IsActive bit = 1,
	@UserName varchar(50) = user_Name
	
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			SET NOCOUNT ON;

			UPDATE [Security].[TokenManagement]
			SET [IsActive] = @IsActive
			  ,[UpdatedDateTime] = CURRENT_TIMESTAMP
			  ,[UpdatedBy] = @UserName
     
			WHERE TokenManagementID = @TokenManagementID
			AND Token = @Token
		COMMIT
	END TRY
	BEGIN CATCH
		IF( @@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			exec dbo.uspRethrowError
		END
	END CATCH
END








GO
