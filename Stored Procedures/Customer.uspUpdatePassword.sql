SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <11/15/2016>
-- Description:	update the email]
-- =============================================
CREATE PROCEDURE [Customer].[uspUpdatePassword]  
	 @customerID int,
	 @newPassword varchar(250),
	 @salt varchar(250)
AS
BEGIN
 
SET NOCOUNT ON;
	
		DECLARE @userName varchar(50) = (
		SELECT userName from [Customer].[Login] where customerID = @customerID
		)

UPDATE [Customer].[Login]
   SET 
      
      [PassCode] = @newPassword
      ,[Salt] = @salt
      ,[IsActive] = 1
	  ,[LoginAttempts] = 0
      ,[UpdatedDateTime] =  CURRENT_TIMESTAMP
      ,[UpdatedBy] = @userName
      ,[Note] = 'password updated'
 WHERE CustomerID = @customerID

END










GO
