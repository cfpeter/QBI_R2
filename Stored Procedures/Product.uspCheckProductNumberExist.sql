SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <9/5/2017>
-- Description:	< checking if a plan number exist before inserting >
-- =============================================
CREATE PROC [Product].[uspCheckProductNumberExist]
	  @CustomerID bigint 
	 ,@productNumber int 
	
AS 
BEGIN
	BEGIN TRY
		
		SELECT Number FROM [business].[Product]
		 WHERE customerID = @CustomerID 
		 AND number = @productNumber
		 AND number <> '000'
	 
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
