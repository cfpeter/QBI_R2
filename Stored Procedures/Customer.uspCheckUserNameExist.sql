SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <05/16/2016>
-- Description:	<when adding a login , this storedProc will return all matching name to the user  to see whether this login name is exist or no >
-- =============================================
CREATE PROCEDURE [Customer].[uspCheckUserNameExist] 
	-- Add the parameters for the stored procedure here
	 @userName varchar(50),
	 @loginIsActiveFlag varchar(50)
AS
BEGIN
 
SET NOCOUNT ON;
	
	if( @loginIsActiveFlag = 'true' )
		BEGIN
			SELECT UserName , p.Email ,c.CustomerID , p.FirstName, p.LastName
				FROM 
					[Map].[LoginMap] lm
						INNER JOIN [Customer].[Login] l on lm.LoginID = l.LoginID
						INNER JOIN [Customer].[Customer] c on c.CustomerID = l.CustomerID
						INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
				where  userName Like( @userName ) 
				AND l.IsActive = 1
		END
	else
		BEGIN
			SELECT UserName , p.Email ,c.CustomerID , p.FirstName, p.LastName
				FROM 
					[Map].[LoginMap] lm
						INNER JOIN [Customer].[Login] l on lm.LoginID = l.LoginID
						INNER JOIN [Customer].[Customer] c on c.CustomerID = l.CustomerID
						INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
				where  userName Like( @userName ) 
		END
	

END











GO
