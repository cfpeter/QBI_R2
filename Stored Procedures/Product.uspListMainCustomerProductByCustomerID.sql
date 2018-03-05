SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <01/24/2017>
-- Description:	<Get a customer's organization's main client's products by CustomerID>
-- =============================================
CREATE PROCEDURE [Product].[uspListMainCustomerProductByCustomerID] 
	-- Add the parameters for the stored procedure here	

	@CustomerID int
	
AS
BEGIN 

	SET NOCOUNT ON;


	DECLARE @mainCID int = (SELECT mainCustomerID FROM [Customer].[Customer] WHERE CustomerID = @CustomerID)
	if(@mainCID IS NOT NULL)
		BEGIN
			SET @CustomerID = @mainCID 
		END

	SELECT p.[ProductID]
		  ,p.[ProductTypeMapID]
		  ,p.[CustomerID]
		  ,p.[SalesPersonID]
		  ,p.[StatusGroupMapID]
		  ,s.[Name] AS statusName -- added by Hamlet 1/29/18 to know if product is Active (activated from CRM)
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
		JOIN [Customer].[Customer] c ON p.CustomerID = @CustomerID
		LEFT JOIN [Map].[ThirdPartyProviderMap] tppm ON tppm.CustomerID = @CustomerID
		JOIN [Map].[ProductTypeMap] ptm ON ptm.productTypeMapID = p.ProductTypeMapID
		JOIN [Definition].[ProductType] pt ON pt.ProductTypeID = ptm.ProductTypeID
		JOIN [Definition].[ProductSubType] pst ON pst.ProductSubTypeID = ptm.ProductSubTypeID
		LEFT JOIN [Customer].[Person] cons ON cons.PersonID = p.ConsultantPersonID
		LEFT JOIN [Definition].[Status] s ON s.StatusID = (SELECT StatusID FROM [Map].[StatusGroupMap] WHERE StatusGroupMapID = p.StatusGroupMapID)
		WHERE c.CustomerID = @CustomerID
		AND ( p.isProspect is NULL OR p.isProspect = 0 )


END




GO
