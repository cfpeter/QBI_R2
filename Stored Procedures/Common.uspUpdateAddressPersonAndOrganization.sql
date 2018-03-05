SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Common].[uspUpdateAddressPersonAndOrganization]
	@addressID				bigint,
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
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP , @Msg3 varchar(100)
			
		 
				DECLARE	@return_value int

				EXEC	@return_value	= [Common].[uspUpdateAddress]		
						@addressID		= @addressID,
						@AddressTypeID	= @AddressTypeID,
						@StateID		= @StateID,
						@CountryID		= @CountryID,
						@UserName		= @UserName,
						@Address1		= @Address1,
						@City			= @City,
						@Zipcode		= @Zipcode,
						@Address2		= @Address2,
						@ZipExtension	= @ZipExtension,
						@Note			= @Note
 
				
			
				IF( @addressTypeMap = 'Organization' )
					BEGIN 
						if(@IsPrimary = 1)
							BEGIN
								exec [Organization].[uspUpdateOrganizationPrimaryAddress]
										@CustomerID				= @CustomerID,
										@AddressID				= @addressID,
										@OrganizationBranchID	= @OrganizationBranchID,
										@IsPrimary				= @IsPrimary,
										@UserName				= @UserName,
										@Note					= @Note				
							END
						ELSE
							BEGIN
								/*UPDATE [Map].[OrganizationBranchAddress]
								   SET
									   [IsPrimary]				= @IsPrimary
									  ,[UpdatedDateTime]		= @UpdateDateTime
									  ,[UpdatedBy]				= @UserName
									  ,[Note]					= @Note
								 WHERE addressID = @addressID 
								 AND OrganizationBranchAddressID = @OrganizationBranchID
								*/
								execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note  


								SELECT ad.*, oba.IsPrimary, st.Code, st.Name StateName, adt.Name AddressTypeName
								FROM [Customer].[Address]  ad 
									INNER JOIN [Map].[OrganizationBranchAddress] oba on ad.AddressID = oba.AddressID
									INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
									INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
								WHERE oba.OrganizationBranchAddressID = @OrganizationBranchID
								AND oba.AddressID = @addressID
							END

					END	
				else if (@addressTypeMap = 'Person')
					BEGIN
						DECLARE @PersonID bigint
						SET @PersonID = ( SELECT PersonID from [Customer].[Customer] WHERE CustomerID = @CustomerID )
					
						DECLARE @PrimaryAddressID bigint = ( select addressID from [Customer].[Address] WHERE addressID = ( select addressID from [Map].[PersonAddress] where PersonID = @PersonID and IsPrimary = 1 ) ) 
						 


						if(@IsPrimary = 1)
							BEGIN 
								exec [Customer].[uspUpdatePersonPrimaryAddress]
									@CustomerID				= @CustomerID,
									@AddressID				= @addressID,
									@IsPrimary				= @IsPrimary,
									@UserName				= @UserName,
									@Note					= @Note		


							END
						else
							BEGIN
								if(  @PrimaryAddressID = @addressID )
									BEGIN
										SET @Msg3   = 'Code:50000 One primary address is required'
											RAISERROR (@Msg3, -- Message text.  
												16, -- Severity.  
												1 -- State.  
												); 
									END
								else
									BEGIN
										UPDATE [Map].[PersonAddress]
											SET
												[IsPrimary]				= @IsPrimary
												,[UpdatedDateTime]		= @UpdateDateTime
												,[UpdatedBy]				= @UserName
												,[Note]					= @Note
											WHERE addressID = @addressID 
											AND PersonID = @PersonID
									END

							END

							execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note  

							SELECT ad.*, pa.IsPrimary, st.Code, st.Name StateName, adt.Name AddressTypeName
							FROM [Customer].[Address]  ad 
								INNER JOIN [Map].[PersonAddress] pa on ad.AddressID = pa.AddressID
								INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
								INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
							WHERE pa.PersonID = @PersonID AND pa.AddressID = @addressID
					
				END
				/*ELSE IF (@addressTypeMap = 'Trustee')
				BEGIN

				END*/
				ELSE
					BEGIN
						SET @Msg3   = 'Code:50000 Unable to identify the Address Type Map : ' + @addressTypeMap
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
