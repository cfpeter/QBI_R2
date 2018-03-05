SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <07/29/2016>
-- Description:	<Get Status(s) by given group>
-- =============================================
CREATE PROCEDURE [Definition].[uspListStatusByGoupName] 
	@GroupName varchar(50) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF( @GroupName is null)
	BEGIN
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
	END
	ELSE
	BEGIN
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
		WHERE sg.Name = @GroupName
	END
	
END





GO
