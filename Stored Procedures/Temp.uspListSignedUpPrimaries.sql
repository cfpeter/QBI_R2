SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <10/26/2016>
-- Description:	<list primaries who already signed up>
-- =============================================
CREATE PROCEDURE [Temp].[uspListSignedUpPrimaries] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT cust.CustomerID
	   ,l.LoginID
	   ,elog.InvitationEmailLogID
	   ,cust.CRMClientID ClientID 
	   ,cust.CRMContactID contactID
	   ,l.IsActive 
	   ,l.LastLoginDateTime
	   ,elog.Fullname
	   ,elog.Email
	   ,elog.DateTimeSent
	   ,elog.[Count]
	   ,elog.Errored
	   ,elog.[Message]
	   ,elog.CreatedBy
	   ,elog.CreatedDateTime
	   ,elog.UpdatedBy
	   ,elog.UpdatedDateTime
	   ,elog.Notes
	 FROM Temp.InvitationEmailLog elog
	INNER JOIN [Customer].[Customer] cust on elog.ContactID = cust.CRMContactID
	INNER JOIN [Customer].[Login] l on cust.CustomerID = l.CustomerID
	Where DateTimeSent is not null 
END




GO
