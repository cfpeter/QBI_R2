SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Definition].[uspGetStateIDByKeyWord]
	
	@keyword varchar(20)
	--@stateID int out
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN		

		SELECT [StateID], [Code]
			FROM [Definition].[State]
			WHERE @keyword LIKE Name
			OR	@keyword LIKE Code

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
