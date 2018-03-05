SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <08/23/2016>
-- Description:	<Show record count for total sales by month and by sales person>
-- =============================================
CREATE PROCEDURE [Report].[uspListTotalSalesByMonthAndBySalesPerson]
	
AS
BEGIN

	SET NOCOUNT ON;
	  DECLARE @CustomerTypeID int = ( Select CustomerTypeID FROM [Definition].CustomerType WHERE Name = 'Prospect')
	  DECLARE @StatusID int = (SELECT StatusID FROM [Definition].[Status] WHERE Name = 'Terminated' )
	  DECLARE @StatusGroupID int = (SELECT StatusGroupID  FROM [Definition].[StatusGroup] WHERE Name = 'Prospect' )
	  DECLARE @StatusGroupMapID int = ( Select StatusGroupMapID FROM [MAP].[StatusGroupMap] WHERE StatusID = @StatusID AND StatusGroupID = @StatusGroupID )

	  SELECT-- p.FirstName + ' ' + p.LastName SalesPerson 
			 MONTH(c.UpdatedDateTime) As TheMonth
			,YEAR(c.UpdatedDateTime)  As TheYear
			,COUNT(c.CustomerID)  As SalesCount
			--,c.SalesPersonID

		
	  FROM [Customer].[Customer] c
		--INNER JOIN [Customer].[Person] p (NOLOCK) on c.SalesPersonID = p.PersonID
		INNER JOIN [Customer].[Entity] e (NOLOCK) on c.EntityID = e.EntityID

	  WHERE c.IsActive = 1
		AND c.EntityID is not NULL
		AND c.CustomerTypeID = @CustomerTypeID
		AND c.StatusGroupMapID != @StatusGroupMapID
		AND YEAR(c.UpdatedDateTime) = YEAR( CURRENT_TIMESTAMP) 
		AND DATEADD(dd, 0, DATEDIFF(dd, 0, c.UpdatedDateTime )) BETWEEN DATEADD(mm, -6, CURRENT_TIMESTAMP) and CURRENT_TIMESTAMP
				
		GROUP BY YEAR(c.UpdatedDateTime), MONTH(c.UpdatedDateTime)--, p.FirstName,p.LastName,c.SalesPersonID
		ORDER BY YEAR(c.UpdatedDateTime), MONTH(c.UpdatedDateTime)--, p.FirstName,p.LastName,c.SalesPersonID
END



GO
