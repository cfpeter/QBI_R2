SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ======================================================
-- Object:		[Report].[uspGetReportAndSubTypeByRoleID]
-- Author:		Kenneth Leon
-- Create date: 06/07/2017
-- Description:	Get list of Report items allowed
-- ======================================================
CREATE PROCEDURE [Report].[uspGetReportAndSubTypeByRoleID] 
	@RoleID int

AS

BEGIN
	/* Result Set 1 - getReportType */
	SELECT	rt.ReportTypeID, rt.Name 
	FROM	[Definition].[ReportType] rt 
	WHERE	rt.ReportTypeID IN (SELECT	ReportTypeID 
								FROM	[Map].[ReportTypeMap]
								WHERE	ReportTypeMapID IN (SELECT	ReportTypeMapID
															FROM	[Map].[ReportTypeRoleMap]
															WHERE	RoleID = @RoleID
															AND IsActive = 1))
	ORDER BY rt.Name

	/* Result Set 2 - getReportSubType */
	SELECT	rtm.ReportTypeMapID, rtm.ReportTypeID, rtm.ReportSubTypeID, rst.Name, rst.Template
	FROM	[Map].[ReportTypeMap] rtm INNER JOIN [Definition].[ReportSubType] rst ON rtm.ReportSubTypeID = rst.ReportSubTypeID
	WHERE	rtm.ReportTypeMapID IN (SELECT	ReportTypeMapID
									FROM	[Map].[ReportTypeRoleMap]
									WHERE	RoleID = @RoleID
									AND IsActive = 1)
	ORDER BY rtm.ReportTypeID, rst.Name
END


-- End





GO
