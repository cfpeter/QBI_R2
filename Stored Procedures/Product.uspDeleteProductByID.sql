SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian>
-- Create date: <08/23/2017>
-- Description:	<delte product >
-- =============================================
CREATE PROCEDURE [Product].[uspDeleteProductByID]
	@ProductID bigint
AS
BEGIN
	 
	 DELETE FROM [Map].[ProductBillingConfigMap]
		WHERE ProductID = @ProductID

	 DELETE FROM [Map].[ProductTrusteeMap]
		WHERE ProductID = @ProductID

	DELETE FROM [Map].[ProductAdvisorMap]
		WHERE ProductID = @ProductID

	 DELETE FROM [Map].[ProductWorkflow]
		WHERE ProductID = @ProductID

	 DELETE from [Business].[Product] 
		WHERE ProductID = @ProductID

		
END


GO
