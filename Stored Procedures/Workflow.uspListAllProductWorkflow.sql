SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		peter garabedian 
-- Create date:  today						jk :)  3/3/2017 3:29:45 PM
-- Description:	 get all the productworkflow
-- =============================================
CREATE PROCEDURE [Workflow].[uspListAllProductWorkflow] 

AS
BEGIN 
	SET NOCOUNT ON;

   
	SELECT  
			 pw.[ProductWorkflowID]
			,pw.[ProductID]
			,pw.[WorkflowID]
			,pw.[StatusGroupMapID]
			,pw.[Name]
			,pw.[IsActive]
			,pw.[CreatedDateTime]
			,pw.[ActualFinishDate]  
			,ent.[CreatedDateTime] EntityCreatedDateTime
			,st.[Name] StatusName
			,w.[DurationByDays] 
			,cust.CustomerID
			,ent.EntityID

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
	 
	 where pw.IsActive = 1
END


GO
