SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspInsertAssistants]
	
	 @createdUpdatedBy varchar (50)
	,@FirstName varchar(50)
	,@LastName varchar(50)
	,@Email varchar(50) 
	,@PhoneNumber varchar(50) = NULL
	--address
	,@City varchar(50) 
	,@State varchar(50) 
	,@Street1 varchar(50) 
	,@Street2 varchar(50) 
	,@ZipCode varchar(50) 
	,@Title varchar(50) 
	,@ConsultantPersonID int 
	,@customerID int out
	
	

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		--DECLARE @Addres1Name varchar(45) = ( SELECT Address1 from [Customer].[Address] where Address1 = @Street1 ) 
	--	DECLARE @cityName varchar(45) = ( SELECT city from [Customer].[Address] where city = @City ) 

		 DECLARE @insertType varchar(50)		=  'Inserted while importing plans as assistants' 
	
		 DECLARE @personTitleTypeID int			= (SELECT PersonTitleTypeID FROM [Definition].[PersonTitleType] WHERE Name =  @Title ) 
		
		 DECLARE @departmentID int				= (SELECT DepartmentID FROM [Definition].[Department] WHERE Name =  'TBD' )
		 DECLARE @AssistantsPersonID int		= (SELECT personID from [Customer].[Person] where Email = @Email ) 
		 DECLARE @StateID int					= ( SELECT StateID FROM [Definition].[State] WHERE Code = @State )

		 if (@personTitleTypeID IS NULL)
			BEGIN
				insert into [Definition].[PersonTitleType]
				(
					[Name]
				   ,[Description]
				   ,[CreatedDateTime]
			       ,[CreatedBy]
			       ,[UpdatedDateTime]
			       ,[UpdatedBy]
			       ,[Note]
				   
				)
				values(
					@Title
				   ,@Title -- Description
				   ,CURRENT_TIMESTAMP
				   ,@createdUpdatedBy  
			       ,CURRENT_TIMESTAMP
			       ,@createdUpdatedBy  
			       ,@insertType
				)
				set @personTitleTypeID = scope_identity()
			END


		 if( @AssistantsPersonID IS NULL ) 
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
		
			set @AssistantsPersonID = scope_identity()


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
				   ,@AssistantsPersonID
				   ,1
				   ,@FirstName + ' ' + @LastName 
				   , CURRENT_TIMESTAMP
				   ,@createdUpdatedBy  
				   , CURRENT_TIMESTAMP
				   ,@createdUpdatedBy  
				   ,@insertType
				   )
			SET @customerID = scope_identity()

			
			DECLARE @assistancePersonAddressID int = ( SELECT personID FROM [Map].[PersonAddress] where personID = @AssistantsPersonID  )
			if @assistancePersonAddressID is NULL
				BEGIN

				
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
						@AssistantsPersonID
						,1 -- woodland hills
						,CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						,CURRENT_TIMESTAMP
						,@createdUpdatedBy  
						,@insertType
					)
				END


		END
	ELSE
		BEGIN
			SET @customerID = ( SELECT CustomerID FROM [Customer].[Customer]  where PersonID = @AssistantsPersonID )
		END

		DECLARE @phonePersonID int = (SELECT PersonID FROM [Customer].[Phone] WHERE PersonID = @AssistantsPersonID )
		
		if( @phonePersonID IS NULL )
		BEGIN

				IF( @PhoneNumber is not null )
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
									2,
									@AssistantsPersonID,
									@PhoneNumber,
									CURRENT_TIMESTAMP,
									@createdUpdatedBy , 
									CURRENT_TIMESTAMP,
									@createdUpdatedBy ,
									@insertType + ' | ' + @FirstName + ' ' + @LastName 
							   )
					--DECLARE @phoneID int = SCOPE_IDENTITY()


				End

		END
	--	DECLARE @assistanceID int		= ( select AssistancePersonID from [Map].[ConsultantAssistance] where AssistancePersonID = @AssistantsPersonID )
	--	DECLARE @consultantID int		= ( select ConsultantPersonID from [Map].[ConsultantAssistance] where AssistancePersonID = @AssistantsPersonID )
	--	DECLARE @ConsultantPersonID int = ( SELECT personID from [Customer].[customer] where customerID = @ConsultantCustomerID )

		DECLARE @ConsultantAssistanceID int		= ( select ConsultantAssistanceID from [Map].[ConsultantAssistance] where AssistancePersonID = @AssistantsPersonID and ConsultantPersonID = @ConsultantPersonID )
		if( @ConsultantAssistanceID IS NULL )
			BEGIN
					INSERT INTO [Map].[ConsultantAssistance]
					(
						 [ConsultantPersonID]
						,[AssistancePersonID]
						,[Description]
						,[isActive]
						,[CreatedDateTime]
						,[CreatedBy]
						,[UpdatedDateTime]
						,[UpdatedBy]
						,[Note]
					
					)
					VALUES(
						@ConsultantPersonID
					   ,@AssistantsPersonID
					   ,@FirstName + ' ' + @LastName
					   ,1
					   ,CURRENT_TIMESTAMP
					   ,@createdUpdatedBy  
					   ,CURRENT_TIMESTAMP
					   ,@createdUpdatedBy  
					   ,@insertType

					)

		END
		/*ELSE IF ( @assistanceID IS NOT NULL AND @ConsultantPersonID <> @consultantID)
			BEGIN

				INSERT INTO [Map].[ConsultantAssistance]
					(
						 [ConsultantPersonID]
						,[AssistancePersonID]
						,[Description]
						,[isActive]
						,[CreatedDateTime]
						,[CreatedBy]
						,[UpdatedDateTime]
						,[UpdatedBy]
						,[Note]
					
					)
					VALUES(
						@ConsultantPersonID
					   ,@AssistantsPersonID
					   ,@FirstName + ' ' + @LastName
					   ,1
					   ,CURRENT_TIMESTAMP
					   ,@createdUpdatedBy  
					   ,CURRENT_TIMESTAMP
					   ,@createdUpdatedBy  
					   ,@insertType

					)

			END*/

	/*	
			DECLARE @assistancePersonAddressID int = ( SELECT personID FROM [Map].[PersonAddress] where personID = @AssistantsPersonID  )

			DECLARE @addressID int


	if @assistancePersonAddressID is NULL
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
						@AssistantsPersonID
						,1 -- woodland hills
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
		if(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			exec dbo.uspRethrowError
		END
	 END CATCH
END



GO
