SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <01/25/2017>
-- Description:	<Will insert all workflows by given product type>
-- =============================================
CREATE PROCEDURE [Workflow].[uspInsertAllProductWorkflowsByType] 
	 @ProductTypeMapID int,
	 @WorkflowTypeID int,
	 @ProductID bigint,
	 @UserName varchar(50),
	 @codeUUID varchar(250)=null,
	 @Note [dbo].[Note] = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @WorkflowIterator int
	DECLARE @BusinessWorkflowID int = null
	DECLARE @NewWorkflowId int
	DECLARE @NewName varchar(100)
	DECLARE @NewUUID varchar(250)
	DECLARE @NewDescription varchar(max)

    DECLARE @workflowID int = (SELECT count(WorkflowID) FROM [workflow].[workflow] WHERE ProductTypeMapID = @ProductTypeMapID )
	if(@workflowID = 0)
		BEGIN
			SET @ProductTypeMapID = 2
			SET @WorkflowTypeID = 2
		END

	SET @WorkflowIterator = 1	
	DECLARE Workflow_CURSOR CURSOR FOR 
		SELECT wf.WorkflowID
			  ,wfi.Name WorkflowTypeName
			  ,wf.UUIDCode
			  ,wfig.[Description]
	  
			FROM [Workflow].[Workflow] wf
			INNER JOIN [Definition].[WorkflowItem] wfi ON wf.WorkflowItemID = wfi.WorkflowItemID
			INNER JOIN [Definition].[WorkflowType] wft ON wf.WorkflowTypeID = wft.WorkflowTypeID
			LEFT JOIN [Map].[ProductTypeMap] ptm ON wf.ProductTypeMapID = ptm.ProductTypeMapID
			LEFT JOIN [Definition].[ProductSubType] pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID
			LEFT JOIN [Map].[WorkflowItemWorkflowItemGroup] wfig ON wfi.WorkflowItemID = wfig.WorkflowItemID
			WHERE ptm.ProductTypeMapID = @ProductTypeMapID
			AND wft.WorkflowTypeID = @WorkflowTypeID	
		
		--Open cursor
		OPEN Workflow_CURSOR

		--Loop through all business program map IDs to be cloned
		FETCH NEXT FROM Workflow_CURSOR --Get first row
		INTO @NewWorkflowId,@NewName,@NewUUID,@NewDescription	

		WHILE @@FETCH_STATUS = 0
		BEGIN		
			--increment counter
			SET @WorkflowIterator = @WorkflowIterator + 1

			exec [Workflow].[uspInsertProductWorkflow] 
				 @ProductID
				,@NewWorkflowId
				,@NewName 
				,@UserName
				,@codeUUID
				,@NewDescription
				,1
				,null  
				,@Note		
			--Get next row
			FETCH NEXT FROM Workflow_CURSOR
			INTO @NewWorkflowId,@NewName,@NewUUID,@NewDescription

		END
					
		--Close cursor
		CLOSE Workflow_CURSOR
		DEALLOCATE Workflow_CURSOR

END


GO
