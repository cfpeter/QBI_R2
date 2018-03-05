SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <06/06/2017>
-- Description:	<Get OrganizationBranch by ID>
-- =============================================
CREATE PROCEDURE [Organization].[uspGetOrganizationBranchByID]
	@OrganizationBranchID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM [Customer].[OrganizationBranch]
	WHERE OrganizationBranchID = @OrganizationBranchID
END












GO
