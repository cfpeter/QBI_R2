SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <06/21/2017>
-- Description:	<List report type documents (pages) by given reportSubTypeID>
-- =============================================
CREATE PROCEDURE [Report].[uspListReportTypeDocumentByReportTypeMapID]
	@ReportTypeMapID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT rtm.*
	,dt.Name DocumentTypeName
	, dt.DocCode 
	, dt.TemplateName
	, dt.Location
	, dt.PrinterTray
	, dt.PaperSize
	, dt.PaperType
	, dt.PrintOrientation
	FROM [Map].ReportTypeDocument rtm
	LEFT JOIN [Definition].[DocumentType] dt ON rtm.DocumentTypeID = dt.DocumentTypeID
	WHERE ReportTypeMapID = @ReportTypeMapID
END


GO
