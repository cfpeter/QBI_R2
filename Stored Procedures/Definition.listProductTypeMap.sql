SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Definition].[listProductTypeMap]
@productName varchar(50)

AS
BEGIN
	SELECT ptm.ProductTypeMapID
		  ,ptm.ProductTypeID
		  ,ptm.ProductSubTypeID
		  ,pt.Name ProductTypeName
		  ,pst.Name ProductSubTypeName
	 FROM [Map].[ProductTypeMap] ptm
	  INNER JOIN [Definition].[ProductType] pt ON ptm.ProductTypeID = pt.ProductTypeID
	  INNER JOIN [Definition].[ProductSubType] pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID

	WHERE pt.Name = @productName
END








GO
