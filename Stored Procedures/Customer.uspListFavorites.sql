SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <04/5/2016>
-- Description:	<List favorites >
-- =============================================
CREATE PROCEDURE  [Customer].[uspListFavorites]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here	
	SELECT cust.CustomerID,
		   e.EntityID,
		   e.Favorite,
		   e.CallerName,
		   e.Name EntityName,
		   s.Name StatusName,
		   m.Memo
		,ct.Name customerType
	  ,csm.Supervisor_PersonID supervisorID
	  ,csm.CustomerID customerIDForSupervisor

	--FROM [Customer].[Customer] cust 
	 FROM [Map].[CustomerSupervisorMap] csm
	 
	 INNER JOIN [Customer].[Person] sup ON csm.Supervisor_PersonID = sup.PersonID
	 INNER JOIN [Customer].[Customer] cust ON csm.CustomerID = cust.CustomerID
	 INNER JOIN [Customer].[Entity] e ON cust.EntityID = e.EntityID 
	 INNER JOIN [map].[StatusGroupMap] sgm ON cust.StatusGroupMapID = sgm.StatusGroupMapID
	 INNER JOIN [Definition].[Status] s ON sgm.StatusID = s.StatusID -- ON e.EntityID = cust.EntityID and cust.EntityID is not null
	 INNER JOIN [Definition].[CustomerType] ct on cust.CustomerTypeID = ct.CustomerTypeID
	 LEFT JOIN (
		SELECT EntityID, max(CreatedDateTime) as MaxRowDate
		FROM [Map].[EntityMemoMap]
		GROUP BY EntityID
	) bm ON bm.EntityID = e.EntityID
	LEFT JOIN [Map].[EntityMemoMap] emm ON bm.EntityID = emm.EntityID
		and bm.MaxRowDate = emm.CreatedDateTime
	LEFT join [Business].[Memo] m ON emm.MemoID = m.MemoID
WHERE e.Favorite = 1
AND cust.IsActive = 1
AND sgm.[Description] <> 'Active Customer'
ORDER BY e.CreatedDateTime

END








GO
