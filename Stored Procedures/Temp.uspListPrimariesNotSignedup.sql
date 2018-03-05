SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <10/26/2016>
-- Description:	<list primaries who already signed up>
-- =============================================
CREATE PROCEDURE [Temp].[uspListPrimariesNotSignedup] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT elog.InvitationEmailLogID
		,elog.ContactID
	    ,elog.ClientID
		,elog.ContactID
		,elog.[Count]
		,elog.Email
		,elog.Fullname
		,elog.DateTimeSent
		,elog.Errored
		,elog.[Message]
		,elog.UpdatedBy
		,elog.UpdatedDateTime
		,elog.CreatedBy
		,elog.CreatedDateTime
		
	FROM Temp.InvitationEmailLog elog
	EXCEPT  
	SELECT elog.InvitationEmailLogID 
		   ,elog.ContactID
		   ,elog.ClientID
		   ,elog.ContactID
		   ,elog.[Count]
		   ,elog.Email
		   ,elog.Fullname
		   ,elog.DateTimeSent
		   ,elog.Errored
		   ,elog.[Message]
		   ,elog.UpdatedBy
		   ,elog.UpdatedDateTime
		   ,elog.CreatedBy
		   ,elog.CreatedDateTime

	FROM Temp.InvitationEmailLog elog
	INNER JOIN Customer.Customer cust on elog.ContactID = cust.CRMContactID



END




GO
