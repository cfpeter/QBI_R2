SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Organization].[uspUpdateOrganizationBranch]
	
	@UserName varchar(50),
	@OrganizationBranchName varchar(50),
	@CustomerID int = null,
	@ClientID varchar(50) = null,	
	@OrganizationBranchPhoneNumber varchar(50) = null,
	@OrganizationBranchFaxNumber varchar (50) = null,
	@OrganizationBranchEmail varchar(50) = null,
	@TotalEmployees int = null,
	@YearCoBegan varchar(45) = null,
	@NatureOfBusiness varchar(250) = null,
	@Note [NOTE] = null

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DECLARE @DateTimeStamp datetime = CURRENT_TIMESTAMP

			IF @ClientID IS NOT NULL AND ( @CustomerID IS NULL OR @CustomerID = 0)
			BEGIN 
				SET @CustomerID = ( SELECT customerID from [Customer].[Customer] WHERE CRMClientID = @ClientID and IsPrimary = 1 and MainClient = 1  )
			END
			ELSE
			BEGIN
				SET @ClientID = 'Undefined'
			END

			
			
			DECLARE @OrganizationBranchID int	= (select ob.OrganizationBranchID from [Customer].[Customer] c
													INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
													INNER JOIN [Customer].[OrganizationBranch] ob on p.OrganizationBranchID = ob.OrganizationBranchID
													INNER JOIN [Customer].[Organization] o on ob.OrganizationID = o.OrganizationID
												where  c.CustomerID = @CustomerID )		

		   IF @OrganizationBranchID IS NOT NULL 
		   BEGIN
				UPDATE [Customer].[OrganizationBranch]
				   SET
					 --[OrganizationID]		= @OrganizationID
					   [Name]				= IsNull(@OrganizationBranchName,[Name])
					  ,[PhoneNumber]		= IsNull(@OrganizationBranchPhoneNumber,[PhoneNumber])
					  ,[FaxNumber]			= IsNull(@OrganizationBranchFaxNumber,[FaxNumber])
					  ,[Email]				= IsNull(@OrganizationBranchEmail,[Email])
					  ,[TotalEmployees]		= IsNull(@TotalEmployees,[TotalEmployees])
					  ,[YearCoBegan]		= IsNull(@YearCoBegan,[YearCoBegan])
					  ,[IsActive]			= 1 -- active 
					  ,[UpdatedDateTime]	= @DateTimeStamp
					  ,[UpdatedBy]			= @UserName
					  ,[Note]				= IsNull(@Note,[Note])
					  ,[NatureOfBusiness]	= IsNull(@NatureOfBusiness,[NatureOfBusiness])
			
				 WHERE OrganizationBranchID = @OrganizationBranchID

				 execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @DateTimeStamp , @Note
							
				 SELECT * FROM [Customer].[OrganizationBranch] WHERE OrganizationBranchID = @OrganizationBranchID
	
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
