SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Definition].[uspGetPhoneTypeIDByKeyWord]
	
	@keyword varchar(20),
	@phoneTypeID int out
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN		

		SET @phoneTypeID = (SELECT [PhoneTypeID]
									  FROM [Definition].[PhoneType]
									  WHERE @keyword LIKE Name)

		COMMIT	
		RETURN @phoneTypeID
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
