SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian>
-- Create date: <11/06/2017>
-- Description:	<Update product by given productID>
-- =============================================
CREATE PROCEDURE [Product].[uspUpdateProductFromCRM]
	@ProductID bigint,
	@crmPlanID int ,
	@ProductTypeMapID int,
    @CustomerID bigint,
	@UpdatedBy [dbo].[CREATEDBY],
	@Number varchar(50) = null,
    @Name varchar(100) = null,
    @ProductAssets int = null,
    @NumberOfParticipant int = null,
	@ProductOrigin varchar(45) = null,
	@statusName varchar(45) = null ,
   -- @SalesPersonID int = null,
    --@StatusGroupMapID int = null,
  --  @ProductOriginID int = null,
	--@Note [dbo].[NOTE]  = null,
  --  @DocumentProviderID int = null,
  --  @DocumentTypeID int = null,
   -- @BillingTypeID int = null,
   -- @BillingFrequencyID int = null,
   -- @TrustID int = null,
   -- @ConsultantPersonID int = null,
   -- @AdvisorPersonID int = null,
    --@ReferralPersonID int = null,   
   -- @Option316 [dbo].[TRUEFALSE] = null,
   -- @CurrentYearEnd date = null,
   -- @ProductYearEnd date = null,
	@PYEDay int = null,
	@PYEMonth int = null,
   -- @ValuationDate date = null,
   -- @FinalYearEndDate date = null,
   -- @Description [dbo].[DESCRIPTION] = null,      
   -- @BillingAddressSameAsClient bit  = null 

	@consultantFirstName varchar(50),
	@consultantlastName varchar(50),
	@consultantemail varchar(50) ,
	@consultantphoneNumber varchar(50) = NULL 

AS
BEGIN	
 
	
			SET NOCOUNT ON;
			DECLARE @UpdatedDateTime datetime = CURRENT_TIMESTAMP
			
		 DECLARE	@insertType varchar(50)		=  'Inserted by importing plans' 
		 DECLARE	@personTitleTypeID int			= (SELECT PersonTitleTypeID FROM [Definition].[PersonTitleType] WHERE Name =  'Pension Plans Consultant') 
		 DECLARE	@departmentID int				= (SELECT DepartmentID		FROM [Definition].[Department]		WHERE Name =  'Pension' )
		 -- DECLARE	@ConsultantPersonID int			= (SELECT personID			FROM [Customer].[Person]			where Email = @consultantemail )
		 DECLARE	@ConsultantPersonID int			= (SELECT c.PersonID FROM Customer.Customer c
														WHERE PersonID IN (SELECT personID	FROM [Customer].[Person]where Email = @consultantemail)
														AND c.CustomerTypeID = 1 )   -- added by SA 12/6/2017 to overcome duplicate emails 
		 
		 DECLARE	@salesPersonID int				= ( SELECT salesPersonID FROM [Business].[Product] WHERE CustomerID = @CustomerID AND isProspect = 1 )	 -- added by peter on 11/10/2017
		 DECLARE	@ProductOriginID int			= (SELECT ProductOriginID	From [Definition].[ProductOrigin] where Name = @productOrigin )				 -- added by peter on 11/10/2017

		 DECLARE	@statusID int					= ( SELECT statusID			FROM [Definition].[Status]		where Name = @statusName )  -- added by peter on 11/10/2017
		 DECLARE	@statusGroupID int				= ( SELECT StatusGroupID	FROM [Definition].[StatusGroup]		where name = 'CRM Plans' )  -- added by peter on 11/10/2017

		 DECLARE	@statusGroupMapID int			= ( SELECT statusGroupMapID from [Map].[StatusGroupMap]		where StatusID = @statusID and StatusGroupID = @statusGroupID ) -- added by peter on 11/10/2017
	
		if( @ConsultantPersonID is null ) 
			BEGIN
					INSERT INTO [Customer].[Person]
					   (
						[OrganizationBranchID]
					   ,[DepartmentID]
					   ,[PersonTitleTypeID]
					   ,[FirstName]
					   ,[LastName]
					   ,[Email]
					   ,[CreatedDateTime]
					   ,[CreatedBy]
					   ,[UpdatedDateTime]
					   ,[UpdatedBy]
					   ,[Note]
					   )
					VALUES
					   (
						1 -- QBI LLC WH
					   ,@departmentID -- Pension
					   ,@personTitleTypeID
					   ,@consultantFirstName
					   ,@consultantLastName
					   ,@consultantEmail
					   , CURRENT_TIMESTAMP
					   ,@UpdatedDateTime  
					   , CURRENT_TIMESTAMP
					   ,@UpdatedDateTime  
					   ,@insertType
					   )
		
				set @ConsultantPersonID = scope_identity()


				INSERT INTO [Customer].[Customer]
					   (
						[CustomerTypeID]
					   ,[StatusGroupMapID]
					   ,[PersonID]
					   ,[IsActive]
					   ,[Description]
					   ,[CreatedDateTime]
					   ,[CreatedBy]
					   ,[UpdatedDateTime]
					   ,[UpdatedBy]
					   ,[Note]
					   )
					VALUES
					   (
						1 --Internal
					   ,14 -- Active | Employee
					   ,@ConsultantPersonID
					   ,1
					   ,@consultantFirstName + ' ' + @consultantLastName 
					   , CURRENT_TIMESTAMP
					   ,@UpdatedDateTime  
					   , CURRENT_TIMESTAMP
					   ,@UpdatedDateTime  
					   ,@insertType
					   )

				DECLARE @assistancePersonAddressID int = ( SELECT personID FROM [Map].[PersonAddress] where personID = @ConsultantPersonID  )
			 
				if @assistancePersonAddressID IS NULL
					BEGIN
						INSERT INTO [Map].[PersonAddress]
						(
							 [PersonID]
							,[AddressID]
							,[CreatedDateTime]
							,[CreatedBy]
							,[UpdatedDateTime]
							,[UpdatedBy]
							,[Note]

						)
						VALUES(
							 @ConsultantPersonID
							,1 -- woodland hills //is defaulted to the consultant address
							,CURRENT_TIMESTAMP
							,@UpdatedDateTime  
							,CURRENT_TIMESTAMP
							,@UpdatedDateTime  
							,@insertType
						)
					END
			END
			 


			-- Insert statements for procedure here
		UPDATE [Business].[Product]
		   SET [ProductTypeMapID]			= @ProductTypeMapID
			--  ,[CustomerID]					= @CustomerID
			  ,[SalesPersonID]				= @salesPersonID 
			  ,[StatusGroupMapID]			= IsNull(@StatusGroupMapID,[StatusGroupMapID])
			 ,[ProductOriginID]				= IsNull(@ProductOriginID,[ProductOriginID] )
			 -- ,[DocumentProviderID]			= IsNull(@DocumentProviderID,[DocumentProviderID])
			 -- ,[DocumentTypeID]				= IsNull(@DocumentTypeID,[DocumentTypeID] )
			--  ,[BillingTypeID]				= IsNull(@BillingTypeID,[BillingTypeID] )
			--  ,[BillingFrequencyID]			= IsNull(@BillingFrequencyID,[BillingFrequencyID])
			 -- ,[TrustID]					= IsNull(@TrustID,[TrustID])
				,[ConsultantPersonID]		= IsNull(@ConsultantPersonID,[ConsultantPersonID])
			 -- ,[AdvisorPersonID]			= IsNull(@AdvisorPersonID,[AdvisorPersonID])
			 -- ,[ReferralPersonID]			= IsNull(@ReferralPersonID,[ReferralPersonID])
			  ,[Number]						= IsNull(@Number,[Number])
			  ,[Name]						= IsNull(@Name,[Name])
			  ,[ProductAssets]				= IsNull(@ProductAssets,[ProductAssets])
			  ,[NumberOfParticipant]		= IsNull(@NumberOfParticipant,[NumberOfParticipant])
			--  ,[Option316]					= IsNull(@Option316,[Option316])
			  ,[PYEDay]						= isNull(@PYEDay , [PYEDay]) -- added by peter - 3-22-17
			  ,[PYEMonth]					= isNull(@PYEMonth , [PYEMonth])-- added by peter - 3-22-17
			  -- ,[CurrentYearEnd]			= IsNull(@CurrentYearEnd,[CurrentYearEnd])
			 -- ,[ProductYearEnd]				= IsNull(@ProductYearEnd,[ProductYearEnd])
			--  ,[ValuationDate]				= IsNull(@ValuationDate,[ValuationDate])
			 -- ,[FinalYearEndDate]			= IsNull(@FinalYearEndDate,[FinalYearEndDate])
			 -- ,[Description]				= IsNull(@Description,[Description])
			  ,[UpdatedDateTime]			= @UpdatedDateTime
			  ,[UpdatedBy]					= @UpdatedBy
			 -- ,[Note]						= IsNull(@Note,[Note])
			 -- ,[BillingAddressSameAsClient] = ISNull(@BillingAddressSameAsClient,[BillingAddressSameAsClient])
		 WHERE crmPlanID = @crmPlanID
		
		 SELECT * from [business].Product
		 WHERE crmPlanID = @crmPlanID
		
END



GO
