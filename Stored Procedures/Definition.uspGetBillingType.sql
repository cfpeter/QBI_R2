SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet >
-- Create date: <8/2/2017 9:44:26 AM >
-- Description:	<Getting Billing Type >
-- =============================================
CREATE PROCEDURE  [Definition].[uspGetBillingType]

AS
BEGIN

	SET NOCOUNT ON;

	SELECT *
		FROM [Definition].[BillingType]
END









GO
