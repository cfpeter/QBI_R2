SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <01/24/2017>
-- Description:	<Insert New Product>
-- =============================================
CREATE PROCEDURE [Product].[uspInsertProduct] 
	-- Add the parameters for the stored procedure here	
	
    @ProductID			bigint = 0 out,-- commented out by peter on 3-23-17
	@ProductTypeMapID	int = NULL, -- NULL added by Hamlet 12/15/17
	@ProductTypeName	varchar(50) = NULL, --added by Hamlet 12/15/17
	@ProductSubTypeName varchar(50) = NULL, --added by Hamlet 12/15/17 
    @CustomerID			bigint,
	@CreatedBy			[dbo].[CREATEDBY],
	@Number				varchar(50) = null,
    @Name				varchar(100) = null,
    @ProductAssets		int = null,
    @NumberOfParticipant int = null,
    @SalesPersonID		int = null,
    @StatusGroupMapID	int = null,
    @ProductOriginID	int = null,
	@Note				[dbo].[NOTE]  = null,
    @DocumentProviderID int = null,
    @DocumentTypeID		int = null,
    @BillingTypeID		int = null,
    @BillingFrequencyID int = null,
    @TrustID			int = null,
    @ConsultantPersonID int = null,
    @AdvisorPersonID	int = null,
    @ReferralPersonID	int = null,
    @PYEDay				int = null,
	@PYEMonth			int = null,
    @Option316			[dbo].[TRUEFALSE] = null,
    @ProductYearEnd		date = null,
    @ValuationDate		date = null,
    @FinalYearEndDate	date = null,
    @Description		[dbo].[DESCRIPTION] = null,      
    @BillingAddressSameAsClient bit  = null,
	@isProspect			bit  = null,
	@FirstPlanYearEndWithQBI int = null,
	@EligibleAge		int = null,
	@EligibleAgeWaived	int  = null,
	@OneLoginProductID	int = NULL --added by Hamlet 12/15/17
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @CreatedDateTime datetime = CURRENT_TIMESTAMP

		IF (@ProductTypeMapID IS NULL)
		BEGIN
			SET @ProductTypeMapID = (SELECT productTypeMapID FROM [Map].[ProductTypeMap] WHERE 
										ProductTypeID = (SELECT ProductTypeID FROM [Definition].[ProductType] WHERE name = @ProductTypeName)
										AND ProductSubTypeID = (SELECT ProductSubTypeID FROM [Definition].[ProductSubType] WHERE name = @ProductSubTypeName)
										)
		END

	IF(@ProductSubTypeName IS NULL)
		BEGIN
			SET @ProductSubTypeName = (SELECT Name FROM [Definition].[ProductSubType] 
											WHERE ProductSubTypeID = (SELECT ProductSubTypeID FROM [Map].[ProductTypeMap] 
																		WHERE ProductTypeMapID = @ProductTypeMapID) )
		END
	
	-- DECLARE @CustomerID int = 750;
	SET @ProductID = (SELECT pr.ProductID FROM [Customer].[OrganizationBranch] orgb
											INNER JOIN [Customer].[Person] p ON orgb.OrganizationBranchID = p.OrganizationBranchID
											INNER JOIN [Customer].[Customer] c ON p.PersonID = c.PersonID
											INNER JOIN [Business].[Product] pr ON c.CustomerID = pr.CustomerID
										WHERE orgb.OrganizationBranchID = ( SELECT p.OrganizationBranchID FROM [Customer].[Customer] c 
																			INNER JOIN [Customer].[Person] p ON c.PersonID = p.PersonID 
																			WHERE c.CustomerID = @CustomerID)
										AND pr.ProductTypeMapID = @ProductTypeMapID)
	--PRINT @ProductID
	
	DECLARE @MainCustomerID bigint = (Select MainCustomerID FROM [Customer].[Customer] WHERE CustomerID = @CustomerID); -- added by Hamlet 1/11/18 to insert MainCustomerID for product, even if insert is happening because nonMain clientManager logged in first
	if(@MainCustomerID IS NULL)
		BEGIN
			SET @MainCustomerID = @CustomerID
		END

	if( @OneLoginProductID IS NOT NULL AND @MainCustomerID IS NOT NULL)
		BEGIN
			UPDATE [Map].[ThirdPartyProviderMap]
					SET [OneLoginProductID] = @OneLoginProductID
					WHERE [CustomerID] = @CustomerID;
		END
	IF (@ProductID > 0)
		BEGIN
			RETURN @ProductID;
		END
			




    -- Insert statements for procedure here
	INSERT INTO [Business].[Product]
           ([ProductTypeMapID]
           ,[CustomerID]
           ,[SalesPersonID]
           ,[StatusGroupMapID]
           ,[ProductOriginID]
           ,[DocumentProviderID]
           ,[DocumentTypeID]
           ,[BillingTypeID]
           ,[BillingFrequencyID]
           ,[TrustID]
           ,[ConsultantPersonID]
           ,[AdvisorPersonID]
           ,[ReferralPersonID]
           ,[Number]
           ,[Name]
           ,[ProductAssets]
           ,[NumberOfParticipant]
           ,[Option316]
           ,[ProductYearEnd]
           ,[ValuationDate]
		   ,[PYEDay]
		   ,[PYEMonth]
           ,[FinalYearEndDate]
           ,[Description]
           ,[CreatedDateTime]
           ,[CreatedBy]
           ,[UpdatedDateTime]
           ,[UpdatedBy]
           ,[Note]
           ,[BillingAddressSameAsClient]
		   ,[isProspect]
		   ,[QBIFirstPlanYearEnd]
		   ,[EligibleAge]
		   ,[EligibleAgeWaived]
		   )
     VALUES
           (@ProductTypeMapID, 
			@CustomerID, 
            @SalesPersonID, 
            @StatusGroupMapID, 
            @ProductOriginID, 
            @DocumentProviderID,
            @DocumentTypeID,
            @BillingTypeID, 
            @BillingFrequencyID,
            @TrustID, 
            @ConsultantPersonID, 
            @AdvisorPersonID,
            @ReferralPersonID, 
            @Number,
            @Name, 
            @ProductAssets,
            @NumberOfParticipant, 
            @Option316,
            @ProductYearEnd, 
            @ValuationDate, 
			@PYEDay,
			@PYEMonth,
            @FinalYearEndDate, 
            @Description, 
            @CreatedDateTime, 
            @CreatedBy, 
            @CreatedDateTime,
            @CreatedBy, 
            @Note, 
            @BillingAddressSameAsClient,
			@isProspect,
			@FirstPlanYearEndWithQBI ,
			@EligibleAge		,
			@EligibleAgeWaived
			
			)

		SET @ProductID = SCOPE_IDENTITY()

		RETURN @ProductID
END
GO
