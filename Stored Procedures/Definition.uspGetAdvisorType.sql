SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian	>
-- Create date: <08/08/2017>
-- Description:	<Get advisor typeD>
-- =============================================
CREATE PROCEDURE [Definition].[uspGetAdvisorType] 
AS
BEGIN 
	SET NOCOUNT ON;
	 
	SELECT * 
	FROM [Definition].[AdvisorType] 
END





GO
