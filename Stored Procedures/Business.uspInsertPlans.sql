SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Business].[uspInsertPlans]
	 @customerID int
	,@planName varchar(100)
	,@planNumber varchar(50)
	,@planTypeName varchar(50)
	,@ProductYearEnd datetime
	,@statusName varchar (50)	
	,@BillingAddressSameAsClient bit
	--person
	,@createdUpdatedBy varchar (50)
	,@consultantFirstName varchar(50)
	,@consultantLastName varchar(50)
	,@consultantEmail varchar(50) 
	,@consultantPhoneNumber varchar(50) = NULL
	--othere stuff
	,@AnnualRevenue varchar(50) 
	,@Billingfrequecy varchar(50)  
	,@Attention varchar(50) 
	,@billingType varchar(50) 
	,@Participantfee varchar(50) 
	--address
	,@address1 varchar(50) 
	,@City varchar(50) 
	,@State varchar(50) 
	,@zipCode varchar(50)  



	,@ConsultantPersonID int OUT

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		 DECLARE   @StatusGroupMapID int = null
		 DECLARE	@insertType varchar(50)		=  'Inserted by importing plans'

		 DECLARE	@userName varchar(50)			= (SELECT username			FROM [Customer].[Login]				WHERE CustomerID = @customerID )
		 --plan info
		 DECLARE	@productTypeID int				= (SELECT ProductTypeID		FROM [Definition].[productType]		WHERE Name='Plans')
		 DECLARE	@productSubTypeID int			= (SELECT ProductSubTypeID	FROM [Definition].[ProductSubType]	WHERE Name= @planTypeName )
		 --person info
		 DECLARE	@personTitleTypeID int			= (SELECT PersonTitleTypeID FROM [Definition].[PersonTitleType] WHERE Name =  'Pension Plans Consultant') 
		 DECLARE	@departmentID int				= (SELECT DepartmentID		FROM [Definition].[Department]		WHERE Name =  'Pension' )
		 SET		@ConsultantPersonID 			= (SELECT personID			FROM [Customer].[Person]			where Email = @consultantEmail ) 
		 --status
		 DECLARE	@statusID int					= ( SELECT statusID			FROM [Definition].[Status]			where name = @statusName ) 
		 DECLARE	@statusGroupID int				= ( SELECT StatusGroupID	FROM [Definition].[StatusGroup]		where name = 'CRM Plans' ) 
		 --client
		 DECLARE	@clientID int					= (SELECT CRMClientID		FROM [customer].[customer]			where CustomerID = @customerID )
		 DECLARE	@customerID_ofMainClient int	= (SELECT customerID		FROM [customer].[customer]			where CRMClientID = @clientID AND MainClient = 1 )

		 /* added by SA 12/12/2016 to resolve production issue with state*/
		 DECLARE	@StateID int       = ( SELECT StateID FROM [Definition].[State] WHERE Code = @State )

		 if( @statusID IS NULL )
		 BEGIN
			INSERT INTO [Definition].[Status]
			(
				[name]
			   ,[description]
			   ,[CreatedDateTime]
			   ,[CreatedBy]
			   ,[UpdatedDateTime]
			   ,[UpdatedBy]
			   ,[Note]
			)
			values(
				@statusName
			   ,@statusName
			   , CURRENT_TIMESTAMP
			   ,@createdUpdatedBy 
			   , CURRENT_TIMESTAMP
			   ,@createdUpdatedBy
			   ,@insertType

			)

			set @statusID = scope_identity()
		

			 INSERT INTO [Map].[StatusGroupMap]
				(
					 [StatusID]
					,[StatusGroupID]
					,[Description]
					,[CreatedDateTime]
					,[CreatedBy]
					,[UpdatedDateTime]
					,[UpdatedBy]
					,[Note]
				)
				values(
					 @statusID
				   , @statusGroupID
				   , 'CRM Plans | ' + @statusName
				   , CURRENT_TIMESTAMP
				   , @createdUpdatedBy 
				   , CURRENT_TIMESTAMP
				   , @createdUpdatedBy 
				   , @insertType
				)
		
			SET @StatusGroupMapID = scope_identity()

		 END
		 else if( @statusID IS NOT NULL )
		 BEGIN
			SET @StatusGroupMapID = ( SELECT TOP 1 StatusGroupMapID FROM [Map].[StatusGroupMap] WHERE [StatusID] = @statusID and [StatusGroupID] = @statusGroupID )
		 END


		 if( @consultantFirstName IS NOT NULL )
			 BEGIN
				 if( @ConsultantPersonID IS NULL )
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
					   ,@createdUpdatedBy  
					   , CURRENT_TIMESTAMP
					   ,@createdUpdatedBy  
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
					   ,@createdUpdatedBy  
					   , CURRENT_TIMESTAMP
					   ,@createdUpdatedBy  
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
							,@createdUpdatedBy  
							,CURRENT_TIMESTAMP
							,@createdUpdatedBy  
							,@insertType
						)
					END
					
					

				END -- end of the @ConsultantPersonID IS NULL
			END -- end of the @consultantFirstName IS NOT NULL

		DECLARE @phonePersonID int = (SELECT PersonID FROM [Customer].[Phone] WHERE PersonID = @ConsultantPersonID )
		
		if( @phonePersonID IS NULL )
		BEGIN

				IF( @consultantPhoneNumber is not null )
				BEGIN

						INSERT INTO [Customer].[Phone]
								(
									[PhoneTypeID],
									[Number],
									[CreatedDateTime],
									[CreatedBy],
									[UpdatedDateTime],
									[UpdatedBy],
									[Note]
					 
								)
								VALUES
								(
									2,
									@ConsultantPersonID,
									CURRENT_TIMESTAMP,
									@createdUpdatedBy , 
									CURRENT_TIMESTAMP,
									@createdUpdatedBy ,
									@insertType + ' | ' + @consultantFirstName + ' ' + @consultantLastName 
							   )
					DECLARE @phoneID int = SCOPE_IDENTITY()


					INSERT INTO [Map].[PersonPhoneMap] (PersonID, PhoneID, CreatedBy, UpdatedBy, CreatedDateTime, UpdatedDateTime)
						VALUES (@ConsultantPersonID, @PhoneID, @createdUpdatedBy, @createdUpdatedBy, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)

				End --end of @consultantPhoneNumber is not null

		END  --end of @phonePersonID IS NULL 

	
	/*if( @planTypeName IS NULL)
		BEGIN
			INSERT INTO [Map].[ProductTypeMap]
				(
					 [ProductTypeID]
					,[ProductSubTypeID]
					,[Name]
					,[IsActive]
					,[CreatedBy]
					,[CreatedDateTime]
					,[UpdatedBy]
					,[UpdatedDateTime]	
					,[Note]						
							
				)
          
			VALUES
				(
					 @productTypeID
					,@productSubTypeID
					,@planTypeName
					,1
					,@createdUpdatedBy  
					,CURRENT_TIMESTAMP
					,@createdUpdatedBy  
					,CURRENT_TIMESTAMP 
					,@insertType
				)
		END
		DECLARE @ProductTypeMapID int = scope_identity()
		
		*/

	 DECLARE @ProductTypeMapID int = ( SELECT ProductTypeMapID from [Map].[ProductTypeMap] where Name = @planTypeName )

			
			
			INSERT INTO [Business].[product]
					   (
							 [CustomerID]
							,[ProductTypeMapID]
							,[StatusGroupMapID]
							,[Name]
							,[BillingAddressSameAsClient]
							,[Number]
							,[ProductYearEnd]
							,[ConsultantPersonID]
							,[CreatedBy]
							,[UpdatedBy]
							,[Note]
					   )
          
				 VALUES
					   (
							 @customerID_ofMainClient
							,@ProductTypeMapID
							,@StatusGroupMapID
							,@planName
							,@BillingAddressSameAsClient
							,@planNumber
							,@ProductYearEnd
							,@ConsultantPersonID
							,@createdUpdatedBy 
							,@createdUpdatedBy 
							,@insertType

					   )
					DECLARE @productID int = scope_identity()
						 
					
					IF ( @address1 IS NOT NULL )
						BEGIN
							INSERT INTO [Customer].[Address]
							(
								 [AddressTypeID]
								,[CountryID]
								,[Address1]
								,[City]
								,[StateID]
								,[Zipcode]
								,[CreatedBy]
								,[CreatedDateTime]
								,[UpdatedBy]
								,[UpdatedDateTime]	
								,[Note]	

							)VALUES(
								 3 -- billing
								,1 -- 
								,@address1
								,@City
								,@StateID
								,@zipCode
								,@createdUpdatedBy  
								,CURRENT_TIMESTAMP
								,@createdUpdatedBy  
								,CURRENT_TIMESTAMP 
								,@insertType

							)
							DECLARE @AddressID int = scope_identity()
						END

			if( @BillingAddressSameAsClient = 1 )
					BEGIN
						SET @AddressID =	(
												SELECT mob.AddressID from [customer].[Customer] c
													INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
													INNER JOIN [Map].[OrganizationBranchAddress] mob on p.OrganizationBranchID = mob.OrganizationBranchID
												where c.CustomerID = @customerID_ofMainClient
											)
					END	
						
						if( @billingType IS NOT NULL )
							BEGIn
							DECLARE @billingTypeID int = (SELECT BillingTypeID from [Definition].[BillingType] where Name = @billingType)
							IF(@billingTypeID IS NULL)
								BEGIN
									INSERT INTO [Definition].[BillingType]
										(
											 [Name]
											,[Description]
											,[CreatedBy]
											,[CreatedDateTime]
											,[UpdatedBy]
											,[UpdatedDateTime]								
										)VALUES(
											 @billingType
											,@billingType -- decription
											,@createdUpdatedBy  
											,CURRENT_TIMESTAMP
											,@createdUpdatedBy  
											,CURRENT_TIMESTAMP 
									
										)
									set @billingTypeID  = scope_identity()
								END -- ned of @billingTypeID IS NULL
							END -- end of @billingType IS NOT NULL 
							ELSE 
								BEGIN
		SET @billingTypeID = (	SELECT at.AddressTypeID from [Customer].[Customer] c
										INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
										INNER JOIN [Customer].[OrganizationBranch] o on p.OrganizationBranchID = o.OrganizationBranchID
										INNER JOIN [Map].[OrganizationBranchAddress] mog on o.OrganizationBranchID = mog.OrganizationBranchID
										INNER JOIN [Customer].[Address] ad on mog.AddressID = ad.AddressID
										INNER JOIN [Definition].[AddressType] at on ad.AddressTypeID = at.AddressTypeID
									WHERE c.CustomerID = @customerID_ofMainClient)
								 END


						IF(@Billingfrequecy IS NULL)
						BEGIN
							DECLARE  @billingFrequencyID INT = 
								(	SELECT BillingFrequencyID FROM [Definition].[billingFrequency]
									WHERE NAME = 'TBD')
									
						END
							ELSE
								BEGIN
								SET @billingFrequencyID = (SELECT BillingFrequencyID from [Definition].[BillingFrequency] where Name = @Billingfrequecy)
									IF(@billingFrequencyID IS NULL)
										BEGIN
											INSERT INTO [Definition].[BillingFrequency]
											(
											 [Name]
											,[Description]
											,[CreatedBy]
											,[CreatedDateTime]
											,[UpdatedBy]
											,[UpdatedDateTime]								
											)
											VALUES(
											 @Billingfrequecy
											,@Billingfrequecy -- decription
											,@createdUpdatedBy  
											,CURRENT_TIMESTAMP
											,@createdUpdatedBy  
											,CURRENT_TIMESTAMP 
									
											)
									SET @billingFrequencyID  = scope_identity()
									END
								END 

						
						INSERT INTO [business].[Billing]
							(
								 [BillingTypeID]
								,[BillingFrequencyID]
								,[ParticipantFee]
								,[AnnualRevenue]
								,[Name]
								,[IsActive]
								,[CreatedBy]
								,[CreatedDateTime]
								,[UpdatedBy]
								,[UpdatedDateTime]	
							)VALUES(
								 @billingTypeID
								,@billingFrequencyID
								,@Participantfee
								,@AnnualRevenue
								,@Attention
								,1 -- is active
								,@createdUpdatedBy  
								,CURRENT_TIMESTAMP
								,@createdUpdatedBy  
								,CURRENT_TIMESTAMP 

							)
							DECLARE @BillingID int = scope_identity()
						
					

					INSERT INTO [Map].[ProductBilling]
							(
								 [ProductID]
								,[BillingID]
								,[AddressID]
								,[Name]
								,[IsActive]
								,[CreatedBy]
								,[CreatedDateTime]
								,[UpdatedBy]
								,[UpdatedDateTime]	
								,[Note]	
							)VALUES
							(
								 @productID
								,@BillingID
								,@AddressID
								,@planTypeName
								,1 -- is active
								,@createdUpdatedBy  
								,CURRENT_TIMESTAMP
								,@createdUpdatedBy  
								,CURRENT_TIMESTAMP 
								,@insertType
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
