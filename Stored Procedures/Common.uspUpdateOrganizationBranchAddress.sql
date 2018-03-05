SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Common].[uspUpdateOrganizationBranchAddress]
	@UserName varchar(45),
	@ClientID varchar(10)= NULL	,
	@CustomerID int	= NULL,
	@Address1 varchar(100) = NULL,
	@Address2 varchar (100)	= NULL,
	@City varchar(50) = NULL,
	@Zipcode varchar(10) = NULL, 
	@ZipExtension varchar(5) = NULL, 
	--address type
	@AddressTypeName varchar(50)= NULL, 
	@AddressTypeID int = NULL, 
	--state
	@StateCode varchar(2) = NULL,
	@StateID int = NULL,
	--country
	--@CountryName varchar(50)= NULL	,
	@CountryID int = NULL,
	@IsPrimary bit = NULL,
	@Note [Note]				
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			DECLARE @UpdateDateTime datetime		=  CURRENT_TIMESTAMP
			
			IF @ClientID IS NOT NULL AND @CustomerID IS NULL
			BEGIN 
				SET @CustomerID = ( SELECT customerID from [Customer].[Customer] WHERE CRMClientID = @ClientID and MainClient = 1 AND IsActive = 1 )
			END
			ELSE
			BEGIN
				SET @ClientID = ( SELECT crmClientID from [Customer].[Customer] WHERE CustomerID = @CustomerID and MainClient = 1 AND IsActive = 1 )
			END

			IF( @AddressTypeName IS NOT NULL AND @AddressTypeID is NULL )
				BEGIN
					SET	@AddressTypeID = ( SELECT AddressTypeID from [Definition].[AddressType] where Name = @AddressTypeName )
				END
			
			/*if @CountryName IS NOT NULL
				BEGIN
					SET		@CountryID				= ( SELECT CountryID FROM [Definition].[Country] WHERE Name = @CountryName )
				END*/
			
			IF( @StateCode IS NOT NULL AND @StateID IS NULL )
				BEGIN
					SET	@StateID = ( SELECT StateID FROM [Definition].[State] WHERE Code = @StateCode )
				END
			
			PRINT '@CustomerID'
			PRINT @CustomerID
			IF( @CustomerID IS NOT NULL )
				BEGIN
			
					DECLARE @personID	bigint	= ( SELECT PersonID from [Customer].[Customer] where customerID = @CustomerID )

					PRINT '@personID'
					PRINT @personID
					IF( @personID IS NOT NULL )
						BEGIN
							DECLARE @OrganizationBranchID bigint = ( SELECT OrganizationBranchID FROM [Customer].[Person] WHERE PersonID = @personID )

							PRINT '@OrganizationBranchID'
							PRINT @OrganizationBranchID
							IF( @OrganizationBranchID IS NULL )
								BEGIN
									DECLARE @Msg varchar(200) = 'Code:50000 Organization not found to update, either client does not have active customer or no organization defined for client ' + isNull(@ClientID,'')
									RAISERROR (@Msg, -- Message text.  
														16, -- Severity.  
														1 -- State.  
														);  
								END
						END
					
					PRINT '@AddressTypeID'
					PRINT @AddressTypeID
					IF( @AddressTypeID IS NOT NULL )
						BEGIN
							DECLARE	@addressID	int	= ( SELECT oba.AddressID from [Customer].[Customer] c
																INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
																INNER JOIN [Customer].[OrganizationBranch] ob on p.OrganizationBranchID = ob.OrganizationBranchID
																INNER JOIN [Map].[OrganizationBranchAddress] oba on ob.OrganizationBranchID = oba.OrganizationBranchID
																INNER JOIN [Customer].[Address] ca on oba.AddressID = ca.AddressID
															WHERE c.CustomerID = @CustomerID AND ca.AddressTypeID = @AddressTypeID )
							IF( @addressID IS NULL )
								BEGIN
									DECLARE @Msg0 varchar(200) = 'Code:50000 Address not found to update, either client does not have active address or the type is not known for client ' + isNull(@ClientID,'')
									RAISERROR (@Msg0, -- Message text.  
														16, -- Severity.  
														1 -- State.  
														);  
								END
						END
					ELSE
						BEGIN
							DECLARE @Msg1 varchar(100) = 'Code:50000 Unknow Address Type, Unable to locate organization address Type for Client ' + isNull(@ClientID,'')
							RAISERROR (@Msg1, -- Message text.  
												16, -- Severity.  
												1 -- State.  
												);  
						END
					
					PRINT '@addressID'
					PRINT @addressID
					IF ( @addressID IS NOT NULL )
						BEGIN

							UPDATE [Customer].[Address]
							   SET 
								   [AddressTypeID]	= IsNull(@AddressTypeID,[AddressTypeID])
								  ,[CountryID]		= IsNull(@CountryID,[CountryID])
								  ,[Address1]		= IsNull(@Address1,[Address1])
								  ,[Address2]		= IsNull(@Address2,[Address2])
								  ,[City]			= IsNull(@City,[City])
								  ,[StateID]		= IsNull(@StateID,[StateID])
								  ,[Zipcode]		= IsNull(@Zipcode,[Zipcode])
								  ,[ZipcodeExt]		= IsNull(@ZipExtension,[ZipcodeExt])
								  ,[UpdatedDateTime]= @UpdateDateTime
								  ,[UpdatedBy]		= @UserName
								  ,[Note]			= @Note
			 
							 WHERE AddressID		= @addressID

							 PRINT '@IsPrimary'
							PRINT @IsPrimary

							UPDATE [Map].[OrganizationBranchAddress]
							SET 
								 [IsPrimary]		= IsNull(@IsPrimary, IsPrimary)
								,[UpdatedDateTime]	= @UpdateDateTime
								,[UpdatedBy]		= @UserName
								,[Note]				= @Note
							WHERE [OrganizationBranchID] = @OrganizationBranchID AND [AddressID] = @AddressID
			
							execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note
							
							SELECT ad.*, oba.IsPrimary
							FROM [Customer].[Address]  ad 
							INNER JOIN [Map].[OrganizationBranchAddress] oba on ad.AddressID = oba.AddressID
							WHERE ad.AddressID = @addressID

						END
					ELSE
						BEGIN
							DECLARE @Msg2 varchar(150) = 'Code:50000 Unknow Address, Unable to locate organization address for Client ' + isNull(@ClientID,'')

							PRINT '@Msg2'
					PRINT @Msg2

							RAISERROR (@Msg2, -- Message text.  
												16, -- Severity.  
												1 -- State.  
												);  
						END
				END
			ELSE
				BEGIN
					DECLARE @Msg3 varchar(150) = 'Code:50000 Unknow Client, Unable to locate CustomerID for Client ' + isNull(@ClientID,'')
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
