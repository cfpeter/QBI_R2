SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Organization].[uspInsertOrganizationAndBranch]
	
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
	@NatureOfBusiness varchar(45) = null,
	@BusinessCode int = null,
	@Union bit = null,
	@isActive bit = null,
	@AffiliatedGroup varchar(250) = null,
	@ControlGroup varchar(300) = null,
	@PayrollProviderID int = null,
	@PayrollFrequencyID int = null,
	@WeekStart varchar(15) = null,
	@FYEDay int = null,
	@FYEMonth int = null,
	@IRCSection varchar(35) = null,
	@IsPrimaryBranch bit = null,
	@SSN varchar(250)  = null,
	@SSNKEY varchar(250)  = null,
	@Note [NOTE] = 'Company/Client infomation updated'


AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN

			DECLARE @OrganizationID bigint
			DECLARE @OrganizationBranchID bigint

			DECLARE @DateTimeStamp datetime = CURRENT_TIMESTAMP

			

				INSERT INTO [Customer].[Organization]
						   ([OrganizationTypeID]
						   ,[Name]
						   ,[CreatedDateTime]
						   ,[CreatedBy]
						   ,[UpdatedDateTime]
						   ,[UpdatedBy]
						   ,[CompanyTypeID]
						   ,[Note]
						   ,[EIN]
						   ,[Union]
						   ,[BusinessCode]
						   ,[AffiliatedGroup]
						   ,[ControlGroup])
					 VALUES
						   (@OrganizationTypeID
						   ,@OrganizationName
						   ,@DateTimeStamp
						   ,@UserName
						   ,@DateTimeStamp
						   ,@UserName
						   ,@CompanyTypeID
						   ,@Note
						   ,@EIN
						   ,@Union
						   ,@BusinessCode
						   ,@AffiliatedGroup
						   ,@ControlGroup)


				SET @OrganizationID = SCOPE_IDENTITY()

				INSERT INTO [Customer].[OrganizationBranch]
						   ([OrganizationID]
						   ,[Name]
						   ,[PhoneNumber]
						   ,[FaxNumber]
						   ,[Email]
						   ,[IsActive]
						   ,[CreatedDateTime]
						   ,[CreatedBy]
						   ,[UpdatedDateTime]
						   ,[UpdatedBy]
						   ,[Note]
						   ,[YearCoBegan]
						   ,[TotalEmployees]
						   ,[PayrollProviderID]
						   ,[PayrollFrequencyID]
						   ,[WeekStart]
						   ,[FYEDay]
						   ,[FYEMonth]
						   ,[NatureOfBusiness]
						   ,[IRCSection]
						   ,[IsPrimaryBranch])
					 VALUES
						   (@OrganizationID
						   ,@OrganizationBranchName
						   ,@OrganizationBranchPhoneNumber
						   ,@OrganizationBranchFaxNumber
						   ,@OrganizationBranchEmail
						   ,@IsActive
						   ,@DateTimeStamp
						   ,@UserName
						   ,@DateTimeStamp
						   ,@UserName
						   ,@Note
						   ,@YearCoBegan
						   ,@TotalEmployees
						   ,@PayrollProviderID
						   ,@PayrollFrequencyID
						   ,@WeekStart
						   ,@FYEDay
						   ,@FYEMonth
						   ,@NatureOfBusiness
						   ,@IRCSection
						   ,@IsPrimaryBranch)

					SET @OrganizationBranchID = SCOPE_IDENTITY()
				
				 DECLARE @personID int = (SELECT personID from [Customer].[Customer] where CustomerID = @CustomerID)
				
				 if @personID IS NOT NULL
				 BEGIN
					 UPDATE [Customer].[Person]
						SET
							 [OrganizationBranchID]	= @OrganizationBranchID
							,[SSN]					= @SSN
							,[SSNKEY]				= @SSNKEY
							,[UpdatedDateTime]		= CURRENT_TIMESTAMP
							,[UpdatedBy]			= @UserName
					 WHERE PersonID = @personID
				 END
					 



				 execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @DateTimeStamp , @Note

				 SELECT * FROM [Customer].[Organization] WHERE OrganizationID = @OrganizationID
							
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
