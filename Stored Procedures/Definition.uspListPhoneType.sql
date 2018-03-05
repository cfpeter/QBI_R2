SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Kenneth Leon>
-- Create date: <03/07/2017>
-- Description:	<List of phone type>
-- =============================================
CREATE PROCEDURE [Definition].[uspListPhoneType] 

AS
BEGIN

    -- Insert statements for procedure here
	SELECT	PhoneTypeID, Name, [Description]
	FROM	[Definition].[PhoneType]
	ORDER BY SortOrder
END


GO
