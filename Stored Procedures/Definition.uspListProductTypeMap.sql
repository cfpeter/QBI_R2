SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Definition].[uspListProductTypeMap]
@productName varchar(50),
@option varchar(50)

AS
BEGIN

	IF @option = 'sales'
	BEGIN
		SELECT ptm.ProductTypeMapID
			  ,ptm.ProductTypeID
			  ,ptm.ProductSubTypeID
			  ,pt.Name ProductTypeName
			  ,pst.Name ProductSubTypeName
			  ,pst.Description ProductSubTypeDescription
			  ,pst.MoreInfoURL -- Hamlet 1/19/18 - added url links to redirect to QBI website
		 FROM [Map].[ProductTypeMap] ptm
		  INNER JOIN [Definition].[ProductType] pt ON ptm.ProductTypeID = pt.ProductTypeID
		  INNER JOIN [Definition].[ProductSubType] pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID

		WHERE pt.Name = @productName
		AND pst.ActiveForSales = 1
	END
	ELSE
	BEGIN

		SELECT ptm.ProductTypeMapID
			  ,ptm.ProductTypeID
			  ,ptm.ProductSubTypeID
			  ,pt.Name ProductTypeName
			  ,pst.Name ProductSubTypeName
			  ,pst.Description ProductSubTypeDescription
			  ,pst.MoreInfoURL -- Hamlet 1/19/18 - added url links to redirect to QBI website
		 FROM [Map].[ProductTypeMap] ptm
		  INNER JOIN [Definition].[ProductType] pt ON ptm.ProductTypeID = pt.ProductTypeID
		  INNER JOIN [Definition].[ProductSubType] pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID

		WHERE pt.Name = @productName
	END
END











GO
