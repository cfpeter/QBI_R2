SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <11/11/2017>
-- Description:	<get product type map id by givin productsubtype name and product type>
-- =============================================
Create PROCEDURE [Product].[uspGetProductTypeMapIDByProductSubTypeAndProductType]
	 @ProductSubTypeName varchar(45)
	,@productTypeName varchar(45)
AS
BEGIN
	SELECT productTypeMapID FROM [Map].[ProductTypeMap] ptm 
	INNER JOIN [Definition].[ProductType] pt ON ptm.ProductTypeID = pt.ProductTypeID
	INNER JOIN [Definition].[ProductSubType] pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID

	WHERE pst.Name = @ProductSubTypeName
	AND pt.Name = @productTypeName
END







GO
