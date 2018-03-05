SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspInsertKronosEmployees] 
	
	 @KronosUserName		varchar(100) 
	,@accountID         bigint
	,@companyID         bigint 
	,@FirstName			varchar(50) 
	,@LastName			varchar(50)  
	,@Email				varchar(50) 
	,@createdUpdatedBy	varchar(50)
	,@VerificationCode	varchar(10) 

	

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN 
			DECLARE @CreatedUpdateDateTime	datetime		= CURRENT_TIMESTAMP 
			DECLARE @loggedInUserName_type	varchar(50)		= 'Invitation sent for Kronos employee'  
					 
			DECLARE @CustomerTypeID			int				= ( SELECT CustomerTypeID			FROM [Definition].[CustomerType]		WHERE Name = 'Payroll Customer' )
			DECLARE @statusID				int 			= ( SELECT statusID					FROM [definition].[Status]				WHERE Name = 'Signup Invitation Pending' )
			DECLARE @statusGroupID			int				= ( SELECT statusGroupID			FROM [definition].[StatusGroup]			WHERE Name = 'Customer' )
			DECLARE @statusGroupMapID		int				= ( SELECT statusGroupMapID			FROM [Map].[StatusGroupMap]				WHERE StatusID = @statusID AND StatusGroupID = @statusGroupID )
			DECLARE @organizationTypeID		int				= ( SELECT [OrganizationTypeID]		FROM [Definition].[OrganizationType]	WHERE Name = 'Financial' )
			DECLARE @domainGroupMap			int				= ( SELECT domainGroupMapID			FROM [Map].[DomainGroupMap]				WHERE name = 'PayrollEmployee' )
			DECLARE @authenticationType		int				= ( SELECT authenticationTypeID		FROM [Definition].[AuthenticationType]	WHERE name = 'Basic' )
			
			DECLARE @thirdPartProviderID     int			= ( SELECT ThirdPartyProviderID FROM [Definition].[ThirdPartyProvider] where name = 'Kronos'  )
			DECLARE @personTitleTypeID int					= ( SELECT personTitleTypeID FROM [Definition].[PersonTitleType] where name = 'Employee'  )


			DECLARE @OrganizationBranchID int = ( SELECT [OrganizationBranchID] from [Customer].[person] where personID = 
													( SELECT personID from [Customer].[customer] where customerID in 
														( SELECT customerID from [Map].[ThirdPartyProviderMap] where CompanyID  = @companyID ) 
														and MainClient  = 1 
													) 
												 )
			 
		 


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
					[PersonID],
					[StatusGroupMapID],
					[IsActive],
					[Description],
					[CreatedBy],
					[UpdatedBy],
					[CreatedDateTime],
					[UpdatedDateTime],
					[Note], 
					[VerificationCode]
				)
				VALUES
				( 
					@CustomerTypeID, 
					@PersonID,
					@statusGroupMapID,
					1, -- isActive
					@FirstName + ' ' + @LastName ,
					@createdUpdatedBy ,
				    @createdUpdatedBy ,
					@CreatedUpdateDateTime,
					@CreatedUpdateDateTime,
					@loggedInUserName_type,
					@VerificationCode

				)
		
				DECLARE @CustomerID int = scope_identity()
				
   

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
			   ,'tempPassCode404'
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
 





	SELECT  c.CustomerID, c.VerificationCode , c.MainClient,
			p.firstName , p.lastName, p.Email,
			ob.name OrganizationName
	FROM [Customer].[Customer] c
	
	INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
	INNER JOIN [Customer].[OrganizationBranch] ob on p.OrganizationBranchID =  ob.OrganizationBranchID
			  
	WHERE customerID = @CustomerID   
			
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
