SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Customer].[uspUpdatePerson]
	

	@CustomerID				int			,
  --@OrganizationBranchName varchar(50)	, 
	@FirstName				varchar(50)	,
	@LastName				varchar(50)	,
	@DateOfBirth			date		,
	@Gender					varchar(15)	,
	@Email					varchar(150)			 

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			DECLARE @UpdateDateTime datetime		=  CURRENT_TIMESTAMP
			DECLARE @updated_By		varchar(45)		= ( select username from [Customer].[Login] where CustomerID = @CustomerID )
			DECLARE @Note			varchar(45)		= 'person Updated'
			
			/*DECLARE @OrganizationBranchID	int		= ( SELECT OrganizationBranchID from [Customer].[OrganizationBranch] 
														where Name = @OrganizationBranchName )*/
			
			DECLARE @personID				int		= ( SELECT PersonID from [Customer].[Customer] where customerID = @CustomerID )
			


			UPDATE [Customer].[Person]
			   SET 
			    -- [OrganizationBranchID]	= @OrganizationBranchID 
				   [FirstName]				= @FirstName
				  ,[LastName]				= @LastName
				  ,[DateOfBirth]			= @DateOfBirth
				  ,[Gender]					= @Gender
				  ,[Email]					= @Email
				  ,[UpdatedDateTime]		= @UpdateDateTime
				  ,[UpdatedBy]				= @updated_By
				  ,[Note]					= @Note
			 
			 WHERE PersonID = @personID

			
			 UPDATE [Customer].[Customer]
				SET  
					 [UpdatedDateTime]	= @UpdateDateTime
					,[UpdatedBy]		= @updated_By
					,[Note]				= @Note
			 
			 WHERE CustomerID = @CustomerID

	
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
