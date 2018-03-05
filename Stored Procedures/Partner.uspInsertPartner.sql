SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Partner].[uspInsertPartner]
	
	  @PartnerTypeID		int
	 ,@customerID			bigint
	 ,@PersonTitleTypeID	int				 = NULL
	 ,@CompanyTypeID		int				 = NULL
	 ,@Name					varchar(150)
	 ,@Alias				varchar(150)	 = NULL
	/* ,@Address1				varchar(100)	 = NULL
	 ,@Address2				varchar(100)	 = NULL
	 ,@City					varchar(50)		 = NULL
	 ,@StateCode			varchar(2)		 = NULL
	 ,@ZipCode				varchar(5)		 = NULL
	 ,@Email				varchar(150)	 = NULL
	 ,@PhoneNumber			varchar(25)		 = NULL
	 ,@FaxNumber			varchar(25)		 = NULL*/
	 ,@Gender				varchar(10)		 = NULL
	 ,@isActive				bit
	 ,@OwnershipPercent		float			 = NULL
	 ,@userName				varchar(150)	 = NULL
	 ,@note					[Note]			 = NULL
	 

	  
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			DECLARE @PartnerID bigint 

			DECLARE @DateTimeStamp datetime = CURRENT_TIMESTAMP

			INSERT INTO [Partner].[Partner]
				   (
					[PartnerTypeID]
				   ,[PersonTitleTypeID]
				   ,[CompanyTypeID]
				   ,[Name]
				   ,[Alias]
				 /*  ,[Address1]
				   ,[Address2]
				   ,[City]
				   ,[StateCode]
				   ,[ZipCode]
				   ,[Email]
				   ,[PhoneNumber]
				   ,[FaxNumber]*/
				   ,[Gender]
				   ,[OwnershipPercent]
				   ,[IsActive]
				   ,[CreatedDateTime]
				   ,[CreatedBy]
				   ,[UpdatedDateTime]
				   ,[UpdatedBy]
				   ,[Note]
			   )
		 VALUES
			   (
					@PartnerTypeID
				   ,@PersonTitleTypeID
				   ,@CompanyTypeID
				   ,@Name
				   ,@Alias
				  /* ,@Address1
				   ,@Address2
				   ,@City
				   ,@StateCode
				   ,@ZipCode
				   ,@Email
				   ,@PhoneNumber
				   ,@FaxNumber*/
				   ,@Gender
				   ,@OwnershipPercent
				   ,@isActive
				   ,@DateTimeStamp
				   ,@userName
				   ,@DateTimeStamp
				   ,@userName
				   ,@note
			   )
			 

		SET @PartnerID = SCOPE_IDENTITY()
			
		INSERT INTO [Map].[CustomerPartner]
			   ([PartnerID]
			   ,[CustomerID]
			   ,[Description]
			   ,[IsActive]
			   ,[CreatedDateTime]
			   ,[CreatedBy]
			   ,[UpdatedDateTime]
			   ,[UpdatedBy]
			   ,[Note])
		VALUES
			   (
				@PartnerID
			   ,@customerID
			   ,@Name
			   ,@isActive 
			   ,@DateTimeStamp
			   ,@userName
			   ,@DateTimeStamp
			   ,@userName
			   ,@note
			   )


		execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @DateTimeStamp , @note
		
		SELECT * FROM [Partner].[Partner] WHERE PartnerID = @PartnerID

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
