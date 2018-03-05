SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <05/09/2016>
-- Description:	<Insert token after successful authentication to exchange between other solutions >
-- =============================================
CREATE PROCEDURE [Security].[uspInsertTokenManagement] 
	@Token varchar(250),
	@DomainGroupMapID int,
	--@IsActive bit = 1,
	@UserName varchar(50) = user_Name,
	@CustomerID bigint,
	@TokenManagementID int out
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
			-- Insert statements for procedure here
			INSERT INTO [Security].[TokenManagement]
				   ([Token]
				   ,[DomainGroupMapID]
				   ,[IsActive]
				   ,[CustomerID]
				   ,[UpdatedDateTime]
				   ,[UpdatedBy]
				   ,[CreatedDateTime]
				   ,[CreatedBy])
			 VALUES
				   (@Token
				   ,@DomainGroupMapID
				   ,1
				   ,@CustomerID
				   ,CURRENT_TIMESTAMP
				   ,@UserName
				   ,CURRENT_TIMESTAMP
				   ,@UserName )

			SET @TokenManagementID = scope_identity()

			COMMIT
	END TRY
	BEGIN CATCH
		IF ( @@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			exec dbo.uspRethrowError
		END

	END CATCH

END






GO
