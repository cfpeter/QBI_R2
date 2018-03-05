SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<get trustees by product ID>
-- =============================================
CREATE PROCEDURE [Business].[uspGetTrusteesByProductID]
	@ProductID [bigint]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT t.TrusteeID, t.TrusteeTypeID, t.FirstName, t.LastName, t.PersonTitleTypeID, t.CompanyName, t.CompanyAlias, t.Email, t.Note, t.UpdatedDateTime,t.UpdatedBy, p.PhoneID, p.PhoneTypeID, p.Number, p.NumberExt
 		FROM [Map].[ProductTrusteeMap] m
		INNER JOIN [Business].[Trustee] t ON m.TrusteeID = t.TrusteeID
		LEFT JOIN [Customer].[Phone] p ON p.PhoneID = (SELECT tpm.PhoneID FROM [Map].[TrusteePhoneMap] tpm WHERE tpm.TrusteeID = t.TrusteeID)
		WHERE m.ProductID = @ProductID;
END




GO
