SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <11/15/2016>
-- Description:	update the email]
-- =============================================
CREATE PROCEDURE [Customer].[uspUpdateUserNameAndPassword]  

	 @customerID int,
	 @userName varchar(50),
	 @newPassword varchar(250),
	 @salt varchar(250)
AS
BEGIN
 
	DECLARE @loginID int = ( SELECT loginID from [Customer].[Login] where customerID = @customerID )
	 
	DECLARE @statusID int 				= ( SELECT statusID FROM [definition].[Status] WHERE Name = 'Active' )
	DECLARE @statusGroupID int			= ( SELECT statusGroupID FROM [definition].[StatusGroup] WHERE Name = 'Customer' )
	DECLARE @statusGroupMapID int		= ( SELECT statusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusID = @statusID AND StatusGroupID = @statusGroupID )



	UPDATE [Customer].[Customer]
	   SET  
		   [StatusGroupMapID] = @statusGroupMapID
		  ,[UpdatedDateTime] =  CURRENT_TIMESTAMP
		  ,[UpdatedBy] = @userName
		  ,[Note] = 'password updated'
	 WHERE CustomerID = @customerID

	UPDATE [Customer].[Login]
	   SET 
		   [UserName] = @userName
		  ,[PassCode] = @newPassword
		  ,[Salt] = @salt
		  ,[IsActive] = 1
		  ,[LoginAttempts] = 0
		  ,[UpdatedDateTime] =  CURRENT_TIMESTAMP
		  ,[UpdatedBy] = @userName
		  ,[Note] = 'password updated'
	 WHERE CustomerID = @customerID


	 UPDATE [Map].[LoginMap]
	   SET  
		   [IsActive] = 1 
		  ,[UpdatedDateTime] =  CURRENT_TIMESTAMP
		  ,[UpdatedBy] = @userName
		  ,[Note] = 'password updated'

	 WHERE LoginID = @loginID


	 SELECT * from Customer.Customer where CustomerID = @customerID
 

END














GO
