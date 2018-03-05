SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <01/24/2017>
-- Description:	<Get a customer's organization's main client's products by CustomerID>
-- =============================================
Create PROCEDURE [Product].[uspListMainCustomerProductByCustonerID] 
	-- Add the parameters for the stored procedure here	

	@CustomerID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT p.[ProductID]
		  ,p.[ProductTypeMapID]
		  ,p.[CustomerID]
		  ,p.[SalesPersonID]
		  ,p.[StatusGroupMapID]
		  ,p.[ProductOriginID]
		  ,p.[DocumentProviderID]
		  ,p.[DocumentTypeID]
		  ,p.[BillingTypeID]
		  ,p.[BillingFrequencyID]
		  ,p.[TrustID]
		  ,p.[ConsultantPersonID]
		  ,p.[AdvisorPersonID]
		  ,p.[ReferralPersonID]
		  ,p.[Number]
		  ,p.[Name]
		  ,p.[ProductAssets]
		  ,p.[NumberOfParticipant]
		  ,p.[Option316]
		  ,p.[ProductYearEnd]
		  ,p.[ValuationDate]
		  ,p.[FinalYearEndDate]
		  ,p.[Description]
		  ,p.[CreatedDateTime]
		  ,p.[CreatedBy]
		  ,p.[UpdatedDateTime]
		  ,p.[UpdatedBy]
		  ,p.[Note]
		  ,p.[BillingAddressSameAsClient]
		  ,p.[PYEMonth]
		  ,p.[PYEDay]
		  ,p.[CurrentYearEnd]
		  ,p.[isProspect]
		  ,p.[crmPlanID]
		  ,tppm.[OneLoginProductID]
		  ,pt.Name ProductTypeName
		  ,pst.Name ProductSubTypeName
		  ,cons.FirstName ConsultantFirstName
		  ,cons.LastName ConsultantLastName
		FROM [Business].[Product] p
		JOIN [Customer].[Customer] c ON c.MainCustomerID = p.CustomerID
		JOIN [Map].[ThirdPartyProviderMap] tppm ON tppm.CustomerID = @CustomerID
		JOIN [Map].[ProductTypeMap] ptm ON ptm.productTypeMapID = p.ProductTypeMapID
		JOIN [Definition].[ProductType] pt ON pt.ProductTypeID = ptm.ProductTypeID
		JOIN [Definition].[ProductSubType] pst ON pst.ProductSubTypeID = ptm.ProductSubTypeID
		LEFT JOIN [Customer].[Person] cons ON cons.PersonID = p.ConsultantPersonID
		WHERE c.CustomerID = @CustomerID
		AND ( p.isProspect is NULL OR p.isProspect = 0 )


END



GO
