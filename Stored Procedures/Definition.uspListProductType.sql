SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Definition].[uspListProductType]
@option varchar(50)

AS
BEGIN

	IF @option = 'sales'
	BEGIN
		SELECT pt.Name ProductTypeName
			FROM [Definition].[ProductType] pt
			WHERE pt.ActiveForSales = 1

	END
	ELSE
	BEGIN
		SELECT pt.Name ProductTypeName  
			FROM [Definition].[ProductType] pt

	END
END










GO
