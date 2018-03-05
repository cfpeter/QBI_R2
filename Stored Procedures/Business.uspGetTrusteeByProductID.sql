SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<get trustee by product ID>
-- =============================================
CREATE PROCEDURE [Business].[uspGetTrusteeByProductID]
	@ProductID [bigint]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT t.*, p.*, a.*
 		FROM [Map].[ProductTrusteeMap] m
		INNER JOIN [Business].[Trustee] t ON m.TrusteeID = t.TrusteeID
		LEFT JOIN [Customer].[Phone] p ON p.PhoneID = (SELECT tpm.PhoneID FROM [Map].[TrusteePhoneMap] tpm WHERE tpm.TrusteeID = t.TrusteeID)
		LEFT JOIN [Customer].[Address] a ON a.AddressID = (SELECT tam.AddressID FROM [Map].[TrusteeAddressMap] tam WHERE tam.TrusteeID = t.TrusteeID)
		WHERE m.ProductID = @ProductID;
END




GO
