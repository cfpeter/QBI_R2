SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian>
-- Create date: <03/013/2017>
-- Description:	<update contact to person table>
-- =============================================
CREATE PROCEDURE [Contact].[uspUpdateContactPerson]
	@PersonID bigint,
	@CustomerID bigint,
	@FirstName varchar(50),
    @LastName varchar(50),
	@Email varchar(150),
	@UserName varchar(50),
	@IsPrimary bit,
	@MainClient bit = 1,
	@OrganizationBranchID bigint = null,
    @DepartmentID int = null,
    @PersonTitleTypeID int = null,
    @PrefixTypeID int = null,   
    @DateOfBirth date = null,
    @Gender varchar(15) = null,   
	@PhoneNumberID int = null,  
	@PhoneNumber varchar(25) = null,   
	@PhoneTypeID int = null,    
	@DistributeTo bit = null, 
    @Note [Note] = 'updateing client contact'
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			DECLARE @CRMClientID int = null
			DECLARE @crmContactID  int = null

			DECLARE @DateTimeStamp datetime = CURRENT_TIMESTAMP

			DECLARE @CustomerTypeID int  = (SELECT CustomerTypeID FROM [Customer].[Customer] WHERE CustomerID = @CustomerID)

			--if  @IsPrimary = 1
				--set @CustomerID = ( SELECT customerID from [Customer].[Customer] where PersonID = @PersonID and IsPrimary = 1 and MainClient = 1 )

			/*IF( @CustomerTypeID = 3)
			BEGIN
				SET @IsPrimary = 1
			ENd*/
   

		UPDATE [Customer].[Person]
			SET
				[OrganizationBranchID]	= @OrganizationBranchID ,
				[DepartmentID]			= @DepartmentID ,
				[PersonTitleTypeID]		= @PersonTitleTypeID ,
				[FirstName]				= @FirstName ,
				[LastName]				= @LastName ,
				[DateOfBirth]			= @DateOfBirth ,
				[Gender]				= @Gender ,
				[Email]					= @Email ,
				[UpdatedDateTime]		= @DateTimeStamp ,
				[UpdatedBy]				= @UserName,
				[DistributeTo]			= @DistributeTo,
				[Note]					= @Note

			where PersonID = @PersonID
		IF( @PhoneNumberID is not null AND @PhoneNumber IS NOT NULL AND @PhoneTypeID is not null)
			BEGIN

				UPDATE [Customer].[Phone]
				SET
				
					 [PhoneTypeID]		= @PhoneTypeID
					--,[PersonID]			= @PersonID
					,[Number]			= @PhoneNumber
					,[UpdatedDateTime]	= @DateTimeStamp
					,[UpdatedBy]		= @UserName 
					,[Note]				= @Note

				where PhoneID			= @PhoneNumberID
			END	
		ELSE IF (@PhoneNumber IS NOT NULL AND @PhoneTypeID IS NOT NULL)
			BEGIN
				INSERT INTO [Customer].[Phone]
						   ([PhoneTypeID]
						   ,[PersonID]
						   ,[Number]
						   ,[CreatedDateTime]
						   ,[CreatedBy]
						   ,[UpdatedDateTime]
						   ,[UpdatedBy]
						   ,[Note])
					 VALUES
						   (@PhoneTypeID
						   ,@PersonID
						   ,@PhoneNumber
						   ,@DateTimeStamp
						   ,@UserName
						   ,@DateTimeStamp
						   ,@UserName
						   ,@Note)
			END
			
			if( @IsPrimary = 1 )
				BEGIN
					execute [Customer].[uspUpdateCustomerPerson] @CustomerID, @PersonID, @IsPrimary, @CRMClientID , @crmContactID ,@MainClient, @UserName, @DateTimeStamp , @Note
				END	 
		--	SET @PersonID = ( SELECT personID FROM [Customer].[Customer] where CustomerID = @CustomerID )
		
			SELECT p.*
					,c.IsPrimary
					,c.MainClient
					,ph.PhoneID PhoneNumberID
					,ph.Number PhoneNumber
					,ph.PhoneTypeID
			FROM [Customer].[Person] p 
			INNER JOIN (
			
				select PersonID,IsPrimary,MainClient from [customer].[Customer] 
				where CustomerID = @CustomerID and IsPrimary = 1

			) c ON p.PersonID = c.PersonID 
			LEFT JOIN [Map].[PersonPhoneMap] ppm on p.PersonID = ppm.PersonID
			LEFT JOIN [Customer].[Phone] ph	ON ppm.PhoneID = ph.PhoneID
			WHERE p.PersonID = c.PersonID 

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
