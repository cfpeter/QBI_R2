SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <03/01/2017>
-- Description:	<List similar organization by given keyword. used in type ahead>
-- =============================================
CREATE PROCEDURE [Organization].[uspListSimilarOrganization] 
	@Keyword varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT OrganizationID ID,  Name
	FROM [Customer].[Organization]
	WHERE [Name] like (@Keyword + '%')
END


GO
