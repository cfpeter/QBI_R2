SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Security].[uspInsertCRMContacts]
	
--login and security
	@crmContactID int,
	@hasContactID varchar(50),
	@CustomerID int OUT,
--customer
	@clientID int,
	@loggedInUserName  varchar(50) ,
	@ConactIsPrimary int,
--Organization
	@OrganizationName varchar(50),
--OrganizationBranch
	@OrganizationBranchName varchar(50),
	@OrganizationBranchPhoneNumber varchar(50),
	@OrganizationBranchEmail varchar(50),
--person
	@FirstName varchar(50) ,
	@LastName varchar(50) , 
	@Email varchar(50),
--address
	@address1 varchar(50) = null,
	@CountryID varchar(50),
	@City varchar(50) = null,
	@ZipCode varchar(50) = null
	

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DECLARE @domainName varchar(50)
			DECLARE @authType varchar(50)
			DECLARE @CreatedUpdateDateTime datetime = CURRENT_TIMESTAMP
			--------------
			DECLARE @loggedInUserName_type varchar(50)  = 'Imported contact' 
			DECLARE @PersonID int
			DECLARE @OrganizationID int
			DECLARE @addressID int
			DECLARE @OrganizationBranchID int		
			DECLARE @CustomerTypeID int 
			DECLARE @statusGroupID int 
			DECLARE @statusGroupMapID int	
			DECLARE @OrganBranchID int	
			declare @organizationTypeID int = ( SELECT organizationTypeID from [Definition].[OrganizationType] where name = 'Unknown' )

			SET @CustomerTypeID     = ( SELECT CustomerTypeID FROM [Definition].[CustomerType] WHERE Name = 'CRM Customer' )
			SET @statusGroupID      = ( SELECT statusGroupID FROM [definition].[StatusGroup] WHERE Name = 'CRM' )
			SET @statusGroupMapID   = ( SELECT statusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusGroupID = @statusGroupID)

			DECLARE @mainClient int = (	SELECT mainClient from [customer].[customer] where crmclientID = @clientID and MainClient = 1 )

			--DECLARE @OrgTypeID int  = ( SELECT OrganizationTypeID FROM [Definition].[OrganizationType] WHERE Name = 'Unknown' )
			SET @OrganBranchID = ( SELECT p.OrganizationBranchID FROM [Customer].[Person] p
											INNER JOIN [customer].[Customer] c on p.PersonID = c.PersonID 
											WHERE c.CRMClientID = @clientID AND c.MainClient = 1 )
		
			IF ( @hasContactID = 'false' )
			BEGIN
					

			INSERT [Customer].[Person] 
					( 
						  [OrganizationBranchID]
						, [FirstName]
						, [LastName]
						, [Email]
						, [CreatedBy]
						, [UpdatedBy]
						, [CreatedDateTime]
						, [UpdatedDateTime]
						, [Note]
					) 
				VALUES (
						  @OrganBranchID
						, @FirstName
						, @LastName
						, @Email
						, @loggedInUserName   
						, @loggedInUserName  
						, @CreatedUpdateDateTime
						, @CreatedUpdateDateTime
						, @loggedInUserName_type
						)
				SET @PersonID  = SCOPE_IDENTITY()

				IF( @address1 is not null )
				BEGIN
		 			INSERT [Customer].[Address] 
						( 
							[AddressTypeID]
							,[Address1]
							,[CountryID]
							,[City]
							,[Zipcode]
							,[CreatedBy]
						    ,[UpdatedBy]
							,[CreatedDateTime]
							,[UpdatedDateTime]
							,[Note]
						) 
					VALUES (
							  1 -- work
							, @address1
							, @CountryID
							, @City
							, @ZipCode
							, @loggedInUserName 
						    , @loggedInUserName
							, @CreatedUpdateDateTime
							, @CreatedUpdateDateTime
							, @loggedInUserName_type
						)

					SET @addressID  = SCOPE_IDENTITY()

					INSERT [Map].[PersonAddress] 
						( 
							  [AddressID]
							, [PersonID]
							, [CreatedBy]
						    , [UpdatedBy]
							, [CreatedDateTime]
							, [UpdatedDateTime]
							, [Note]
						) 
					VALUES (
							 @addressID
							,@PersonID
							,@loggedInUserName 
						    ,@loggedInUserName 
							,@CreatedUpdateDateTime
							,@CreatedUpdateDateTime
							,@loggedInUserName_type
						)
				END
				ELSE
				BEGIN
					SET @addressID  = null;
				END
				
			
				INSERT INTO [Customer].[Customer]
				(
					[CRMContactID],
					[CustomerTypeID],
					[CRMClientID],
					[isPrimary],
					[PersonID],
					[StatusGroupMapID],
					[IsActive],
					[Description],
					[CreatedBy],
					[UpdatedBy],
					[CreatedDateTime],
					[UpdatedDateTime],
					[Note]
					 
				)
				VALUES
				(
					@crmContactID,
					@CustomerTypeID,
					@clientID,
					@ConactIsPrimary,
					@PersonID,
					@statusGroupMapID,
					0,
					@FirstName + ' ' + @LastName ,
					@loggedInUserName ,
				    @loggedInUserName ,
					@CreatedUpdateDateTime,
					@CreatedUpdateDateTime,
					@loggedInUserName_type
				)
		
				SET @CustomerID = scope_identity()
			END
			ELSE IF ( @hasContactID = 'true' )
			BEGIN
         		
				SET @CustomerID = ( select c.CustomerID from  [Customer].[Customer] c where  c.CRMContactID = @crmContactID )				 		
		
				UPDATE  [Customer].[Customer]
				set
					[CRMContactID]		= @crmContactID,
					[CustomerTypeID]	= @CustomerTypeID,
					[CRMClientID]		= @clientID,
					[isPrimary]			= @ConactIsPrimary,
					[StatusGroupMapID]	= @statusGroupMapID, 
					[UpdatedBy]			= @loggedInUserName  ,
					[UpdatedDateTime]	= @CreatedUpdateDateTime,
					[Note]				= @loggedInUserName_type

				WHERE CustomerID = @CustomerID 
			
				SET @personID  = (SELECT c.personID FROM [Customer].[Customer] c WHERE CustomerID = @CustomerID)
				
				UPDATE [Customer].[Person]
				SET
					  [FirstName]			= @FirstName
					, [LastName]			= @LastName
					, [Email]				= @Email
					, [UpdatedBy]			= @loggedInUserName 
					, [UpdatedDateTime]		= @CreatedUpdateDateTime
					, [Note]				= @loggedInUserName_type
		 
				WHERE PersonID = @PersonID

				SET @AddressID = (SELECT AddressID FROM [Map].[PersonAddress] WHERE PersonID = @PersonID)


		IF( @address1 is not null )
				BEGIN
				UPDATE [Customer].[Address] 
				SET 
						[Address1]		= @address1
						,[CountryID]	= @CountryID
						,[City]			= @City
						,[Zipcode]		= @ZipCode
						,[UpdatedBy]		= @loggedInUserName 
						,[UpdatedDateTime]	= @CreatedUpdateDateTime
						,[Note]				= @loggedInUserName_type
				WHERE AddressID = @AddressID
		 
				SET @OrganizationBranchID = ( SELECT OrganizationBranchID FROM [customer].[Person] WHERE PersonID = @PersonID )
		
				UPDATE [Customer].[OrganizationBranch] 
					SET
						[OrganizationID]	= @OrganizationID
						, [Name]			= @OrganizationBranchName 
						, [PhoneNumber]		= @OrganizationBranchPhoneNumber
						, [Email]			=  @OrganizationBranchEmail
						, [IsActive]		= 1 
						, [UpdatedBy]		= @loggedInUserName 
						, [UpdatedDateTime] = @CreatedUpdateDateTime
						, [Note]				= @loggedInUserName_type

					WHERE OrganizationBranchID = @OrganizationBranchID

				SET @OrganizationID = (SELECT OrganizationID FROM [Customer].[OrganizationBranch] WHERE OrganizationBranchID = @OrganizationBranchID )

				UPDATE [Customer].[Organization] 
				SET
					  [OrganizationTypeID]	= @organizationTypeID 
					, [Name]				= @OrganizationName
					, [UpdatedBy]			= @loggedInUserName 
					, [UpdatedDateTime]		= @CreatedUpdateDateTime	
					, [Note]				= @loggedInUserName_type
							 
				WHERE OrganizationID		= @OrganizationID
				END
			END
		COMMIT	
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			EXEC dbo.uspRethrowError
		END
	END CATCH
END


















GO
