SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Common].[uspSaveAddress]
	
	@CustomerID				bigint,
	@OrganizationBranchID	bigint = null,
	--@PersonID				bigint = null,
	@AddressTypeID			int, 
	@StateID				int,
	@CountryID				int,
	@UserName				varchar(45),
	@Address1				varchar(100), 
	@City					varchar(50),
	@Zipcode				varchar(10), 	
	@Address2				varchar (100)	= NULL,	
	@ZipExtension			varchar(5) = NULL, 
	@IsPrimary				bit = NULL,
	@Note					[Note] = NULL	,  
	@addressTypeMap			varchar(50)
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN		 
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP
			
		 
				DECLARE	@return_value int, @AddressID int

				EXEC	@return_value	= [Common].[uspInsertAddress]
						@AddressTypeID	= @AddressTypeID,
						@StateID		= @StateID,
						@CountryID		= @CountryID,
						@UserName		= @UserName,
						@Address1		= @Address1,
						@City			= @City,
						@Zipcode		= @Zipcode,
						@Address2		= @Address2,
						@ZipExtension	= @ZipExtension,
						@Note			= @Note, 
						@AddressID		= @AddressID OUTPUT  
 
				
 

				IF( @addressTypeMap = 'Organization' )
					BEGIN
						DECLARE @out_OrganizationBranchAddressMap int
	
						EXEC @out_OrganizationBranchAddressMap = [Map].[uspInsertOrganizationBranchAddress]

							@OrganizationBranchID = @OrganizationBranchID
							,@AddressID			= @AddressID
							,@IsPrimary			= @IsPrimary
							,@UserName				= @UserName
							,@Note					= @Note
							,@out_OrganizationBranchAddressMap = @out_OrganizationBranchAddressMap output
						  
						execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note  


						SELECT ad.*, oba.IsPrimary, st.Code, st.Name StateName, adt.Name AddressTypeName
						FROM [Customer].[Address]  ad 
							INNER JOIN [Map].[OrganizationBranchAddress] oba on ad.AddressID = oba.AddressID
							INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
							INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
						WHERE oba.OrganizationBranchAddressID = @out_OrganizationBranchAddressMap
							 
					END	
				else if (@addressTypeMap = 'Person')
					BEGIN
						DECLARE @out_personAddressMap int , @PersonID bigint
						
						 

								SET @PersonID = ( SELECT PersonID from [Customer].[Customer] WHERE CustomerID = @CustomerID )

								EXEC @out_personAddressMap = [Map].[uspInsertPersonAddress]
								  @personID				= @PersonID
								 ,@AddressID			= @AddressID
								 ,@IsPrimary			= @IsPrimary
								 ,@UserName				= @UserName
								 ,@Note					= @Note
								 ,@out_personAddressMap = @out_personAddressMap output
						  
								execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note  

								SELECT ad.*, pa.IsPrimary, st.Code, st.Name StateName, adt.Name AddressTypeName
								FROM [Customer].[Address]  ad 
									INNER JOIN [Map].[PersonAddress] pa on ad.AddressID = pa.AddressID
									INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
									INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
								WHERE pa.PersonAddressID = @out_personAddressMap
						 

					END

				ELSE
					BEGIN
						DECLARE @Msg3 varchar(100) = 'Code:50000 Unable to identify the Address Type Map : ' + @addressTypeMap
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
