SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian> 
-- =============================================
CREATE PROCEDURE [Customer].[uspUpdateLoginAttempts] 
	 @userName varchar(45)
	,@loginAttempts int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [Customer].[Login]
		SET
			 [LoginAttempts]	= @loginAttempts
			,[UpdatedDateTime]	= CURRENT_TIMESTAMP
			,[Note]				= 'login attempt update'
		WHERE UserName		= @userName
		
	 
END





GO
