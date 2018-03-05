SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian>
-- Create date: <06/26/2017>
-- Description:	<delete contact to person table>
-- =============================================
CREATE PROCEDURE [Contact].[uspDeleteContactPerson]
	
	@personID int,
	@CustomerID int,
	@phoneID int 

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
  
  DELETE FROM [Map].[PersonPhoneMap]  
		WHERE PhoneID = @phoneID 

	DELETE FROM [Customer].[Phone]  
		WHERE PhoneID = @phoneID 
	

	DELETE FROM [Customer].[Customer]  
		WHERE PersonID = @personID 


	DELETE FROM [Customer].[Person]  
		WHERE PersonID = @personID 
 
		
			 
  
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
