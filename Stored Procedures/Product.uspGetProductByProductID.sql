SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ================================================
-- Author:		<Hamlet Tamazian>
-- Create date: <10/16/2017>
-- Description:	<Get product by given productID>
-- ================================================
CREATE PROCEDURE [Product].[uspGetProductByProductID] 
	@ProductID bigint

AS


BEGIN
	SELECT	p.*
			,pt.Name ProductTypeName
			,pst.Name ProductSubTypeName
			,po.Name ProductOriginName
			,salesPerson.FirstName + ' ' + salesPerson.LastName salesPersonName
			,consultantPerson.FirstName + ' ' + consultantPerson.LastName consultantName
			,sgm.Description ProductStatus
	FROM	Business.Product p	
				INNER JOIN [Map].[ProductTypeMap] ptm ON p.ProductTypeMapID = ptm.ProductTypeMapID
				INNER JOIN [Definition].[ProductType] pt ON ptm.ProductTypeID = pt.ProductTypeID
				INNER JOIN [Definition].[ProductSubType] pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID
				LEFT JOIN [Definition].[ProductOrigin] po ON p.ProductOriginID = po.ProductOriginID
				LEFT JOIN [Customer].[Person] salesPerson on p.SalesPersonID = salesPerson.PersonID
				LEFT JOIN [Customer].[Person] consultantPerson on p.ConsultantPersonID = consultantPerson.PersonID
				INNER JOIN [Map].[StatusGroupMap] sgm on sgm.StatusGroupMapID = p.StatusGroupMapID
	WHERE	p.ProductID =@ProductID
END






GO
