SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet >
-- Create date: <8/2/2017 11:42:26 AM >
-- Description:	<Getting Billing Frequency >
-- =============================================
CREATE PROCEDURE  [Definition].[uspGetBillingFrequency]

AS
BEGIN

	SET NOCOUNT ON;

	SELECT *
		FROM [Definition].[BillingFrequency]
END









GO
