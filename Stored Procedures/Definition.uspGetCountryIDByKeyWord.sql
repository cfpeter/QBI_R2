SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Definition].[uspGetCountryIDByKeyWord]
	
	@keyword varchar(20),
	@countryID int out
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN		
		
		SET @countryID = (SELECT [CountryID]
									  FROM [Definition].[Country]
									  WHERE @keyword LIKE Name
									  OR	@keyword LIKE Code)

		COMMIT	
		RETURN @countryID
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
