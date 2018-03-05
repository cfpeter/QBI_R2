SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspRolloverProspect]
@EntityID int ,
@RollOver int  

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN

	 UPDATE [Customer].[Entity] 
			SET  
				Rollover = @RollOver

			WHERE EntityID = @EntityID
			
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
