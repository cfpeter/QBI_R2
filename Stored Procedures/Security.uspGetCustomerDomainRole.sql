SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <01/04/2016>
-- Description:	<Get current customer domain role, action, and operation>
-- =============================================
CREATE PROCEDURE [Security].[uspGetCustomerDomainRole] 
	@DomainGroupMapID bigint,
	@SolutionName varchar(30)
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

	FROM [Map].[DomainRoleMap] drm
		INNER JOIN [Definition].[Solution] s on drm.SolutionID = s.SolutionID
		INNER JOIN [Definition].Role r on drm.RoleID = r.RoleID
		INNER JOIN [Map].RoleActionMap ram on r.RoleID = ram.RoleID
		INNER JOIN [Definition].Action a on ram.ActionID = a.ActionID
		LEFT JOIN [Definition].ActionGroup ag on a.ActionGroupID = ag.ActionGroupID
	WHERE DomainGroupMapID = @DomainGroupMapID
	AND s.Name = @SolutionName
	AND ram.IsActive = 1
	AND drm.IsActive = 1
END






GO
