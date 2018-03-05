SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Organization].[uspUpdateOrganizationAndBranch]
	@OrganizationBranchID bigint,
	@OrganizationID bigint,
	@CustomerID bigint,	
	@CompanyTypeID int,
	@OrganizationTypeID int,
	@OrganizationName varchar(50),
	@OrganizationBranchName varchar(50),
	@EIN varchar(50) = null,
	@UserName varchar(50),
	@OrganizationBranchPhoneNumber varchar(50) = null,
	@OrganizationBranchFaxNumber varchar (50) = null,
	@OrganizationBranchEmail varchar(50) = null,
	@TotalEmployees int = null,
	@YearCoBegan varchar(45) = null,
	@NatureOfBusiness varchar(250) = null,
	@BusinessCode int = null,
	@Union bit = null,
	@isActive bit = null,
	@AffiliatedGroup varchar(250) = null,
	@ControlGroup varchar(300) = null,
	@PayrollProviderID int = null,
	@PayrollFrequesncyID int = null,
	@WeekStart varchar(15) = null,
	@FYEDay int = null,
	@FYEMonth int = null,
	@IRCSection varchar(35) = null,
	@IsPrimaryBranch bit = null,
	@SSN varchar(250) = null,
	@SSNKEY varchar(250) = null,
	@Note [NOTE] = 'Company/Client infomation updated'

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DECLARE @DateTimeStamp datetime = CURRENT_TIMESTAMP

				UPDATE [Customer].[Organization]
				   SET [OrganizationTypeID] = @OrganizationTypeID
					  ,[Name] = @OrganizationName				  
					  ,[UpdatedDateTime] = @DateTimeStamp
					  ,[UpdatedBy] = @UserName
					  ,[CompanyTypeID] = @CompanyTypeID
					  ,[Note] = @Note
					  ,[EIN] = @EIN
					  ,[Union] = @Union
					  ,[BusinessCode] = @BusinessCode
					  ,[AffiliatedGroup] = @AffiliatedGroup
					  ,[ControlGroup] = @ControlGroup
				 WHERE OrganizationID = @OrganizationID
		  
				UPDATE [Customer].[OrganizationBranch]
				   SET
					   [Name]				= IsNull(@OrganizationBranchName,[Name])
					  ,[PhoneNumber]		= IsNull(@OrganizationBranchPhoneNumber,[PhoneNumber])
					  ,[FaxNumber]			= @OrganizationBranchFaxNumber
					  ,[Email]				= IsNull(@OrganizationBranchEmail,[Email])
					  ,[TotalEmployees]		= @TotalEmployees
					  ,[YearCoBegan]		= IsNull(@YearCoBegan,[YearCoBegan])
					  ,[PayrollProviderID]  = @PayrollProviderID
					  ,[PayrollFrequencyID] = @PayrollFrequesncyID
					  ,[WeekStart]			= @WeekStart
					  ,[FYEDay]				= @FYEDay
					  ,[FYEMonth]			= @FYEMonth
					  ,[NatureOfBusiness]	= @NatureOfBusiness
					  ,IRCSection			= @IRCSection
					  ,IsPrimaryBranch		= @IsPrimaryBranch
					  ,[IsActive]			= @isActive
					  ,[UpdatedDateTime]	= @DateTimeStamp
					  ,[UpdatedBy]			= @UserName
					  ,[Note]				= IsNull(@Note,[Note])					  			
				 WHERE OrganizationBranchID = @OrganizationBranchID

				DECLARE @personID int = (SELECT personID from [Customer].[Customer] where CustomerID = @CustomerID)
				--if @personID IS NOT NULL
				-- BEGIN
					 UPDATE [Customer].[Person]
						SET
							 [SSN]					= @SSN
							,[SSNKEY]				= @SSNKEY
							,[UpdatedDateTime]		= CURRENT_TIMESTAMP
							,[UpdatedBy]			= @UserName
					 WHERE PersonID = @personID
				-- END

				 execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @DateTimeStamp , @Note

				 SELECT org.*, ct.Name CompanyTypeName 
					FROM [Customer].[Organization] org 
					LEFT JOIN [Definition].[CompanyType] ct ON org.CompanyTypeID = ct.CompanyTypeID
					WHERE OrganizationID = @OrganizationID
							
				 SELECT * FROM [Customer].[OrganizationBranch] WHERE OrganizationBranchID = @OrganizationBranchID
	
			

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
