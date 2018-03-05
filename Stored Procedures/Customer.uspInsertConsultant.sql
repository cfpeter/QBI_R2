SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspInsertConsultant]
	
	 @createdUpdatedBy	varchar(50)
	,@FirstName			varchar(50)
	,@LastName			varchar(50)
	,@Email				varchar(50) 
	,@PhoneNumber		varchar(50) = NULL  
	,@Title				varchar(50)  
	,@customerID		int out
	
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			--DECLARE @Addres1Name varchar(45) = ( SELECT Address1 from [Customer].[Address] where Address1 = @Street1 ) 
			--DECLARE @cityName varchar(45) = ( SELECT city from [Customer].[Address] where city = @City ) 

			DECLARE @insertType varchar(50)			=  'import consultant from crm' 
			DECLARE @personTitleTypeID int			= (SELECT PersonTitleTypeID FROM [Definition].[PersonTitleType] WHERE Name =  @Title ) 
			DECLARE @departmentID int				= (SELECT DepartmentID FROM [Definition].[Department] WHERE Name =  'TBD' )
			DECLARE @consultantPersonID int			= (SELECT personID from [Customer].[Person] where Email = @Email ) 
			-- DECLARE @StateID int					= (SELECT StateID FROM [Definition].[State] WHERE Code = @State )
		
			IF (@personTitleTypeID IS NULL)
				BEGIN
					INSERT INTO [Definition].[PersonTitleType]
					(
						[Name]
						,[Description]
						,[CreatedDateTime]
						,[CreatedBy]
						,[UpdatedDateTime]
						,[UpdatedBy]
						,[Note]
				   
					)
					VALUES(
						@Title
						,@Title -- Description
						,CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						,CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						,@insertType
					)
					SET @personTitleTypeID = scope_identity()
				END

			IF (@consultantPersonID > 0)
				BEGIN

					UPDATE [Customer].[Person]
						SET [PersonTitleTypeID] = @personTitleTypeID
						  ,[FirstName] = @FirstName
						  ,[LastName] = @LastName      
						  ,[UpdatedDateTime] = CURRENT_TIMESTAMP
						  ,[UpdatedBy] = @createdUpdatedBy
						WHERE PersonID = @consultantPersonID

					SET @customerID = ( SELECT CustomerID FROM [Customer].[Customer]  where PersonID = @consultantPersonID)
				END
			ELSE IF ( @consultantPersonID IS NULL ) 
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
						,@departmentID -- TBD
						,@personTitleTypeID
						,@FirstName
						,@LastName
						,@Email
						, CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						, CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						,@insertType
						)
		
					SET @consultantPersonID = scope_identity()


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
						,@consultantPersonID
						,1 -- active
						,@FirstName + ' ' + @LastName 
						, CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						, CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						,@insertType
						)
					SET @customerID = scope_identity()


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
							@consultantPersonID
						,1 -- woodland hills 
						,CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						,CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						,@insertType
						)
				END



				IF ( @PhoneNumber IS NOT NULL AND @PhoneNumber NOT IN (SELECT Number FROM [Customer].[Phone] WHERE PersonID = @consultantPersonID ))
					BEGIN
						IF ((SELECT phoneID FROM [Customer].[Phone] WHERE PersonID = @consultantPersonID) IS NULL)
							BEGIN							
								INSERT INTO [Customer].[Phone]
									(
										[PhoneTypeID],
										[PersonID],
										[Number],
										[CreatedDateTime],
										[CreatedBy],
										[UpdatedDateTime],
										[UpdatedBy],
										[Note]
									)
									VALUES
									(
										2, --work
										@consultantPersonID,
										@PhoneNumber,
										CURRENT_TIMESTAMP,
										@createdUpdatedBy , 
										CURRENT_TIMESTAMP,
										@createdUpdatedBy ,
										@insertType + ' | ' + @FirstName + ' ' + @LastName 
									)
							END
						ELSE
							BEGIN
								UPDATE [Customer].[Phone]
								   SET [PhoneTypeID] = 2 --work
									  ,[PersonID] = @consultantPersonID
									  ,[Number] = @PhoneNumber
									  ,[CreatedDateTime] = CURRENT_TIMESTAMP
									  ,[CreatedBy] = @createdUpdatedBy
									  ,[UpdatedDateTime] = CURRENT_TIMESTAMP
									  ,[UpdatedBy] = @createdUpdatedBy
									  ,[Note] = @insertType + ' | ' + @FirstName + ' ' + @LastName 
								 WHERE PersonID = @consultantPersonID
							END
					END
					
/*
			DECLARE @consultantPersonAddressID int = ( SELECT personID FROM [Map].[PersonAddress] where personID = @consultantPersonID  )

			DECLARE @addressID int


		if @consultantPersonAddressID is NULL
			BEGIN
		
				if @Addres1Name = '21031 Ventura Blvd.' and @cityName = 'Woodland Hills'
					BEGIN
						set @addressID = ( SELECT AddressID from [Customer].[Address] where Address1 = @Street1 AND  city = @City ) 
					END
				else if @Addres1Name = '114 Pacifica' and @cityName = 'Irvine'
					BEGIN
						set @addressID = ( SELECT AddressID from [Customer].[Address] where Address1 = @Street1 AND  city = @City ) 
					END
				else
					BEGIN
						if @Street1 IS NOT NULL
							BEGIN
								INSERT INTO [Customer].[Address]
									(
										 [AddressTypeID]
										,[CountryID]
										,[Address1]
										,[Address2]
										,[City]
										,[StateID]
										,[ZipCode]
										,[CreatedDateTime]
										,[CreatedBy]
										,[UpdatedDateTime]
										,[UpdatedBy]
										,[Note]

									)VALUES
									(
										 1 -- work
										,1 -- california
										,@Street1
										,@Street2
										,@City
										,@StateID
										,@ZipCode
										,CURRENT_TIMESTAMP
										,@createdUpdatedBy  
										,CURRENT_TIMESTAMP
										,@createdUpdatedBy  
										,@insertType
							
									)
								SET @addressID = SCOPE_IDENTITY()
							END -- end of street1
						else
							BEGIN
								SET @addressID = 1
							END
					END -- end of else

		
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
						 @consultantPersonID
						,@addressID
						,CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						,CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						,@insertType
					)

			END		
			
			*/	
						
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
