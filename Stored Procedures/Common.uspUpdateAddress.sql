SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Common].[uspUpdateAddress]
	@AddressID int,
	@AddressTypeID int, 
	@StateID int,
	@CountryID int,
	@UserName varchar(45),
	@Address1 varchar(100),
	@City varchar(50),
	@Zipcode varchar(10), 
	@Address2 varchar (100)	= NULL,	
	@ZipExtension varchar(5) = NULL, 
	@Note [Note] = NULL	,
	@ReferenceID int = null	,
	@isCrmImported bit = NULL -- 6-7-2017 peter
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN			
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP
			BEGIN
				UPDATE [Customer].[Address]
					SET 
						 [AddressTypeID]	= IsNull(@AddressTypeID,[AddressTypeID])
						,[CountryID]		= IsNull(@CountryID,[CountryID])
						,[Address1]			= IsNull(@Address1,[Address1])
						,[Address2]			= @Address2
						,[ReferenceID]		= isNull (@ReferenceID, [ReferenceID])
						,[City]				= IsNull(@City,[City])
						,[StateID]			= IsNull(@StateID,[StateID])
						,[Zipcode]			= IsNull(@Zipcode,[Zipcode])
						,[ZipcodeExt]		= @ZipExtension
						,[UpdatedDateTime]	= @UpdateDateTime
						,[UpdatedBy]		= @UserName
						,[Note]				= @Note
						,[isCRMImported]	= @isCrmImported
			 
					WHERE AddressID		= @addressID
								
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
