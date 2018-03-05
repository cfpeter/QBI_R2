SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <04/5/2016>
-- Description:	<get memo by entity id>
-- =============================================
CREATE PROCEDURE  [Business].[uspGetEntityMemoByID]
@EntityID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here\
	SELECT 
		cust.CustomerID,
		emm.MemoID, 
		e.EntityID, 
		e.CallerName,
		m.Name MemoName,
		m.Memo Memo,
		m.CreatedBy,
		m.CreatedDateTime,
		m.UpdatedBy,
		m.UpdatedDateTime
	FROM [Map].[EntityMemoMap] emm
	INNER JOIN [Customer].[Entity]e on emm.EntityID = e.EntityID
	INNER JOIN [Business].[Memo] m ON emm.MemoID = m.MemoID
	INNER JOIN [Customer].[Customer] cust ON e.EntityID = cust.EntityID 
	WHERE emm.EntityID = @EntityID
	ORDER BY m.CreatedDateTime DESC
END









GO
