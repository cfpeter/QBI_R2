SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <2/6/2018>
-- Description:	update the mainClient (boolean) and the mainCustomerID]
-- =============================================
CREATE PROCEDURE [Customer].[uspUpdateMainCustomer]  

	 @customerID int,
	 @userName varchar(50)
AS
BEGIN
 
	
	DECLARE @companyID int			= ( SELECT companyID FROM [Map].[ThirdPartyProviderMap] WHERE CustomerID = @customerID ); -- added by Hamlet 2/5/18 along with mainClient & mainCustomerID; moved here from insertClient
	DECLARE @mainCustomerID bigint	= @customerID;
	DECLARE @customerCount int		= (SELECT count(tppm.customerID) from [Map].[ThirdPartyProviderMap] tppm
										INNER JOIN [Customer].[Login] l ON l.CustomerID = tppm.CustomerID
										WHERE tppm.companyID = @companyID
										AND	len(l.LastLoginDateTime) > 0)
	IF (@customerCount > 0)
		BEGIN
			SET @mainCustomerID = (SELECT c.CustomerID FROM [Customer].[Customer] c
										INNER JOIN [Map].[ThirdPartyProviderMap] tppm ON tppm.CustomerID = c.CustomerID
										WHERE tppm.CompanyID = @companyID
										AND c.MainClient = 1 )
			UPDATE [Customer].[Customer]
			   SET 
				   [MainClient] = 0
				  ,[MainCustomerID] = @mainCustomerID
				  ,[UpdatedDateTime] =  CURRENT_TIMESTAMP
				  ,[UpdatedBy] = @userName

			 WHERE CustomerID = @customerID
		END
	ELSE IF (@customerCount = 0)
		BEGIN
			-- update the customer signing up to be the main client
			UPDATE [Customer].[Customer]
			   SET 
				   [MainClient] = 1
				  ,[MainCustomerID] = @mainCustomerID
				  ,[UpdatedDateTime] =  CURRENT_TIMESTAMP
				  ,[UpdatedBy] = @userName

			 WHERE CustomerID = @customerID

			 -- update the customers in the company of the customer signing up to NOT be the main client, and have customer signin up as main
			 UPDATE [Customer].[Customer]
			   SET 
				   [MainClient] = 0
				  ,[MainCustomerID] = @mainCustomerID
				  ,[UpdatedDateTime] =  CURRENT_TIMESTAMP
				  ,[UpdatedBy] = @userName

			 WHERE CustomerID IN ( SELECT customerID FROM [Map].[ThirdPartyProviderMap] WHERE CompanyID = ( SELECT CompanyID FROM [Map].[ThirdPartyProviderMap] WHERE CustomerID = @customerID) )
			 AND MainClient != 1
		END

	


	 SELECT * FROM [Customer].[Customer] WHERE CustomerID = @customerID;
 

END
GO
