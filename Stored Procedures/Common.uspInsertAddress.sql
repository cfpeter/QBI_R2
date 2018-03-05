SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Common].[uspInsertAddress]
	
	@AddressTypeID int, 
	@StateID int,
	@CountryID int,
	@UserName varchar(45),
	@Address1 varchar(100),
	@City varchar(50),
	@Zipcode varchar(10), 
	@Address2 varchar (100)	= NULL,	
	@ZipExtension varchar(5) = NULL, 
	@Note [Note] = NULL,
	@ReferenceID int = null, -- added on 5-16-17 peter
	@AddressID int out	,
	@isCrmImported bit = NULL -- 6-7-2017 peter
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN			
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP
			BEGIN
				INSERT INTO [Customer].[Address]
				   ([AddressTypeID]
				   ,[DirectionTypeID]
				   ,[StreetTypeID]
				   ,[CountryID]
				   ,[ReferenceID] -- added on 5-16-17 peter
				   ,[Address1]
				   ,[Address2]
				   ,[City]
				   ,[StateID]
				   ,[Zipcode]
				   ,[ZipcodeExt]
				   ,[CreatedDateTime]
				   ,[CreatedBy]
				   ,[UpdatedDateTime]
				   ,[UpdatedBy]
				   ,[Note]
				   ,[isCRMImported])
			 VALUES
				   (@AddressTypeID
				   ,null
				   ,null
				   ,@CountryID
				   ,@ReferenceID -- added on 5-16-17 peter
				   ,@Address1
				   ,@Address2
				   ,@City
				   ,@StateID
				   ,@Zipcode
				   ,@ZipExtension
				   ,@UpdateDateTime
				   ,@UserName
				   ,@UpdateDateTime
				   ,@UserName
				   ,@Note
				   ,@isCrmImported)
			 
			 SET @AddressID = scope_identity()
				
			 				
			END

		COMMIT	
		RETURN	@AddressID
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
