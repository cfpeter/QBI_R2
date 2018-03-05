SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Security].[uspInsertCRMSignup]
	
--login and security
	@crmContactID int,
	@userName varchar(50),
	--@email varchar(50), -- this email from scrmSignup which we removed the input
	@passCode varchar(250),
	@salt varchar(250),
	@question varchar(50),
	@answer varchar(50),
	@hasContactID varchar(50),
	@CustomerID int OUT,
	@contactEmailAddress varchar(50),
--customer
	@clientID int,
	@ConactIsPrimary int,
--Organization
	@OrganizationName varchar(50),
	@EntityTypeName varchar(50),
--OrganizationBranch
	@OrganizationBranchName varchar(50),
	@OrganizationBranchPhoneNumber varchar(50),
	@OrganizationBranchEmail varchar(50),
--person
	@FirstName varchar(50) ,
	@LastName varchar(50) , 
	@Gender varchar(10), 
--address
	@clientState  varchar(20),
	@clientAddressType  varchar(20),
	@address1 varchar(50) = null,
	@CountryID varchar(50),
	@City varchar(50) = null,
	@ZipCode varchar(50) = null,
--other
	@EIN varchar(50) = null
	

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		DECLARE @signupType varchar(50) = 'signup'

		DECLARE @loginID int
		DECLARE @SecurityQAID int
		DECLARE @domainName varchar(50)
		DECLARE @authType varchar(50)
		DECLARE @CreatedUpdateDateTime datetime = CURRENT_TIMESTAMP
		--------------
		DECLARE @PersonID int
		DECLARE @OrganizationID int
		DECLARE @addressID int
		DECLARE @OrganizationTypeID int = ( SELECT OrganizationTypeID FROM [Definition].[OrganizationType] WHERE Name = 'unknown' )

		DECLARE @addressTypeID int = ( SELECT AddressTypeID FROM [Definition].[AddressType] WHERE Name =  @clientAddressType )
		DECLARE @CompanyTypeID int = ( SELECT CompanyTypeID FROM [Definition].[CompanyType] WHERE Name = @EntityTypeName )
		DECLARE @StateID int		= ( SELECT StateID FROM [Definition].[State] WHERE Code = @clientState )

		DECLARE @OrganizationBranchID int

		DECLARE @mainClient int = (	SELECT mainClient from [customer].[customer] where crmclientID = @clientID and MainClient = 1 )
		DECLARE @isMainClient int 

		if( @mainClient IS NULL )
			BEGIN	
				INSERT [Customer].[Organization] 
						( 
						  [OrganizationTypeID]
						, [Name]
						, [CompanyTypeID]
						, [EIN]
						, [CreatedDateTime]
						, [CreatedBy]
						, [UpdatedDateTime]
						, [UpdatedBy]
						, [Note]
						) 
				  VALUES (
						@OrganizationTypeID -- unknown
					  , @OrganizationName
					  , @CompanyTypeID
					  , @EIN
					  , @CreatedUpdateDateTime
					  , @userName  
					  , @CreatedUpdateDateTime
					  , @userName  
					  , @signupType
				)
				set @OrganizationID  = SCOPE_IDENTITY()
				

				INSERT [Customer].[OrganizationBranch] 
					( 
								  [OrganizationID]
								, [Name]
								, [PhoneNumber]
								, [Email]
								, [IsActive]
								, [CreatedDateTime]
								, [CreatedBy]
								, [UpdatedDateTime]
								, [UpdatedBy]
								, [Note]
								) 
				VALUES (
								  @OrganizationID
								, @OrganizationBranchName 
								, @OrganizationBranchPhoneNumber
								, @OrganizationBranchEmail
								, 1
								, @CreatedUpdateDateTime
								, @userName  
								, @CreatedUpdateDateTime
								, @userName 
								, @signupType
							)
						SET @OrganizationBranchID = SCOPE_IDENTITY()
			
						IF( @address1 is not null )
							BEGIN
		 						INSERT [Customer].[Address] 
									( 
										[AddressTypeID]
										,[Address1]
										,[CountryID]
										,[City]
										,[StateID]
										,[Zipcode]
										,[CreatedDateTime]
										,[CreatedBy]
										,[UpdatedDateTime]
										,[UpdatedBy]
									    ,[Note]
									) 
								VALUES (
										  @addressTypeID
										, @address1
										, @CountryID
										, @City
										, @StateID
										, @ZipCode
										, @CreatedUpdateDateTime
										, @userName 
										, @CreatedUpdateDateTime
										, @userName  
										, @signupType 
									)

									SET @addressID  = SCOPE_IDENTITY()

								INSERT [Map].[OrganizationBranchAddress] 
									( 
										[AddressID]
										, [OrganizationBranchID]
										, [CreatedDateTime]
										, [CreatedBy]
										, [UpdatedDateTime]
										, [UpdatedBy]
										, [Note]
									) 
								VALUES (
										@addressID
										,@OrganizationBranchID
										,@CreatedUpdateDateTime
										,@userName  
										,@CreatedUpdateDateTime
										,@userName  
										,@signupType
									)
				END
				ELSE
				BEGIN
					SET @addressID  = null;
				END

		END	-- end of mainCLient if statment
		ELSE
			BEGIN
			
				SET @OrganizationBranchID = ( SELECT p.OrganizationBranchID FROM [Customer].[Person] p
											INNER JOIN [customer].[Customer] c on p.PersonID = c.PersonID 
											WHERE c.CRMClientID = @clientID AND c.MainClient = 1 )
			END

		 
			




		DECLARE @CustomerTypeID int = ( SELECT CustomerTypeID FROM [Definition].[CustomerType] WHERE Name = 'CRM Customer' )
		DECLARE @statusGroupID int = (select statusGroupID from [definition].[StatusGroup] where Name = 'CRM')
		DECLARE @statusGroupMapID int = (select statusGroupMapID from [Map].[StatusGroupMap] where StatusGroupID = @statusGroupID)
		
		if( @mainClient is not null AND @mainClient = 1  )
			BEGIN
				set @isMainClient = 0
			END	
		else
			BEGIN
				set @isMainClient = 1
			END
	
	/*		INSERT INTO [Customer].[Customer]
						(
						    [CRMContactID],
						    [CustomerTypeID],
							[CRMClientID],
							[MainClient],
							[isPrimary],
							[PersonID],
						    [StatusGroupMapID],
							[IsActive],
						    [CreatedBy],
							[CreatedDateTime],
						    [UpdatedBy],
							[UpdatedDateTime]
					 
						)
						VALUES
						(
							@crmContactID,
							@CustomerTypeID,
							@clientID,
							@isMainClient, -- main client
							@ConactIsPrimary,
							@PersonID,
						    @statusGroupMapID,
							1, -- isActive
							@userName + ' - ' + @signupType,
							@CreatedUpdateDateTime,
							@userName + ' - ' + @signupType,
							@CreatedUpdateDateTime
					 )

		SET @CustomerID = scope_identity()*/

		if( @contactEmailAddress is null )
			set @contactEmailAddress = null
		

		IF ( @hasContactID = 'false' )
			BEGIN

						INSERT [Customer].[Person] 
				( 
							  [OrganizationBranchID]
							, [FirstName]
							, [LastName]
							, [Gender]
							, [Email]
							, [CreatedDateTime]
							, [CreatedBy]
							, [UpdatedDateTime]
						    , [UpdatedBy]
							, [Note]
							) 
			VALUES (
							  @OrganizationBranchID
							, @FirstName
							, @LastName
							, @Gender
							, @contactEmailAddress
							, @CreatedUpdateDateTime
							, @userName  
							, @CreatedUpdateDateTime
							, @userName 
							, @signupType
						)
		set @PersonID  = SCOPE_IDENTITY()


			INSERT INTO [Customer].[Customer]
						(
						   [CRMContactID],
						    [CustomerTypeID],
							[CRMClientID],
							[MainClient],
							[isPrimary],
							[PersonID],
						    [StatusGroupMapID],
							[IsActive],
							[Description],
						    [CreatedBy],
							[CreatedDateTime],
						    [UpdatedBy],
							[UpdatedDateTime],
							[Note]
					 
						)
						VALUES
						(
							@crmContactID,
							@CustomerTypeID,
							@clientID,
							@isMainClient, -- main client
							@ConactIsPrimary,
							@PersonID,
						    @statusGroupMapID,
							1, -- isActive
							@FirstName + ' ' + @LastName,
							@userName ,
							@CreatedUpdateDateTime,
							@userName , 
							@CreatedUpdateDateTime,
							@signupType

					 )

		SET @CustomerID = scope_identity()
		END
		

		ELSE if ( @hasContactID = 'true' )
			BEGIN
         		
				set @CustomerID = ( select c.CustomerID from [Customer].[Customer] c where c.CRMContactID = @crmContactID )
				DECLARE @personID_forEmail int = ( select personID from [Customer].[Customer] c where c.CustomerID = @CustomerID )
				
				UPDATE [Customer].[Customer]
				SET
					   [IsActive]  = 1
					  ,[UpdatedBy] = @userName 
					  ,[UpdatedDateTime] = @CreatedUpdateDateTime

				WHERE CustomerID = @CustomerID 


				UPDATE [Customer].[Person]
				SET
					   [Email]				= @contactEmailAddress
					  ,[UpdatedBy]			= @userName 
					  ,[UpdatedDateTime]	= @CreatedUpdateDateTime

				WHERE PersonID = @personID_forEmail 



			END


			INSERT INTO [Customer].[Login]
					   (
							[CustomerID],
							[UserName],   
							[PassCode],
							[salt],
							[IsActive],
						 	[CreatedBy],
							[CreatedDateTime],
						  	[UpdatedBy],
							[UpdatedDateTime],
							[Note]
					   )
          
				 VALUES
					   (
							@CustomerID,
							@userName,         
							@passCode,
							@salt,
							1,
							@userName ,
							@CreatedUpdateDateTime,
						 	@userName,
							@CreatedUpdateDateTime,
							@signupType
					   )

		 SET @loginID = scope_identity()
		
		 		 
		set @domainName = 'CRM Customer'
		set @authType = 'Basic'
		 
		 DECLARE @DomainGroupMapID int 

		 if( @ConactIsPrimary = 1 )
			SET @DomainGroupMapID = 7 --Manager
		 ELSE
			SET @DomainGroupMapID = 9 --Contact

		INSERT INTO [Map].[LoginMap]
					(
						LoginID,
						DomainGroupMapID,
						AuthenticationTypeID,
						[IsActive],
						[Description],
						[CreatedBy],
						[CreatedDateTime],
						[UpdatedBy],
						[UpdatedDateTime],
						[Note]
					)
					VALUES
					(
						@loginID,
						@DomainGroupMapID,
						1,--Basic
						1,-- Active
						@userName + ' | ' + @domainName + ' | ' + @authType,
						@userName ,
						@CreatedUpdateDateTime,
						@userName,
						@CreatedUpdateDateTime,
						@signupType
					)

		

		INSERT INTO [Security].[securityQA]
				   (
						
					    [Question],
					    [Answer],
						[CreatedBy],
						[CreatedDateTime],
						[UpdatedBy],
						[UpdatedDateTime],
						[Note]

				   )
				 VALUES
				   (	
						
						@question,
					    @answer,
						@userName,
						@CreatedUpdateDateTime,
						@userName,
						@CreatedUpdateDateTime,
						@signupType


				   )

			 SET @SecurityQAID = scope_identity()	


			INSERT INTO [Map].[SecurityQACustomerMap]
				   (
						[SecurityQAID],
						[customerID],
						[CreatedBy],
						[CreatedDateTime],
						[UpdatedBy],
						[UpdatedDateTime],
						[Note]

				   )
				 VALUES
				   (	
						@SecurityQAID,
						@CustomerID,
					 	@userName ,
						@CreatedUpdateDateTime,
					 	@userName ,
						@CreatedUpdateDateTime,
						@signupType

				   )
										
			 COMMIT
	
	 END TRY
	 BEGIN CATCH
		if(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			exec dbo.uspRethrowError
		END
	 END CATCH
END






GO
