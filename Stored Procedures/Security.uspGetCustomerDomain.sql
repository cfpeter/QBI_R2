SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian
-- Create date: <01/04/2016>
-- Description:	<Get customer domain group by loginID and authentication type>
-- =============================================
CREATE PROCEDURE [Security].[uspGetCustomerDomain]
	@LoginID int,
	@AuthenticationType varchar(20),
	@NetworkDomainGroup varchar(30) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF(@AuthenticationType = 'SSO' and @NetworkDomainGroup is not null)
	BEGIN
		SELECT lm.LoginMapID
			  ,lm.LoginID
			  ,lm.AuthenticationTypeID
			  ,at.[Name] AuthenticationType
			  ,dgm.HomeHandler -- added by SA 9/20/2017 1.5.6
			  ,dgm.NextEvent -- added by SA 9/20/2017 1.5.6
			  ,dgm.DomainGroupMapID
			  ,dgm.DomainGroupOverrideID
			  ,dgo.[Name] DomainGroupOverride
			  ,dgm.DomainGroupID
		      ,dg.[Name] DomainGroup
	    FROM [Map].[LoginMap] lm
			  INNER JOIN [Definition].[AuthenticationType] at on lm.AuthenticationTypeID = at.AuthenticationTypeID
			  INNER JOIN [Map].[DomainGroupMap] dgm on lm.DomainGroupMapID = dgm.DomainGroupMapID
			  INNER JOIN [Definition].[DomainGroup] dg on dgm.DomainGroupID = dg.DomainGroupID
			  INNER JOIN [Definition].[DomainGroupOverride] dgo on dgm.DomainGroupOverrideID = dgo.DomainGroupOverrideID
	    WHERE LoginID = @LoginID
			  AND at.[Name] = @AuthenticationType
			  AND dgo.Name = @NetworkDomainGroup
			  AND dgm.IsActive = 1
			  AND lm.IsActive = 1
	END
	ELSE IF (@AuthenticationType = 'Basic')
	BEGIN
		SELECT lm.LoginMapID
			  ,lm.LoginID
			  ,lm.AuthenticationTypeID
			  ,at.[Name] AuthenticationType
			  ,dgm.HomeHandler -- added by SA 9/20/2017 1.5.6
			  ,dgm.NextEvent -- added by SA 9/20/2017 1.5.6
			  ,dgm.DomainGroupMapID
			  ,dgm.DomainGroupOverrideID
			  ,dgo.[Name] DomainGroupOverride
			  ,dgm.DomainGroupID
		      ,dg.[Name] DomainGroup
	    FROM [Map].[LoginMap] lm
			  INNER JOIN [Definition].[AuthenticationType] at on lm.AuthenticationTypeID = at.AuthenticationTypeID
			  INNER JOIN [Map].[DomainGroupMap] dgm on lm.DomainGroupMapID = dgm.DomainGroupMapID
			  INNER JOIN [Definition].[DomainGroup] dg on dgm.DomainGroupID = dg.DomainGroupID
			  INNER JOIN [Definition].[DomainGroupOverride] dgo on dgm.DomainGroupOverrideID = dgo.DomainGroupOverrideID
	    WHERE LoginID = @LoginID
			  AND at.[Name] = @AuthenticationType
			  AND dgm.IsActive = 1
			  AND lm.IsActive = 1
			  
	END
	ELSE
	BEGIN
		SELECT lm.LoginMapID
			  ,lm.LoginID
			  ,lm.AuthenticationTypeID
			  ,at.[Name] AuthenticationType
			  ,dgm.HomeHandler -- added by SA 9/20/2017 1.5.6
			  ,dgm.NextEvent -- added by SA 9/20/2017 1.5.6
			  ,dgm.DomainGroupMapID
			  ,dgm.DomainGroupOverrideID
			  ,dgo.[Name] DomainGroupOverride
			  ,dgm.DomainGroupID
		      ,dg.[Name] DomainGroup
	    FROM [Map].[LoginMap] lm
			  INNER JOIN [Definition].[AuthenticationType] at on lm.AuthenticationTypeID = at.AuthenticationTypeID
			  INNER JOIN [Map].[DomainGroupMap] dgm on lm.DomainGroupMapID = dgm.DomainGroupMapID
			  INNER JOIN [Definition].[DomainGroup] dg on dgm.DomainGroupID = dg.DomainGroupID
			  INNER JOIN [Definition].[DomainGroupOverride] dgo on dgm.DomainGroupOverrideID = dgo.DomainGroupOverrideID
	    WHERE LoginID = @LoginID
			  AND at.[Name] = @AuthenticationType
			  AND dgm.IsActive = 1
			  AND lm.IsActive = 1
			  
	END

END










GO
