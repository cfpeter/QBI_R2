SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <11/06/2017>
-- Description:	<Set the main Client Manager by CustomerID>
-- =============================================
CREATE PROCEDURE [Customer].[uspSetClientManagerToMainByCustomerID]
	@CustomerID bigint,
	@CompanyID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @OldMain bigint = (SELECT cust.CustomerID	  
			FROM [Customer].[Customer] cust 
			INNER JOIN [Map].[ThirdPartyProviderMap] tppm ON tppm.CustomerID = cust.CustomerID
				WHERE  tppm.CompanyID = @CompanyID
				AND cust.IsActive = 1
				AND cust.IsPrimary = 1
				AND cust.MainClient = 1);

	UPDATE [Customer].[Customer] SET MainClient = 0
		WHERE CustomerID = @OldMain;
	
	UPDATE [Customer].[Customer] SET MainClient = 1
		WHERE CustomerID = @CustomerID;

	UPDATE [Business].[Product] SET CustomerID = @CustomerID
		WHERE CustomerID = @OldMain;

	UPDATE [Customer].[Customer] SET MainCustomerID = @CustomerID
		WHERE MainCustomerID = @OldMain;

	SELECT @CustomerID CustomerID;
	
END






GO
