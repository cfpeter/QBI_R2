SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter Garabedian>
-- Create date: <04/3/2017>
-- Description:	<Update Customer status by given customerID and Status group map ID>
-- =============================================
CREATE PROCEDURE [Customer].[uspUpdateCustomerStatusAndTypeByCustomerID] 
	@CustomerID int,
	@StatusGroupMapID int,
	@CustomerTypeName varchar(50),
	@userName varchar(45)
	
	
AS
BEGIN  
	DECLARE @customerTypeID int = ( SELECT CustomerTypeID from [Definition].[CustomerType] where Name = @CustomerTypeName )  
	DECLARE @Note varchar(100) = 'status updated when converting from prospect to customer'
	SET NOCOUNT ON;

   UPDATE [Customer].[Customer]

	   SET
		   [StatusGroupMapID]	= @StatusGroupMapID
		  ,[CustomerTypeID]		= @customerTypeID
		  ,[UpdatedDateTime]	= CURRENT_TIMESTAMP
		  ,[UpdatedBy]			= @UserName
		  ,[Note]				= @Note
	 WHERE CustomerID = @CustomerID

END


GO
