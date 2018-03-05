SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian>
-- Create date: <03/09/2017>
-- Description:	<update the product workflow status >
-- =============================================
CREATE PROC [Workflow].[uspUpdateProductWorkflowStatus]
	  @ProductWorkflowID int
	 ,@StatusGroupMapID int 


AS 
BEGIN
	 
	
	BEGIN TRY 
		 

		UPDATE [map].[ProductWorkflow]
			SET
				 [UpdatedDateTime]	= CURRENT_TIMESTAMP 
				,[statusGroupMapID]	= @StatusGroupMapID 
				,[Note]				= 'status update'

			WHERE ProductWorkflowID = @ProductWorkflowID
 			
	 END TRy
	 BEGIN CATCH
		  if(@@TRANCOUNT > 0 )
			BEGIN
				ROLLBACK
				exec dbo.uspRethrowError
			END
	 END CATCH
END




GO
