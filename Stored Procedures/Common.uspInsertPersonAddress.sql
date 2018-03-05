SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Common].[uspInsertPersonAddress]
	
	@PersonID bigint,
	@AddressID bigint = NULL, 
	@AddressTypeID int, 
	@StateID int,
	@CountryID int,
	@UserName varchar(45),
	@Address1 varchar(100),
	@AddressTypeName varchar(45) = NULL, 
	@StateCode varchar(2) = NULL, 
	@City varchar(50),
	@Zipcode varchar(10), 	
	@Address2 varchar (100)	= NULL,	
	@ZipcodeExt varchar(5) = NULL, 
	@IsPrimary bit = 0,
	@Note [Note] = NULL	, 
	@ReferenceID int = NULL
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN

			EXECUTE @AddressID = [Common].[uspInsertAddress] 
			   @AddressTypeID
			  ,@StateID
			  ,@CountryID
			  ,@UserName
			  ,@Address1
			  ,@City
			  ,@Zipcode
			  ,@Address2
			  ,@ZipcodeExt
			  ,@Note
			  ,@ReferenceID
			  ,@AddressID OUTPUT


			IF (SELECT COUNT(PersonID) FROM [Map].[PersonAddress] WHERE PersonID = @PersonID) = 0 
			BEGIN
				SET @IsPrimary = 1;
			END
					

			INSERT INTO [Map].[PersonAddress]
					([PersonID]
					,[AddressID]
					,[IsPrimary]
					,[CreatedDateTime]
					,[CreatedBy]
					,[UpdatedDateTime]
					,[UpdatedBy]
					)
				VALUES
					(@PersonID
					,@AddressID
					,@IsPrimary
					,CURRENT_TIMESTAMP
					,@UserName
					,CURRENT_TIMESTAMP
					,@UserName
					)
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
