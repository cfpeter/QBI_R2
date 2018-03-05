SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <02/6/2018>
-- Description:	<Search EIN by EIN number>
-- =============================================
CREATE PROC [Organization].[uspCheckEIN]
	
	@EIN varchar(50)
		
AS 
BEGIN
	BEGIN TRY 		 
			
			SELECT * FROM [Customer].[Organization]
			WHERE EIN = @EIN
			 
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
