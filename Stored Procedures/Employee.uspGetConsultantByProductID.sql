SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ================================================
-- Author:		<Hamlet Tamazian>
-- Create date: <10/16/2017>
-- Description:	<Get consultant by given productID>
-- ================================================
CREATE PROCEDURE [Employee].[uspGetConsultantByProductID] 
	@ProductID bigint

AS


BEGIN
	SELECT Distinct p.PersonID
		  ,prd.CustomerID
		  ,prd.ProductID
		  ,p.DepartmentID
		  ,p.OrganizationBranchID
		  ,p.PersonTitleTypeID
		  ,p.PrefixTypeID
		  ,p.FirstName
		  ,p.LastName
		  ,p.FirstName + ' ' + p.LastName FullName
		  ,p.Email
		  ,ph.Number PhoneNumber
		  ,pht.Name PhoneTypeName
		  ,p.Gender
		  ,p.CreatedBy
		  ,p.CreatedDateTime
		  ,p.UpdatedBy
		  ,p.CreatedDateTime	
		FROM  [Customer].[Person] p
		INNER JOIN [Business].[Product] prd ON p.PersonID = prd.ConsultantPersonID
		LEFT JOIN [Customer].[Phone] ph ON ph.PersonID = p.PersonID
		LEFT JOIN [Definition].[PhoneType] pht ON pht.PhoneTypeID = ph.PhoneTypeID
		WHERE prd.ProductID = @ProductID
END







GO
