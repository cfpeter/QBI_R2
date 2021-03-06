SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <02/05/2016>
-- Description:	<Get customer role, action, for given customer id>
-- =============================================
CREATE PROCEDURE [Security].[uspGetCustomerDomainRoleByCustomerID] 
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT drm.DomainRoleMapID
			,drm.Name DomainRoleMap 
			,s.SolutionID
			,s.Name SolutionName
			,r.RoleID			
			,r.Name [Role]	
			,a.ActionID		
			,a.Name ActionName
			,a.Label
			,a.Handler
			,ag.ActionGroupID
			,ag.Name ActionGroupName

	FROM [Customer].Customer cust
		INNER JOIN [Customer].[Login] l ON cust.CustomerID = l.CustomerID
		INNER JOIN [Map].[LoginMap] lm ON l.LoginID = lm.LoginID
		INNER JOIN [Map].[DomainGroupMap] dgm ON lm.DomainGroupMapID = dgm.DomainGroupMapID
		INNER JOIN [Map].[DomainRoleMap] drm ON dgm.DomainGroupMapID = drm.DomainGroupMapID
		INNER JOIN [Definition].[Solution] s on drm.SolutionID = s.SolutionID
		INNER JOIN [Definition].Role r on drm.RoleID = r.RoleID
		INNER JOIN [Map].RoleActionMap ram on r.RoleID = ram.RoleID
		INNER JOIN [Definition].[Action] a on ram.ActionID = a.ActionID
		LEFT JOIN [Definition].ActionGroup ag on a.ActionGroupID = ag.ActionGroupID
	WHERE cust.CustomerID = @CustomerID
	AND ram.IsActive = 1
	AND drm.IsActive = 1
END






GO
