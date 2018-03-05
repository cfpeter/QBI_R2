SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <03/06/2017>
-- Description:	<Insert contact to person table>
-- =============================================
CREATE PROCEDURE [Contact].[uspInsertContactPerson]
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
	@PhoneNumber varchar(25) = null,   
	@PhoneTypeID int = null,  
	@DistributeTo bit = null, 
    @Note [Note] = 'Inserting new client contact'
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DECLARE @CRMClientID int = null
			DECLARE @crmContactID  int = null
			DECLARE @DateTimeStamp datetime = CURRENT_TIMESTAMP

			DECLARE @CustomerTypeID int  = (SELECT CustomerTypeID FROM [Customer].[Customer] WHERE CustomerID = @CustomerID)

			/*IF( @CustomerTypeID = 3)
			BEGIN
				SET @IsPrimary = 1
			ENd*/
    -- Insert statements for procedure here
			INSERT INTO [Customer].[Person]
				   ([OrganizationBranchID]
				   ,[DepartmentID]
				   ,[PersonTitleTypeID]
				   ,[PrefixTypeID]
				   ,[FirstName]
				   ,[LastName]
				   ,[DateOfBirth]
				   ,[Gender]
				   ,[Email]
				   ,[CreatedDateTime]
				   ,[CreatedBy]
				   ,[UpdatedDateTime]
				   ,[UpdatedBy]
				   ,[DistributeTo]
				   ,[Note])
			 VALUES
				   (@OrganizationBranchID
				   ,@DepartmentID
				   ,@PersonTitleTypeID
				   ,@PrefixTypeID
				   ,@FirstName
				   ,@LastName
				   ,@DateOfBirth
				   ,@Gender
				   ,@Email
				   ,@DateTimeStamp
				   ,@UserName
				   ,@DateTimeStamp
				   ,@UserName
				   ,@DistributeTo
				   ,@Note)

			DECLARE @PersonID bigint = scope_identity()

			IF( @PhoneNumber is not null AND @PhoneTypeID is not null )
			BEGIN
				INSERT INTO [Customer].[Phone]
						   ([PhoneTypeID]
						   --,[PersonID]
						   ,[Number]
						   ,[CreatedDateTime]
						   ,[CreatedBy]
						   ,[UpdatedDateTime]
						   ,[UpdatedBy]
						   ,[Note])
					 VALUES
						   (@PhoneTypeID
						   --,@PersonID
						   ,@PhoneNumber
						   ,@DateTimeStamp
						   ,@UserName
						   ,@DateTimeStamp
						   ,@UserName
						   ,@Note)

				DECLARE @PhoneNumberID bigint = scope_identity()

				INSERT INTO [Map].[PersonPhoneMap] (PersonID, PhoneID, CreatedDateTime, UpdatedDateTime, CreatedBy, UpdatedBy) 
					VALUES (@PersonID, @PhoneNumberID, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, @UserName, @UserName)
			END	

			-- execute [Customer].[uspUpdateCustomerPerson] @CustomerID, @PersonID, @IsPrimary, @MainClient, @UserName, @DateTimeStamp , @Note
			
			if( @IsPrimary = 1 )
				BEGIN
					execute [Customer].[uspUpdateCustomerPerson] @CustomerID, @PersonID, @IsPrimary, @CRMClientID , @crmContactID ,@MainClient, @UserName, @DateTimeStamp , @Note
				END
			
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
			LEFT JOIN [Customer].[Phone] ph ON p.PersonID = ph.PersonID
			WHERE p.PersonID = c.PersonID 
			
			
			/*SELECT p.*
					,c.IsPrimary
					,c.MainClient
					,ph.PhoneID PhoneNumberID
					,ph.Number PhoneNumber
					,ph.PhoneTypeID
			FROM [Customer].[Person] p 
			INNER JOIN [Customer].[Customer] c ON p.PersonID = c.PersonID
			LEFT JOIN [Customer].[Phone] ph ON p.PersonID = ph.PersonID
			WHERE p.PersonID = @personID*/

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
