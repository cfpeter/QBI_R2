SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <01/30/2017>
-- Description:	<List product workflow by given customer and product>
-- =============================================
CREATE PROCEDURE [Workflow].[uspListProductWorkflow] 
	@CustomerID bigint,
	@ProductID bigint,
	@WorkflowItemGroupID int = NULL --added by peter on 2/13/2017
AS
BEGIN 
	SET NOCOUNT ON;
	 
	if @WorkflowItemGroupID IS NULL
		BEGIN
			SELECT pw.[ProductWorkflowID]
			  ,prd.[ProductID]
				  ,cust.CustomerID
				  ,w.[WorkflowID]
				  ,w.WorkflowTypeID
				  ,wigm.WorkflowItemWorkflowItemGroupID
				  ,sgm.[StatusGroupMapID]
				  ,wig.Name WorkflowItemGroupName	--typo change by peter 2/13/2017
				  ,st.Name StatusName
				  ,w.[Name] WorkflowName
				  ,wt.[Name] WorkflowTypeName
				  ,w.DurationByDays
				  ,w.CompletionOption -- added by peter on 2/14/2017
				  ,pw.StartDate
				  ,pw.ProjectedFinishDate
				  ,pw.ActualFinishDate
				  ,pw.NextReminderDate
				  ,pw.[UUIDCode]
				  ,pw.[Description]
				  ,pw.[IsActive]
				  ,pw.[SortOrder]
				  ,pw.[CreatedDateTime]
				  ,pw.[CreatedBy]
				  ,pw.[UpdatedDateTime]
				  ,pw.[UpdatedBy]
				  ,pw.[Note] 
				 -- ,pw.CreatedDateTime   --changed by peter on 3/6/2017
				  ,ent.EntityID		-- added by peter on 2/15/2017
			  FROM [Map].[ProductWorkflow] pw
			  INNER JOIN [Business].[Product] prd ON pw.ProductID = prd.ProductID
			  INNER JOIN [Customer].[Customer] cust ON prd.CustomerID = cust.CustomerID
			  LEFT JOIN [Workflow].[Workflow] w ON pw.WorkflowID = w.WorkflowID
			  LEFT JOIN [Definition].[WorkflowType] wt ON w.WorkflowTypeID = wt.WorkflowTypeID
			  LEFT JOIN [Definition].[WorkflowItem] wi ON w.WorkflowItemID = wi.WorkflowItemID
			  LEFT JOIN [Map].[WorkflowItemWorkflowItemGroup] wigm ON wi.WorkflowItemID = wigm.WorkflowItemID
			  LEFT JOIN [Definition].[WorkflowItemGroup] wig ON wigm.WorkflowItemGroupID = wig.WorkflowItemGroupID
			  LEFT JOIN [Map].[StatusGroupMap] sgm ON pw.StatusGroupMapID = sgm.StatusGroupMapID
			  LEFT JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
			  LEFT JOIN [Customer].[Entity] ent ON prd.ProductID = ent.ProductID
			  WHERE cust.CustomerID = @CustomerID 
			  AND prd.ProductID = @ProductID
			  AND w.IsActive = 1
		END
	else --typo change by peter 2/13/2017
		BEGIN
			SELECT pw.[ProductWorkflowID]
				  ,prd.[ProductID]
					  ,cust.CustomerID
					  ,w.[WorkflowID]
					  ,w.WorkflowTypeID
					  ,wigm.WorkflowItemWorkflowItemGroupID
					  ,sgm.[StatusGroupMapID]
					  ,wig.Name WorkflowItemGroupName	
					  ,st.Name StatusName
					  ,w.[Name] WorkflowName
					  ,wt.[Name] WorkflowTypeName
					  ,w.DurationByDays
					  ,w.CompletionOption -- added by peter on 2/14/2017
					  ,pw.StartDate
					  ,pw.ProjectedFinishDate
					  ,pw.ActualFinishDate
					  ,pw.NextReminderDate
					  ,pw.[UUIDCode]
					  ,pw.[Description]
					  ,pw.[IsActive]
					  ,pw.[SortOrder]
					  ,pw.[CreatedDateTime]
					  ,pw.[CreatedBy]
					  ,pw.[UpdatedDateTime]
					  ,pw.[UpdatedBy]
					  ,pw.[Note] 
					  --,pw.CreatedDateTime  --changed by peter on 3/6/2017
					  ,ent.EntityID		-- added by peter on 2/15/2017
				  FROM [Map].[ProductWorkflow] pw
				  INNER JOIN [Business].[Product] prd ON pw.ProductID = prd.ProductID
				  INNER JOIN [Customer].[Customer] cust ON prd.CustomerID = cust.CustomerID
				  LEFT JOIN [Workflow].[Workflow] w ON pw.WorkflowID = w.WorkflowID
				  LEFT JOIN [Definition].[WorkflowType] wt ON w.WorkflowTypeID = wt.WorkflowTypeID
				  LEFT JOIN [Definition].[WorkflowItem] wi ON w.WorkflowItemID = wi.WorkflowItemID
				  LEFT JOIN [Map].[WorkflowItemWorkflowItemGroup] wigm ON wi.WorkflowItemID = wigm.WorkflowItemID
				  LEFT JOIN [Definition].[WorkflowItemGroup] wig ON wigm.WorkflowItemGroupID = wig.WorkflowItemGroupID
				  LEFT JOIN [Map].[StatusGroupMap] sgm ON pw.StatusGroupMapID = sgm.StatusGroupMapID
				  LEFT JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
				  LEFT JOIN [Customer].[Entity] ent ON prd.ProductID = ent.ProductID
				  WHERE cust.CustomerID = @CustomerID 
				  AND prd.ProductID = @ProductID
				  AND wig.WorkflowItemGroupID = @WorkflowItemGroupID
				  AND w.IsActive = 1
		END
	   
		
END


GO
