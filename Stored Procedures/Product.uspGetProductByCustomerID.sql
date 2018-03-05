SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ================================================
-- Author:		<Kenneth Leon>
-- Create date: <03/24/2017>
-- Description:	<Get product by given customerID>
-- ================================================
CREATE PROCEDURE [Product].[uspGetProductByCustomerID] 
	@CustomerID bigint

AS


BEGIN

	/*DECLARE @StatusGroupMapID int = ( SELECT StatusGroupMapID FROM [Customer].[Customer] where CustomerID = @CustomerID)
	DECLARE @statusActiveID int			= ( SELECT StatusID from [Definition].[Status] WHERE Name = 'Pending' )
	DECLARE @statusGroupProspectID int	= ( SELECT StatusGroupID from [Definition].[StatusGroup] WHERE Name = 'Prospect' )

	DECLARE @getPendingProspectStatusGroupMapID int = ( SELECT statusGroupMapID FROM [Map].[StatusGroupMap] where StatusID = @statusActiveID and StatusGroupID = @statusGroupProspectID )
 
	DECLARE @ProductTypeMapID int = (SELECT ProductTypeMapID  FROM [Business].[Product] WHERE CustomerID = @CustomerID and isProspect = 1 )  
	DECLARE @combo_productTypeMapID int = ( SELECT top(1) [PlanComboBreakdownID]  FROM [Map].[PlanComboBreakdown] WHERE ComboProductTypeMapID = @ProductTypeMapID )
	

	if( @StatusGroupMapID = @getPendingProspectStatusGroupMapID )
		BEGIN
			SELECT	p.*
				,pt.Name ProductTypeName
				,pst.Name ProductSubTypeName
				,po.Name ProductOriginName
				,per.FirstName + ' ' + per.LastName salesPersonName
			FROM	Business.Product p	
						INNER JOIN Map.ProductTypeMap ptm ON p.ProductTypeMapID = ptm.ProductTypeMapID
						INNER JOIN Definition.ProductType pt ON ptm.ProductTypeID = pt.ProductTypeID
						INNER JOIN Definition.ProductSubType pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID
						LEFT JOIN Definition.ProductOrigin po ON p.ProductOriginID = po.ProductOriginID
						LEFT JOIN Customer.[Person] per on p.SalesPersonID = per.PersonID
			WHERE	p.CustomerID = @CustomerID 
			AND  p.isProspect = 1 
			--AND  p.isProspect is NULL 
		END
	ELSE
		BEGIN
			SELECT	p.*
				,pt.Name ProductTypeName
				,pst.Name ProductSubTypeName
				,po.Name ProductOriginName
				,per.FirstName + ' ' + per.LastName salesPersonName
			FROM	Business.Product p	
						INNER JOIN Map.ProductTypeMap ptm ON p.ProductTypeMapID = ptm.ProductTypeMapID
						INNER JOIN Definition.ProductType pt ON ptm.ProductTypeID = pt.ProductTypeID
						INNER JOIN Definition.ProductSubType pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID
						LEFT JOIN Definition.ProductOrigin po ON p.ProductOriginID = po.ProductOriginID
						LEFT JOIN Customer.[Person] per on p.SalesPersonID = per.PersonID
			WHERE	p.CustomerID = @CustomerID 
			AND (  p.isProspect IS NULL OR p.isProspect = 0)
		END
	
	*/
	
	
	 SELECT	p.*
				,pt.Name ProductTypeName
				,pst.Name ProductSubTypeName
				,po.Name ProductOriginName
				,per.FirstName + ' ' + per.LastName salesPersonName
			FROM	Business.Product p	
						INNER JOIN Map.ProductTypeMap ptm ON p.ProductTypeMapID = ptm.ProductTypeMapID
						INNER JOIN Definition.ProductType pt ON ptm.ProductTypeID = pt.ProductTypeID
						INNER JOIN Definition.ProductSubType pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID
						LEFT JOIN Definition.ProductOrigin po ON p.ProductOriginID = po.ProductOriginID
						LEFT JOIN Customer.[Person] per on p.SalesPersonID = per.PersonID
			WHERE	p.CustomerID = @CustomerID 
	
	SELECT p.productID, COUNT(DISTINCT pam.ProductAdvisorMapID) AS advisors, COUNT(DISTINCT ptm.ProductTrusteeID) AS trustees, COUNT(DISTINCT pbm.ProductBillingConfigMapID) AS billings FROM [Business].[Product] p
	LEFT JOIN [Map].[ProductAdvisorMap] pam ON pam.ProductID = p.ProductID
	LEFT JOIN [Map].[ProductTrusteeMap] ptm ON ptm.ProductID = p.ProductID
	LEFT JOIN [Map].[ProductBillingConfigMap] pbm ON pbm.ProductID = p.ProductID
	WHERE p.ProductID IN (SELECT productID FROM [Business].[Product] WHERE CustomerID = @CustomerID)
	GROUP BY p.productID;
END



GO
