SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <04/26/2016>
-- Description:	<List terminated prospect >
-- =============================================
CREATE PROCEDURE  [Customer].[uspListTerminatedProspect]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here	
	SELECT cust.CustomerID,
		   e.EntityID, 
		   e.CallerName,
		   e.Name EntityName,
		   s.Name StatusName,
		   ct.Name customerType
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
	 

WHERE cust.IsActive = 0 

ORDER BY e.CreatedDateTime
 
END








GO
