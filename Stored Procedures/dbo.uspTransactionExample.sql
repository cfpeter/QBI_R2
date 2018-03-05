SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <02/026/2016>
-- Description:	<This store procedure is only for demo use and as example how to create transaction>
-- =============================================
CREATE PROCEDURE [dbo].[uspTransactionExample]
	@TrackingID int,
	@Username varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

    BEGIN TRY
		BEGIN TRAN

			-- YOUR SQL STATEMENT HERE
			-- IF SUCCESSFUL WILL COMMIT

		COMMIT
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK
		BEGIN
			INSERT INTO [Log].[Error]
			   ([TrackingID]
			   ,[Detail]
			   ,[IsResolved]
			   ,[CreatedDateTime]
			   ,[CreatedBy]
			   ,[UpdatedDateTime]
			   ,[UpdatedBy])
			VALUES
			   (@TrackingID
			   ,ERROR_MESSAGE()
			   ,0
			   ,GETDATE()
			   ,@Username
			   ,GETDATE()
			   ,@Username)
			
		END
		
		EXEC uspRethrowError
	END CATCH	
END









GO
