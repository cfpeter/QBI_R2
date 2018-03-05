SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspInsertEmail]
@contact_customerID int,
@loggedIn_customerID int,
@contact_email varchar(50),
@loggedIn_email varchar(50),
@makePrimaryEmail varchar(6)

AS 
BEGIN	
 
	BEGIN TRY 
	
	DECLARE @contact_personID int = ( SELECT personID FROM [Customer].[Customer]  WHERE CustomerID = @contact_customerID )
	DECLARE @contactPersonEmail varchar(50) = ( SELECT email FROM [Customer].[Person]  WHERE personID = @contact_personID )

	if( @contactPersonEmail is null )
		BEGIN

			UPDATE [Customer].[Person] 
				SET
				   [Email] = @contact_email
				WHERE PersonID = @contact_personID
		END	
		
		DECLARE @loggedin_personID int = ( SELECT personID FROM [Customer].[Customer]  WHERE CustomerID = @loggedIn_customerID )
		DECLARE @loggedin_PersonEmail varchar(50) = ( SELECT email FROM [Customer].[Person]  WHERE personID = @loggedin_personID )
		
		if( @loggedin_PersonEmail is null )
			BEGIN

				UPDATE [Customer].[Person] 
					SET
					   [Email] = @loggedIn_email
					WHERE PersonID = @loggedin_personID
			END	
		
		
		else if (@makePrimaryEmail IS NOT NULL AND @makePrimaryEmail = 'true')
			BEGIN
				UPDATE [Customer].[Person] 
					SET
					   [Email] = @loggedIn_email
					WHERE PersonID = @loggedin_personID
			END

	 END TRY
	 BEGIN CATCH
		if(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			exec dbo.uspRethrowError
		END
	 END CATCH
 				
END




GO
