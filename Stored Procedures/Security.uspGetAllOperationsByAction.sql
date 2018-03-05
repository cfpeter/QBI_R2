SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <01/19/2016>
-- Description:	<Get all operations for given action>
-- =============================================
CREATE PROCEDURE [Security].[uspGetAllOperationsByAction]
	@ActionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT aom.ActionOperationID
		  ,aom.ActionID
		  ,o.OperationID
		  ,a.ActionGroupID
		  ,aom.Name ActionOperationName
		  ,o.Name OperationName
		  ,ag.Name ActionGroupName
		  FROM Map.ActionOperationMap aom
	INNER JOIN Definition.Action a ON aom.ActionID = a.ActionID
	INNER JOIN Definition.ActionGroup ag ON a.ActionGroupID = ag.ActionGroupID
	INNER JOIN Definition.Operation o ON aom.OperationID = o.OperationID
	Where aom.ActionID = @ActionID
	AND aom.IsActive = 1
END








GO
