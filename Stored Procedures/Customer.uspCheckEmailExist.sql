SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <11/14/2016>
-- Description:	check wheather email exist [build for reset password but can use to other things too]
-- =============================================
CREATE PROCEDURE [Customer].[uspCheckEmailExist]  
	 @email varchar(50)
AS
BEGIN
 
SET NOCOUNT ON;

	SELECT p.Email , c.CustomerID, p.FirstName , p.LastName
	FROM 
		[map].[LoginMap] lm
		
		INNER JOIN [Customer].[Login] l on lm.LoginID = l.LoginID
		INNER JOIN [Customer].[Customer] c on c.CustomerID = l.CustomerID
		INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID

	where  p.email = @email
	and c.IsActive = 1
	AND lm.IsActive = 1

END








GO
