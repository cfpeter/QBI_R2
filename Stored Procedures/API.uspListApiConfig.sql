SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <09/14/2017>
-- Description:	<List Api.Config data>
-- =============================================
CREATE PROCEDURE [API].[uspListApiConfig] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [API].[Config]
END




GO
