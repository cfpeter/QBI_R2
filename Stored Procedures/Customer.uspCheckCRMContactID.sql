SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <08/12/2016>
-- Description:	<check if crm contact id existin customer table >
-- =============================================
CREATE PROCEDURE [Customer].[uspCheckCRMContactID] 
	-- Add the parameters for the stored procedure here
	 @crmContactID int
AS
BEGIN
 
SET NOCOUNT ON; 

	SELECT 
		c.CRMContactID , c.customerID, l.LoginID
	FROM 
		[Customer].[Customer] c
		LEFT JOIN [Customer].[Login] l on c.CustomerID = l.CustomerID
	where
		c.CRMContactID = @crmContactID
 

END


GO
