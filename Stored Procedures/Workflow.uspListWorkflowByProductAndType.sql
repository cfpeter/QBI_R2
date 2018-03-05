SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <01/24/2017>
-- Description:	<list workflows (todo) items per giver product and workflow type>
-- =============================================
CREATE PROCEDURE [Workflow].[uspListWorkflowByProductAndType] 
	-- Add the parameters for the stored procedure here
	@ProductTypeMapID int,
	@WorkflowTypeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT wf.WorkflowID
	  ,wfi.Name WorkflowName
	  ,wf.UUIDCode
	  ,wf.[Description]
	  ,wf.TemplateName
	  ,wft.Name WorkflowTypeName
	  ,wfig.Name WorkflowGroupName
	  ,pst.Name ProductSubTypeName
	  ,wf.IsActive
	  ,wf.CreatedDateTime
	  ,wf.CreatedBy
	  ,wf.UpdatedDateTime
	  ,wf.UpdatedBy
	  ,wf.Note
	FROM [Workflow].[Workflow] wf
	INNER JOIN [Definition].[WorkflowItem] wfi ON wf.WorkflowItemID = wfi.WorkflowItemID
	INNER JOIN [Definition].[WorkflowType] wft ON wf.WorkflowTypeID = wft.WorkflowTypeID
	LEFT JOIN [Map].[ProductTypeMap] ptm ON wf.ProductTypeMapID = ptm.ProductTypeMapID
	LEFT JOIN [Definition].[ProductSubType] pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID
	LEFT JOIN [Map].[WorkflowItemWorkflowItemGroup] wfig ON wfi.WorkflowItemID = wfig.WorkflowItemID
	WHERE ptm.ProductTypeMapID = @ProductTypeMapID
	AND wft.WorkflowTypeID = @WorkflowTypeID
END


GO
