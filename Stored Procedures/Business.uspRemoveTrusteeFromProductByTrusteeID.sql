SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Business].[uspRemoveTrusteeFromProductByTrusteeID]
	  @TrusteeID bigint, 
	  @ProductID bigint
	
AS 
BEGIN
	BEGIN TRY
	
		DELETE FROM [Map].[ProductTrusteeMap]
			WHERE TrusteeID = @TrusteeID AND ProductID = @ProductID


		/*DECLARE @addressID TABLE(
			id int not null
		)

		INSERT INTO @addressID
			SELECT addressID FROM[Customer].[Address] WHERE addressID in ( SELECT addressID FROM [Map].[TrusteeAddressMap] WHERE TrusteeID = @TrusteeID )
		
		DELETE FROM [Map].[TrusteeAddressMap] 
			WHERE TrusteeID = @TrusteeID

		DELETE from [Customer].[Address] 
			WHERE addressID in ( SELECT * FROM @addressID ) 


		DECLARE @phoneID TABLE(
			id int not null
		)

		INSERT INTO @phoneID
			SELECT phoneID FROM[Customer].[Phone] WHERE phoneID in ( SELECT phoneID FROM [Map].[TrusteePhoneMap] WHERE TrusteeID = @TrusteeID )

		DELETE FROM [Map].[TrusteePhoneMap] 
			WHERE TrusteeID = @TrusteeID
		
		DELETE from [Customer].[Phone] 
			WHERE phoneID in ( SELECT * FROM @phoneID ) 


		DELETE FROM [Business].[Trustee]
			WHERE TrusteeID = @TrusteeID*/


	
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
