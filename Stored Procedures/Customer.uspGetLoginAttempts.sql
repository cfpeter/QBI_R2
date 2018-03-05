SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian> 
-- =============================================
CREATE PROCEDURE [Customer].[uspGetLoginAttempts] 
	@userName varchar(45)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT CustomerID , username, LoginAttempts

	  FROM  [Customer].[Login]  

	  WHERE UserName = @userName
	 
END





GO
