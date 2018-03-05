SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <01/24/2017>
-- Description:	<Get producuct by OneLoginProductID>
-- =============================================
CREATE PROCEDURE [Product].[uspGetProductByOneLoginProductID] 
	-- Add the parameters for the stored procedure here	

	@OneLoginProductID int
	
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
		FROM [Business].[Product] p
		JOIN [Map].[ThirdPartyProviderMap] tppm ON tppm.CustomerID = p.CustomerID
		WHERE tppm.OneLoginProductID = @OneLoginProductID;


END



GO
