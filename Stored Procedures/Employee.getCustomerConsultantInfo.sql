SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <01/30/2017>
-- Description:	<Get client consultant info per customer id per product>
-- =============================================
CREATE PROCEDURE [Employee].[getCustomerConsultantInfo] 
	@ClientCustomerID bigint,
	@ProductID bigint = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF ( @ProductID is NOT NULL )
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
		  ,p.Gender
		  ,p.CreatedBy
		  ,p.CreatedDateTime
		  ,p.UpdatedBy
		  ,p.CreatedDateTime	
		 
		FROM  [Customer].[Person] p
		INNER JOIN [Business].[Product] prd ON p.PersonID = prd.ConsultantPersonID
		WHERE CustomerID = @ClientCustomerID
		AND ProductID = @ProductID
	END
	ELSE
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
		  ,p.Gender
		  ,p.CreatedBy
		  ,p.CreatedDateTime
		  ,p.UpdatedBy
		  ,p.CreatedDateTime	
		FROM  [Customer].[Person] p
		INNER JOIN [Business].[Product] prd ON p.PersonID = prd.ConsultantPersonID
		WHERE CustomerID = @ClientCustomerID
	END
	
END


GO
