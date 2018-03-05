SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <01/25/2017>
-- Description:	<Update product by given productID>
-- =============================================
CREATE PROCEDURE [Product].[uspUpdateProduct]
	@ProductID bigint,
	@ProductTypeMapID int,
    @CustomerID bigint,
	@UpdatedBy [dbo].[CREATEDBY],
	@Number varchar(50) = null,
    @Name varchar(100) = null,
    @ProductAssets int = null,
    @NumberOfParticipant int = null,
    @SalesPersonID int = null,
    @StatusGroupMapID int = null,
    @ProductOriginID int = null,
	@Note [dbo].[NOTE]  = null,
    @DocumentProviderID int = null,
    @DocumentTypeID int = null,
    @BillingTypeID int = null,
    @BillingFrequencyID int = null,
    @TrustID int = null,
    @ConsultantPersonID int = null,
    @AdvisorPersonID int = null,
    @ReferralPersonID int = null,   
    @Option316 [dbo].[TRUEFALSE] = null,
   -- @CurrentYearEnd date = null,
    @ProductYearEnd date = null,
	@PYEDay int = null,
	@PYEMonth int = null,
    @ValuationDate date = null,
    @FinalYearEndDate date = null,
    @Description [dbo].[DESCRIPTION] = null,      
    @BillingAddressSameAsClient bit  = null,
	@FirstPlanYearEndWithQBI int = null,
	@EligibleAge int = null,
	@EligibleAgeWaived int  = null
AS
BEGIN
	
			SET NOCOUNT ON;
			DECLARE @UpdatedDateTime datetime = CURRENT_TIMESTAMP
			-- Insert statements for procedure here
			UPDATE [Business].[Product]
		   SET [ProductTypeMapID]			= @ProductTypeMapID
			--  ,[CustomerID]					= @CustomerID
			  ,[SalesPersonID]				= IsNull(@SalesPersonID,[SalesPersonID])
			  ,[StatusGroupMapID]			= IsNull(@StatusGroupMapID,[StatusGroupMapID])
			  ,[ProductOriginID]			= IsNull(@ProductOriginID,[ProductOriginID] )
			  ,[DocumentProviderID]			= IsNull(@DocumentProviderID,[DocumentProviderID])
			  ,[DocumentTypeID]				= IsNull(@DocumentTypeID,[DocumentTypeID] )
			  ,[BillingTypeID]				= IsNull(@BillingTypeID,[BillingTypeID] )
			  ,[BillingFrequencyID]			= IsNull(@BillingFrequencyID,[BillingFrequencyID])
			  ,[TrustID]					= IsNull(@TrustID,[TrustID])
			  ,[ConsultantPersonID]			= IsNull(@ConsultantPersonID,[ConsultantPersonID])
			  ,[AdvisorPersonID]			= IsNull(@AdvisorPersonID,[AdvisorPersonID])
			  ,[ReferralPersonID]			= IsNull(@ReferralPersonID,[ReferralPersonID])
			  ,[Number]						= IsNull(@Number,[Number])
			  ,[Name]						= IsNull(@Name,[Name])
			  ,[ProductAssets]				= IsNull(@ProductAssets,[ProductAssets])
			  ,[NumberOfParticipant]		= IsNull(@NumberOfParticipant,[NumberOfParticipant])
			  ,[Option316]					= IsNull(@Option316,[Option316])
			  ,[PYEDay]						= isNull(@PYEDay , [PYEDay]) -- added by peter - 3-22-17
			  ,[PYEMonth]					= isNull(@PYEMonth , [PYEMonth])-- added by peter - 3-22-17
			  -- ,[CurrentYearEnd]			= IsNull(@CurrentYearEnd,[CurrentYearEnd])
			  ,[ProductYearEnd]				= IsNull(@ProductYearEnd,[ProductYearEnd])
			  ,[ValuationDate]				= IsNull(@ValuationDate,[ValuationDate])
			  ,[FinalYearEndDate]			= IsNull(@FinalYearEndDate,[FinalYearEndDate])
			  ,[Description]				= IsNull(@Description,[Description])
			  ,[UpdatedDateTime]			= @UpdatedDateTime
			  ,[UpdatedBy]					= @UpdatedBy
			  ,[Note]						= IsNull(@Note,[Note])
			  ,[BillingAddressSameAsClient] = ISNull(@BillingAddressSameAsClient,[BillingAddressSameAsClient])
			  ,[QBIFirstPlanYearEnd]		= ISNull(@FirstPlanYearEndWithQBI,[QBIFirstPlanYearEnd])
			  ,[EligibleAge]				= ISNull(@EligibleAge,[EligibleAge])
			  ,[EligibleAgeWaived]			= ISNull(@EligibleAgeWaived,[EligibleAgeWaived])
		 WHERE ProductID = @ProductID


		 SELECT * from [business].Product
		 WHERE productID = @ProductID
		
END








GO
