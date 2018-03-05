SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Definition].[uspGetAddressTypeIDByKeyWord]
	
	@keyword varchar(20),
	@addressTypeID int out
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN		

		SET @addressTypeID = (SELECT [AddressTypeID]
									  FROM [Definition].[AddressType]
									  WHERE @keyword LIKE Name)

		COMMIT	
		RETURN @addressTypeID
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
