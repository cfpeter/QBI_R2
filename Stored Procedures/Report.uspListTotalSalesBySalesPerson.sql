SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <08/22/2016>
-- Description:	<List total sales count by sales person>
-- =============================================
CREATE PROCEDURE [Report].[uspListTotalSalesBySalesPerson] 
	
AS
BEGIN
	
	SELECT  p.FirstName + ' ' + p.LastName SalesPerson 
		,COUNT([SalesPersonID])  As SalesCount
		
	FROM [Customer].[Customer] c
	INNER JOIN [Customer].[Person] p (NOLOCK) on c.SalesPersonID = p.PersonID

	WHERE [SalesPersonID] is not NULL
			
	GROUP BY p.FirstName,p.LastName
	ORDER BY p.LastName
END



GO
