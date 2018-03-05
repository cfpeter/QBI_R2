SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Partner].[uspUpdatePartnerByID]
	
	  @PartnerID			int	
	 ,@PartnerTypeID		int
	 ,@customerID			bigint
	 ,@PersonTitleTypeID	int				 = NULL
	 ,@CompanyTypeID		int				 = NULL
	 ,@Name					varchar(150)
	 ,@Alias				varchar(150)	 = NULL
	 /*,@Address1				varchar(100)	 = NULL
	 ,@Address2				varchar(100)	 = NULL
	 ,@City					varchar(50)		 = NULL
	 ,@StateCode			varchar(2)		 = NULL
	 ,@ZipCode				varchar(5)		 = NULL
	 ,@Email				varchar(150)	 = NULL
	 ,@PhoneNumber			varchar(25)		 = NULL
	 ,@FaxNumber			varchar(25)		 = NULL*/
	 ,@Gender				varchar(10)		 = NULL
	 ,@OwnershipPercent		float			 = NULL
	 ,@isActive				bit
	 ,@userName				varchar(150)	 = NULL
	 ,@note					[Note]			 = NULL
	 

	  
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			 

		DECLARE @DateTimeStamp datetime = CURRENT_TIMESTAMP

		UPDATE [Partner].[Partner]
			   SET [PartnerTypeID]			= @PartnerTypeID
				  ,[PersonTitleTypeID]		= @PersonTitleTypeID
				  ,[CompanyTypeID]			= @CompanyTypeID
				  ,[Name]					= @Name
				  ,[Alias]					= @Alias
				  /*,[Address1]				= @Address1
				  ,[Address2]				= @Address2
				  ,[City]					= @City
				  ,[StateCode]				= @StateCode
				  ,[ZipCode]				= @ZipCode
				  ,[Email]					= @Email
				  ,[PhoneNumber]			= @PhoneNumber
				  ,[FaxNumber]				= @FaxNumber*/
				  ,[Gender]					= @Gender
				  ,[OwnershipPercent]		= @OwnershipPercent
				  ,[IsActive]				= @isActive   
				  ,[UpdatedDateTime]		= @DateTimeStamp
				  ,[UpdatedBy]				= @userName
				  ,[Note]					= @note
			 WHERE PartnerID = @PartnerID
 

		UPDATE [Map].[CustomerPartner]
		   SET [PartnerID]		= @PartnerID
			  ,[CustomerID]		= @customerID
			  ,[Description]	= @Name
			  ,[IsActive]		= @isActive   
			  ,[UpdatedDateTime]= @DateTimeStamp
			  ,[UpdatedBy]		= @userName
			  ,[Note]			= @note
		 WHERE PartnerID = @PartnerID 
		 AND CustomerID = @customerID
 



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
