SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Customer].[uspInsertKronosClient] 
	 
	 @KronosUserName		varchar(100)
	,@accountID         bigint
	,@companyID         bigint
	,@CompanyName		varchar(150)
	,@CompanyShortName	varchar(150)
	,@createdUpdatedBy	varchar(50)
	,@FirstName			varchar(50) 
	,@LastName			varchar(50)  
	,@Email				varchar(50)
	,@customerID		bigint
	,@VerificationCode	varchar(10) 
	,@organizationBranchID		int

	

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN 
			DECLARE @CreatedUpdateDateTime	datetime		= CURRENT_TIMESTAMP 
			DECLARE @loggedInUserName_type	varchar(50)		= 'Invitation sent for Kronos'  
					 
			DECLARE @CustomerTypeID			int				= ( SELECT CustomerTypeID FROM [Definition].[CustomerType] WHERE Name = 'Payroll Customer' )
			DECLARE @statusID				int 			= ( SELECT statusID FROM [definition].[Status] WHERE Name = 'Signup Invitation Pending' )
			DECLARE @statusGroupID			int				= ( SELECT statusGroupID FROM [definition].[StatusGroup] WHERE Name = 'Customer' )
			DECLARE @statusGroupMapID		int				= ( SELECT statusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusID = @statusID AND StatusGroupID = @statusGroupID )
			DECLARE @organizationTypeID		int				= ( SELECT [OrganizationTypeID] from [Definition].[OrganizationType] where Name = 'Financial' )
			DECLARE @domainGroupMap			int				= ( SELECT domainGroupMapID FROM [Map].[DomainGroupMap] where name = 'ClientPayrollManager' )
			DECLARE @authenticationType		int				= ( SELECT authenticationTypeID FROM [Definition].[AuthenticationType] where name = 'Basic' )
			
			DECLARE @thirdPartProviderID     int			= ( SELECT ThirdPartyProviderID FROM [Definition].[ThirdPartyProvider] where name = 'Kronos'  )
			DECLARE @personTitleTypeID int					= ( SELECT personTitleTypeID FROM [Definition].[PersonTitleType] where name = 'Manager'  )
 
		
			DECLARE @mainClient bit = 0;
			DECLARE @customerID_toCheck int; 
		--	DECLARE @emailCheck_personID int = ( SELECT personID from [Customer].[Person] where email = @Email )
			
		 
			DECLARE @MainCustomerID bigint = 0;
			DECLARE @CustomerCount int = (SELECT count(tppm.customerID) from [Map].[ThirdPartyProviderMap] tppm
										  INNER JOIN [Customer].[Login] l ON l.CustomerID = tppm.CustomerID
										  WHERE tppm.companyID = @companyID
										  AND	len(l.LastLoginDateTime) > 0)

			-- section immediately below moved to customer signup
			IF (@CustomerCount > 0)
				BEGIN
					SET @mainClient = 0;

					SET @MainCustomerID = (SELECT c.CustomerID FROM [Customer].[Customer] c
											  INNER JOIN [Map].[ThirdPartyProviderMap] tppm ON tppm.CustomerID = c.CustomerID
											  WHERE tppm.CompanyID = @companyID
											  AND c.MainClient = 1 )
				END

			/*DECLARE db_cursor CURSOR 
			FOR SELECT customerID 
			FROM [Customer].[Customer]
				WHERE CustomerID in (SELECT customerID from [Map].[ThirdPartyProviderMap] where companyID = @companyID)

			OPEN db_cursor   
			FETCH NEXT FROM db_cursor INTO @customerID_toCheck   

			WHILE @@FETCH_STATUS = 0   
			BEGIN    
					DECLARE @checkMain int = ( SELECT customerID from [Customer].[Customer] where CustomerID = @customerID_toCheck and MainClient = 1  )
				   if ( @checkMain is not null )
						BEGIN
							set @mainClient = 0 
						END 
				    FETCH NEXT FROM db_cursor INTO @customerID_toCheck   
			END   

			CLOSE db_cursor   
			DEALLOCATE db_cursor  
			print(@mainClient)*/

		IF(@organizationBranchID = 0  )
			BEGIN
					if(  @CustomerCount = 0 )
						BEGIN

							INSERT INTO [Customer].[Organization]
								   (
								   [OrganizationTypeID]
								   ,[Name]
								   ,[CreatedDateTime]
								   ,[CreatedBy]
								   ,[UpdatedDateTime]
								   ,[UpdatedBy]
								   ,[CompanyTypeID]
								   ,[Note]
								   ,[EIN] 
								   )
							 VALUES
								   (
									@organizationTypeID
								   ,@CompanyName
								   ,@CreatedUpdateDateTime
								   ,@createdUpdatedBy
								   ,@CreatedUpdateDateTime
								   ,@createdUpdatedBy
								   ,null
								   ,@loggedInUserName_type
								   ,null
								   )
							DECLARE @OrganizationID int = SCOPE_IDENTITY()
 

							INSERT INTO [Customer].[OrganizationBranch]
								   (
									[OrganizationID]
								   ,[Name]   
								   ,[companyShortName]
								   ,[IsActive]
								   ,[CreatedDateTime]
								   ,[CreatedBy]
								   ,[UpdatedDateTime]
								   ,[UpdatedBy]
								   ,[Note]

								   )
							 VALUES
								   (
									@OrganizationID
								   ,@CompanyName  
								   ,@CompanyShortName 
								   ,1
								   ,@CreatedUpdateDateTime
								   ,@createdUpdatedBy
								   ,@CreatedUpdateDateTime
								   ,@createdUpdatedBy
								   ,@loggedInUserName_type

								   )
 

							set @OrganizationBranchID = SCOPE_IDENTITY()

					END
					ELSE 
						BEGIN
							set @OrganizationBranchID = ( SELECT [OrganizationBranchID] from [Customer].[person] where personID = 
															( SELECT personID from [Customer].[customer] where customerID in 
																	( SELECT customerID from [Map].[ThirdPartyProviderMap] where CompanyID  = @companyID ) 
																and MainClient  = 1 
															) 
														)
			  
						END
			
				
			END -- end of checking @organizationBranchID = 0
		
			if(@customerID = 0)
				BEGIN

					INSERT [Customer].[Person] 
							(  
								  [OrganizationBranchID]
								, [PersonTitleTypeID]
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
								  @OrganizationBranchID
								, @personTitleTypeID
								, @FirstName
								, @LastName
								, @Email
								, @createdUpdatedBy   
								, @createdUpdatedBy  
								, @CreatedUpdateDateTime
								, @CreatedUpdateDateTime
								, @loggedInUserName_type
								)
						DECLARE @PersonID int = SCOPE_IDENTITY()
 
			
						INSERT INTO [Customer].[Customer]
						(
					
							[CustomerTypeID],
							[isPrimary],
							[PersonID],
							[StatusGroupMapID],
							[IsActive],
							[Description],
							[CreatedBy],
							[UpdatedBy],
							[CreatedDateTime],
							[UpdatedDateTime],
							[Note], 
							[VerificationCode],
							[MainClient],
							[MainCustomerID]

						)
						VALUES
						( 
							@CustomerTypeID,
							1, -- is primary
							@PersonID,
							@statusGroupMapID,
							1, -- isActive
							@FirstName + ' ' + @LastName ,
							@createdUpdatedBy ,
							@createdUpdatedBy ,
							@CreatedUpdateDateTime,
							@CreatedUpdateDateTime,
							@loggedInUserName_type,
							@VerificationCode,
							@mainClient,
							@MainCustomerID

						)
		
						SET @CustomerID = scope_identity()

						-- moved to customer signup
						/*IF (@CustomerCount = 0)
							BEGIN
								UPDATE [Customer].[Customer] SET MainCustomerID = @CustomerID WHERE CustomerID = @CustomerID;
							END */ 
				END
			ELSE
				BEGIN 
					
						IF (@CustomerCount = 0)
							BEGIN
								SET @MainCustomerID = @CustomerID;
							END 

					UPDATE [Customer].[Customer]
					   SET  
						   [Description] = @loggedInUserName_type
						  ,[UpdatedDateTime] = CURRENT_TIMESTAMP
						  ,[UpdatedBy] = @createdUpdatedBy
						  ,[Note] = @loggedInUserName_type
						  ,[MainCustomerID] = @MainCustomerID 
					 WHERE CustomerID = @customerID

					
					UPDATE [Customer].[Person]
					   SET [OrganizationBranchID] = @organizationBranchID         
						  ,[PersonTitleTypeID]	= @personTitleTypeID	
						  ,[UpdatedDateTime]	= CURRENT_TIMESTAMP
						  ,[UpdatedBy]			= @createdUpdatedBy
						  ,[Note]				= @loggedInUserName_type
					 WHERE PersonID = (SELECT personID from Customer.Customer where CustomerID = @customerID)


				END	
				
				if( ( SELECT count(loginID) FROM [Customer].[Login] where CustomerID = @customerID ) = 0 )
					BEGIN 
						INSERT INTO [Customer].[Login]
							(
							[CustomerID]
							,[UserName]
							,[PassCode]
							,[Salt]
							,[LastLoginDateTime]
							,[IsActive]
							,[CreatedDateTime]
							,[CreatedBy]
							,[UpdatedDateTime]
							,[UpdatedBy]
							,[Note]
							,[LoginAttempts]
							)
						VALUES
							(
							@CustomerID
							,@KronosUserName
							,'tempPassword404'
							,null
							,null
							,0
							,@CreatedUpdateDateTime
							,@createdUpdatedBy
							,@CreatedUpdateDateTime
							,@createdUpdatedBy
							,@loggedInUserName_type
							,null
							)
 

					DECLARE @loginID int = scope_identity()

					
					INSERT INTO [Map].[LoginMap]
							(
							[LoginID]
							,[DomainGroupMapID]
							,[AuthenticationTypeID]
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
							@loginID
							,@domainGroupMap
							,@authenticationType
							,0 --isActive
							,@FirstName + ' ' + @LastName
							,@CreatedUpdateDateTime
							,@createdUpdatedBy
							,@CreatedUpdateDateTime
							,@createdUpdatedBy
							,@loggedInUserName_type
							)
 
				END


			INSERT INTO [Map].[ThirdPartyProviderMap]
				   (
				    [CustomerID]   
				   ,[OneLoginUserID]
				   ,[OneLoginAppID]
				   ,[ExternalID]
				   ,[AccountID]
				   ,[CompanyID]
				   ,[ThirdPartyProviderID] 
				   ,[Description]
				   ,[CreatedDateTime]
				   ,[CreatedBy]
				   ,[UpdatedDateTime]
				   ,[UpdatedBy]
				   ,[Note]
				   )
			 VALUES
				   (
				    @CustomerID   
				   ,null
				   ,null
				   ,null
				   ,@accountID
				   ,@companyID
				   ,@thirdPartProviderID 
				   ,@FirstName + ' ' + @LastName  
				   ,@CreatedUpdateDateTime 
				   ,@createdUpdatedBy
				   ,@CreatedUpdateDateTime
				   ,@createdUpdatedBy
				   ,@loggedInUserName_type
			)


 


  

	SELECT  c.CustomerID, c.VerificationCode , c.MainClient,
			p.PersonID, p.firstName , p.lastName, p.Email,
			ob.name OrganizationName, ob.OrganizationBranchID, l.lastLoginDateTime lastLogin
	FROM [Customer].[Customer] c
	
	INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
	INNER JOIN [Customer].[OrganizationBranch] ob on p.OrganizationBranchID =  ob.OrganizationBranchID
	INNER JOIN [Customer].[Login] l on l.CustomerID = c.CustomerID -- added by Hamlet 1/25/18 for knowing whether to send email to Kronos Client after invitation to Suite
			  
	WHERE c.customerID = @customerID
			
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
