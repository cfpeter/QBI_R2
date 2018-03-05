SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <10/18/2016>
-- Description:	<Delete all records from InvitationEmailLog for given contact>
-- =============================================
CREATE PROCEDURE [Temp].[uspDeleteInvitationEmailLogForContact]
	@ContactID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [Temp].[InvitationEmailLog]
	WHERE ContactID = @ContactID
END




GO
