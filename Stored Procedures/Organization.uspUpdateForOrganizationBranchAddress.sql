SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Organization].[uspUpdateForOrganizationBranchAddress]
	@AddressID int,
	@CustomerID bigint,
	@OrganizationBranchID bigint,
	@AddressTypeID int, 
	@ReferenceID int = null, -- represents crm address id - 5-16-17 peter 
	@StateID int,
	@CountryID int,
	@UserName varchar(45),
	@AddressTypeName varchar(45) = null,  -- 5-18-2017 peter
	@StateCode varchar(2) = null, -- 5-18-2017 peter
	@Address1 varchar(100),
	@City varchar(50),
	@Zipcode varchar(10), 	
	@Address2 varchar (100)	= NULL,	
	@ZipExtension varchar(5) = NULL, 
	@IsPrimary bit = NULL,
	@Note [Note] = NULL	,	
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

			execute [Common].[uspUpdateAddress] 
				@AddressID = @AddressID,	
				@AddressTypeID = @AddressTypeID, 
				@StateID = @StateID,
				@CountryID = @CountryID, 
				@UserName= @UserName, 
				@Address1 = @Address1, 
				@City = @City, 
				@Zipcode = @Zipcode, 
				@Address2 = @Address2 ,
				@ZipExtension = @ZipExtension ,
				@Note = @Note,
				@ReferenceID = @ReferenceID, -- added on 5-16-17 peter 
				@isCrmImported = @isCrmImported -- 6-7-2017 peter
				 	

				UPDATE [Map].[OrganizationBranchAddress]
				SET 
					 [IsPrimary]		= IsNull(@IsPrimary, IsPrimary)
					,[UpdatedDateTime]	= @UpdateDateTime
					,[UpdatedBy]		= @UserName
					,[Note]				= @Note
				WHERE [AddressID] = @AddressID AND [OrganizationBranchID] = @OrganizationBranchID
			
				execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note
							
				SELECT ad.*, oba.IsPrimary, st.Code, st.Name StateName, adt.Name AddressTypeName
				FROM [Customer].[Address]  ad 
				INNER JOIN [Map].[OrganizationBranchAddress] oba on ad.AddressID = oba.AddressID
				INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
				INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
				WHERE ad.AddressID = @addressID	and oba.[OrganizationBranchID] = @OrganizationBranchID			
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
