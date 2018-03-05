SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Organization].[uspUpdateOrganization]

	@UserName varchar(50),
	--ID's
	@CustomerID int	= null,	
	@ClientID varchar(30) = NULL,
	--organization type
	@OrganizationTypeName varchar(50) = null,
	@OrganizationTypeID int = null			,
	
	--Company type
	@CompanyTypeName varchar(50) = null		,
	@CompanyTypeID int	= null				,

	--organization
	@OrganizationName varchar(150) = null	, 
	@Union bit = null						,
	@BusinessCode int = null				,
	@AffiliatedGroup varchar(45) = null		,
	@ControlGroup varchar(45) = null		,
	@EIN varchar(50) = null,
	@Note [Note] = null

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DECLARE @OrganizationID int = null
			
			if @ClientID IS NOT NULL AND @CustomerID IS NULL
				BEGIN 
					SET		@CustomerID				= ( SELECT CustomerID FROM [Customer].[Customer] WHERE CRMClientID = @ClientID  and MainClient = 1 )
				END
		 
			if @OrganizationTypeName IS NOT NULL AND @OrganizationTypeID IS NULL
				BEGIN
					SET		@OrganizationTypeID		= ( SELECT OrganizationTypeID FROM [Definition].[OrganizationType] WHERE Name = @OrganizationTypeName )
					
				END

			IF(@OrganizationTypeID is null)
				BEGIN
					SET	@OrganizationTypeID = 2 --unknown
				END
		
			if @CompanyTypeName IS NOT NULL AND @CompanyTypeID IS NULL
				BEGIN
					SET		@CompanyTypeID			= ( SELECT CompanyTypeID FROM [Definition].[CompanyType] WHERE Name = @CompanyTypeName )
				END

			IF(@CompanyTypeID is null)
				BEGIN
					SET	@CompanyTypeID = 1 --Uncoded
				END

			
			DECLARE @UpdateDateTime datetime		= CURRENT_TIMESTAMP
			
			PRINT '@CustomerID'
			PRINT @CustomerID

			IF @CustomerID is NOT NULL 
			BEGIN
				SET @OrganizationID = ( SELECT ob.OrganizationID FROM [Customer].[Customer] c
										INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
										INNER JOIN [Customer].[OrganizationBranch] ob on p.OrganizationBranchID = ob.OrganizationBranchID
										INNER JOIN [Customer].[Organization] o on ob.OrganizationID = o.OrganizationID
									WHERE  c.CustomerID = @CustomerID )
				
				PRINT '@OrganizationID'
				PRINT @OrganizationID

				IF @OrganizationID is NOT NULL 
				BEGIN
					UPDATE [Customer].[Organization]
					SET 
						[Name]				= isNULL(@OrganizationName,[Name])
						,[OrganizationTypeID] = isNULL(@OrganizationTypeID,[OrganizationTypeID])
						,[Union]				= isNULL(@Union,[Union])
						,[BusinessCode]		= isNULL(@BusinessCode,[BusinessCode])
						,[AffiliatedGroup]	= isNULL(@AffiliatedGroup,[AffiliatedGroup])
						,[ControlGroup]		= isNULL(@ControlGroup,[ControlGroup])
						,[EIN]				= isNULL(@EIN,[EIN])
						,[UpdatedDateTime]	= @UpdateDateTime
						,[UpdatedBy]			= @UserName
						,[CompanyTypeID]		= isNULL(@CompanyTypeID,[CompanyTypeID])
						,[Note]				= isNULL(@Note,[Note])
			
					WHERE OrganizationID		= @OrganizationID

					execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note
							
					SELECT * FROM [Customer].[Organization] WHERE OrganizationID = @OrganizationID

				END
				ELSE
				BEGIN
					DECLARE @Msg2 varchar(100) = 'Code:50000 Unknow Client, Unable to locate OrganizationID for Client ' + @ClientID
					RAISERROR (@Msg2, -- Message text.  
										16, -- Severity.  
										1 -- State.  
										);  
				END
		 
			END
			ELSE
			BEGIN
				DECLARE @Msg3 varchar(100) = 'Code:50000 Unknow Client, Unable to locate CustomerID for Client ' + @ClientID
				RAISERROR (@Msg3, -- Message text.  
										16, -- Severity.  
										1 -- State.  
										);  
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
