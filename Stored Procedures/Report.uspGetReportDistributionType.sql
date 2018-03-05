SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ======================================================
-- Object:		[Report].[uspGetReportDistributionType]
-- Author:		Kenneth Leon
-- Create date: 06/12/2017
-- Description:	Get list of Report items allowed
-- ======================================================
CREATE PROCEDURE [Report].[uspGetReportDistributionType]

AS

BEGIN
	/* Result Set 1 - uspGetReportDistributionType */
	SELECT	dt.DistributionTypeID, dt.Name, dt.MaskID
	FROM	[Definition].[DistributionType] dt 
	WHERE	dt.IsActive = 1
	ORDER BY dt.SortOrder ASC
END

-- End


GO
