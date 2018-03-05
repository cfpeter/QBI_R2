SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <12/8/2017>
-- Description:	<Get Consultant by consultant's name>
-- =============================================
CREATE PROCEDURE [Employee].[uspGetConsultantByName] 
	@FirstName varchar(50),
	@LastName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	BEGIN TRY
		BEGIN TRAN
			
			SELECT * FROM [Customer].[Person] WHERE FirstName = @FirstName AND LastName = @LastName;
				
		COMMIT
	
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
