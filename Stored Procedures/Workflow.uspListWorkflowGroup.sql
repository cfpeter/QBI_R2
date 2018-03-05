SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: 2/10/2017 
-- Description:	<get workflow groups>
-- =============================================
CREATE PROCEDURE [Workflow].[uspListWorkflowGroup]
	@CustomerID bigint,
	@ProductID bigint
AS
BEGIN 
	SET NOCOUNT ON;

   
	SELECT DISTINCT 
			 wig.[WorkflowItemGroupID]  
			,wig.[Name] WorkflowItemGroupName

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
	 WHERE	cust.CustomerID = @CustomerID 
			AND prd.ProductID = @ProductID 
			and wig.WorkflowItemGroupID IS NOT NULL
END


GO
