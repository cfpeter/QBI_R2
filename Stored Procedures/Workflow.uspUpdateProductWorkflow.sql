SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Workflow].[uspUpdateProductWorkflow]
	 @ProductWorkflowID int
	,@actualFinishDate datetime = null
	--,@StatusGroupMapID int out


AS 
BEGIN
	
	if @actualFinishDate is NULL
		SET @actualFinishDate = CURRENT_TIMESTAMP  
	
	 
	-- EXECUTE [Customer].[uspGetStatusGroupMapIDByStatusNameAndStatusGroupname] 'Complete', 'workflow', @StatusGroupMapID out
	
	BEGIN TRY 
		 

		UPDATE [map].[ProductWorkflow]
			SET
				 [UpdatedDateTime]	= CURRENT_TIMESTAMP
				,[ActualFinishDate]	= @actualFinishDate
			--	,[statusGroupMapID]	= @StatusGroupMapID 

			WHERE ProductWorkflowID = @ProductWorkflowID
	
		SELECT 
			 pw.[ProductWorkflowID]
			,pw.[ProductID]
			,pw.[WorkflowID]
			,pw.[StatusGroupMapID]
			,pw.[Name]
			,pw.[IsActive]
			,pw.[CreatedDateTime]
			,pw.[ActualFinishDate]  
			,w.[DurationByDays] 
		FROM  [Map].[ProductWorkflow] pw
		LEFT JOIN [Workflow].[Workflow] w ON pw.WorkflowID = w.WorkflowID	
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
