SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <04/01/2016>
-- Description:	<Return productType, productSubtype along side with productTypeMap>
-- =============================================
CREATE PROCEDURE [Business].[uspGetProductTypeMapByID]
	@ProductTypeMapID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ptm.ProductTypeMapID
		  ,ptm.ProductTypeID
		  ,ptm.ProductSubTypeID
		  ,pt.Name ProductTypeName
		  ,pst.Name ProductSubTypeName
	 FROM [Map].[ProductTypeMap] ptm
	  INNER JOIN [Definition].[ProductType] pt ON ptm.ProductTypeID = pt.ProductTypeID
	  INNER JOIN [Definition].[ProductSubType] pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID

	WHERE ptm.ProductTypeMapID = @ProductTypeMapID
END








GO
