SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <7/30/2016>
-- Description:	<Get business status (statusMap) by given status map ID>
-- =============================================
CREATE PROCEDURE [Business].[uspGetBusinessStatusByID] 
	@StatusGroupMapID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT sgm.StatusGroupMapID 
			,s.StatusID	
			,sg.StatusGroupID
			,s.Name StatusName
			,sg.Name StatusGroupName
			,sgm.CreatedBy
			,sgm.CreatedDateTime
			,sgm.UpdatedBy
			,sgm.UpdatedDateTime
		FROM [Map].[StatusGroupMap] sgm
		INNER JOIN [Definition].[Status] s on sgm.StatusID = s.StatusID
		INNER JOIN [Definition].[StatusGroup] sg on sgm.StatusGroupID = sg.StatusGroupID
		WHERE sgm.StatusGroupMapID = @StatusGroupMapID
END





GO
