SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <05/16/2016>
-- Description:	<when adding a prospect , this storedProc will return all matching name to the user  to see whether this prospecr is exist or no by typeahead>
-- =============================================
CREATE PROCEDURE [Customer].[uspCheckProspectExist] 
	-- Add the parameters for the stored procedure here
	 @callerName varchar(50)
AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



SELECT 
		 e.EntityID
		,c.CustomerID
		,e.callerName
		,csm.Supervisor_PersonID supervisorID
		,csm.CustomerID customerIDForSupervisor
		,custt.Name CustomerType
		
FROM [Map].[CustomerSupervisorMap] csm

INNER JOIN [Customer].[Person] sup ON csm.Supervisor_PersonID = sup.PersonID
inner join [Customer].[Customer]c on csm.CustomerID = c.CustomerID 
LEFT JOIN  [Customer].[Entity] e ON c.EntityID = e.EntityID
INNER JOIN [Definition].CustomerType custt ON c.CustomerTypeID = custt.CustomerTypeID

where  e.CallerName Like(   @callerName + '%' )
AND c.IsActive = 1
AND custt.Name = 'Prospect'
END






GO
