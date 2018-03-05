SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <06/06/2017>
-- Description:	<Get Prospect by ID>
-- =============================================
CREATE PROCEDURE [Prospect].[uspGetProspectByID]
	@ProspectID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM [Customer].[Entity]
	WHERE EntityID = @ProspectID
END



GO
