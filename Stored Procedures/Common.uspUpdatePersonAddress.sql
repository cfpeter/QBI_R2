SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Common].[uspUpdatePersonAddress]
	

	@CustomerID int					,
	@Address1 varchar(100)			,
	@Address2 varchar (100)			,
	@City varchar(50)				,
	@Zipcode varchar(10)			, 
	--address type
	@AddressTypeName varchar(50)= NULL	, 
	@AddressTypeID int		= NULL		, 
	--state
	@StateCode varchar(2)	= NULL	,
	@StateID int			= NULL	,
	--country
	--@CountryName varchar(50)= NULL	,
	@CountryID int				
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			DECLARE @UpdateDateTime datetime		=  CURRENT_TIMESTAMP
			DECLARE @updated_By		varchar(45)		= ( SELECT username from [Customer].[Login] where CustomerID = @CustomerID )
			DECLARE @Note			varchar(45)		= 'Address Updated'
			
			if @AddressTypeName IS NOT NULL
				BEGIN
					SET		@AddressTypeID			= ( SELECT AddressTypeID from [Definition].[AddressType] where Name = @AddressTypeName )
				END
			
			/*if @CountryName IS NOT NULL
				BEGIN
					SET		@CountryID				= ( SELECT CountryID FROM [Definition].[Country] WHERE Name = @CountryName )
				END*/
			
			if @StateCode IS NOT NULL
				BEGIN
					SET		@StateID				= ( SELECT StateID FROM [Definition].[State] WHERE Code = @StateCode )
				END

			DECLARE @personID	int					= ( SELECT PersonID from [Customer].[Customer] where customerID = @CustomerID )			

			DECLARE @addressID	int
			--Person Address
			SET @addressID							= ( SELECT pa.AddressID from [Customer].[Customer] c
															INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
															INNER JOIN [Map].[PersonAddress] pa on p.PersonID = pa.PersonID
														WHERE c.CustomerID = @CustomerID )
			
			
			DECLARE @customerTypeName varchar(45) = ( SELECT ct.Name from [Customer].[Customer] c
											INNER JOIN [Definition].[CustomerType] ct on c.CustomerTypeID = ct.CustomerTypeID 
											WHERE c.CustomerID = @CustomerID )

			if @customerTypeName <> 'Internal'
				BEGIN
					UPDATE [Customer].[Address]
					   SET 
						   [AddressTypeID]	= @AddressTypeID
						  ,[CountryID]		= @CountryID
						  ,[Address1]		= @Address1
						  ,[Address2]		= @Address2
						  ,[City]			= @City
						  ,[StateID]		= @StateID
						  ,[Zipcode]		= @Zipcode
						  ,[UpdatedDateTime]= @UpdateDateTime
						  ,[UpdatedBy]		= @updated_By
						  ,[Note]			= @Note
			 
					 WHERE AddressID		= @addressID

			
					 UPDATE [Customer].[Customer]
						SET  
							 [UpdatedDateTime]	= @UpdateDateTime
							,[UpdatedBy]		= @updated_By
							,[Note]				= @Note
			 
					 WHERE CustomerID = @CustomerID
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

---------------------------------------------------------------------------

/****** Object:  StoredProcedure [Customer].[uspUpdatePerson]    Script Date: 12/14/2016 2:15:12 PM ******/
SET ANSI_NULLS ON


GO
