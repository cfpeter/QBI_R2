SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <02/16/2017>
-- Description:	<get workflow memo >
-- =============================================
CREATE PROCEDURE  [Business].[uspGetWorkflowMemoByProductWorkflowID]
@ProductWorkflowID int
AS
BEGIN 
	SET NOCOUNT ON;
	 
	SELECT 
		wmm.WorkflowMemoMapID,
		cust.CustomerID,
		wmm.MemoID,  
		wmm.productWorkflowID,
		e.EntityID,
		m.Memo Memo,
		m.CreatedBy,
		m.CreatedDateTime,
		m.UpdatedBy,
		m.UpdatedDateTime
	FROM [Map].[WorkflowMemoMap] wmm
	INNER JOIN [Customer].[Entity]e on wmm.EntityID = e.EntityID
	INNER JOIN [Business].[Memo] m ON wmm.MemoID = m.MemoID
	INNER JOIN [Customer].[Customer] cust ON e.EntityID = cust.EntityID 
	WHERE wmm.productWorkflowID = @ProductWorkflowID
	ORDER BY m.CreatedDateTime DESC
END


GO
