SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak	Avakian>
-- Create date: <10/20/2016>
-- Description:	<Get customerID for main given client. This is the main client customer ID not the contact>
-- =============================================
CREATE PROCEDURE [Customer].[uspGetCustomerIDForMainClient]
	@ClientID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT CustomerID	  
	FROM [Customer].[Customer] cust 
	WHERE cust.CRMClientID = @ClientID
	AND cust.IsActive = 1
	AND cust.IsPrimary = 1
	AND cust.MainClient = 1
	
END




GO
