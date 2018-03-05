SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<get billing config data to populate on render>
-- =============================================
CREATE PROCEDURE [Accounting].[uspgetBillingConfigByProductID]
	@ProductID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT c.*, p.NumberOfParticipant AS DeferredParticipants, p.NumberOfNonDeferredParticipants AS NonDeferredParticipants , pt.ProductTypeID ,  pt.name as planName
 		FROM [Map].[ProductBillingConfigMap] m
		INNER JOIN [Accounting].[BillingConfig] c ON m.BillingConfigID = c.BillingConfigID
		INNER JOIN [Business].[Product] p ON m.ProductID = p.ProductID
		INNER JOIN [Map].[ProductTypeMap] ptm on p.ProductTypeMapID = ptm.ProductTypeMapID
		INNER JOIN [Definition].[ProductType] pt on ptm.ProductTypeID = pt.ProductTypeID
		WHERE m.ProductID = @ProductID;
END





GO
