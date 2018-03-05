SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Organization].[uspInsertForOrganizationBranchAddress]
	
	@CustomerID bigint,
	@OrganizationBranchID bigint,
	@AddressTypeID int, 
	@StateID int,
	@CountryID int,
	@UserName varchar(45),
	@Address1 varchar(100),
	@AddressTypeName varchar(45) = null,  -- 5-18-2017 peter
	@StateCode varchar(2) = null, -- 5-18-2017 peter
	@City varchar(50),
	@Zipcode varchar(10), 	
	@Address2 varchar (100)	= NULL,	
	@ZipExtension varchar(5) = NULL, 
	@IsPrimary bit = NULL,
	@Note [Note] = NULL	, 
	@ReferenceID int = null, 	-- added on 5-16-17 peter
	@isCrmImported bit = NULL -- 6-7-2017 peter
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN		
			
			if @AddressTypeName IS NOT NULL 
				BEGIN
					SET  @AddressTypeID = ( SELECT AddressTypeID FROM [Definition].[AddressType]  where name = @AddressTypeName )
				END	
			if @StateCode IS NOT NULL 
				BEGIN
					SET  @StateID = ( SELECT StateID FROM [Definition].[State]  where code = @StateCode )
				END	
			

			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP
			BEGIN
				DECLARE	@return_value int,@AddressID int

				EXEC	@return_value = [Common].[uspInsertAddress]
						@AddressTypeID = @AddressTypeID,
						@StateID = @StateID,
						@CountryID = @CountryID,
						@UserName = @UserName,
						@Address1 = @Address1,
						@City = @City,
						@Zipcode = @Zipcode,
						@Address2 = @Address2,
						@ZipExtension = @ZipExtension,
						@Note = @Note,
						@ReferenceID = @ReferenceID,	-- added on 5-16-17 peter
						@AddressID = @AddressID OUTPUT ,
						@isCrmImported	= @isCrmImported

					--	set @return_value = (SELECT	@AddressID)-- as N'@AddressID'

					--	SELECT	'Return Value' = @return_value
				
				

				IF(@IsPrimary is not Null AND @IsPrimary = 1 )
				BEGIN
					UPDATE [Map].[OrganizationBranchAddress]
					   SET 
						   [IsPrimary] = 0
						  ,[UpdatedDateTime] = @UpdateDateTime
						  ,[UpdatedBy] = @UserName
						  ,[Note] = @Note
					 WHERE [OrganizationBranchID] = @OrganizationBranchID
				END

				IF( @AddressID is not NULL)
					BEGIN
						INSERT INTO [Map].[OrganizationBranchAddress]
							   ([OrganizationBranchID]
							   ,[AddressID]
							   ,[IsPrimary]
							   ,[CreatedDateTime]
							   ,[CreatedBy]
							   ,[UpdatedDateTime]
							   ,[UpdatedBy]
							   ,[Note])
						 VALUES
							   (@OrganizationBranchID
							   ,@AddressID
							   ,IsNull(@IsPrimary,0)
							   ,@UpdateDateTime
							   ,@UserName
							   ,@UpdateDateTime
							   ,@UserName
							   ,@Note)
			
						execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note
				
						DECLARE @OrganizationBranchAddressID int = scope_identity()

						
						SELECT ad.*, oba.IsPrimary, st.Code, st.Name StateName, adt.Name AddressTypeName
						FROM [Customer].[Address]  ad 
						INNER JOIN [Map].[OrganizationBranchAddress] oba on ad.AddressID = oba.AddressID
						INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
						INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
						WHERE oba.OrganizationBranchAddressID = @OrganizationBranchAddressID
					END	
				ELSE
					BEGIN
						DECLARE @Msg3 varchar(100) = 'Code:50000 Unknow AddressID, Unable to locate AddressID for OrganizationBranchID ' + @OrganizationBranchID
						RAISERROR (@Msg3, -- Message text.  
												16, -- Severity.  
												1 -- State.  
												);  
					END
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
