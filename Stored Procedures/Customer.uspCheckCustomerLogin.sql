SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <011/8/2016>
-- Description:	<check if customer login ID exist >
-- =============================================
CREATE PROCEDURE [Customer].[uspCheckCustomerLogin]  

	 @customerID int
AS
BEGIN
 
SET NOCOUNT ON;

--declare @customerID int 

	SELECT 
		 c.customerID, l.LoginID
	FROM 
		[Customer].[Customer] c
		LEFT JOIN [Customer].[Login] l on c.CustomerID = l.CustomerID
	
	where c.CustomerID = @customerID
	AND c.IsActive = 1
	--AND l.IsActive = 1
		


END


GO
