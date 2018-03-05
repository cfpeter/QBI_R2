SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Shirak Avakian
-- Create date: 06/30/2017
-- Description:	List distribution type
-- =============================================
CREATE PROCEDURE [Definition].[uspListDistributionType]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM [Definition].[DistributionType]
END


GO
