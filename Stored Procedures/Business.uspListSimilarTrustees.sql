SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <09/01/2017>
-- Description:	<List similar trustees by given keyword. used in type ahead>
-- =============================================
CREATE PROCEDURE [Business].[uspListSimilarTrustees] 
	@cid int,
	@keyword varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	SELECT t.TrusteeID, t.TrusteeTypeID, t.FirstName, t.LastName, t.PersonTitleTypeID, t.CompanyName, t.CompanyAlias, t.Email, t.Note, t.UpdatedDateTime, p.PhoneID, p.PhoneTypeID, p.Number, p.NumberExt
		FROM [Business].[Trustee] t
		LEFT JOIN [Customer].[Phone] p ON p.PhoneID = (SELECT tpm.PhoneID FROM [Map].[TrusteePhoneMap] tpm WHERE t.TrusteeID = tpm.TrusteeID)
		WHERE ( t.FirstName LIKE (@keyword + '%') OR
			    t.LastName LIKE (@keyword + '%') OR 
			    t.CompanyName LIKE (@keyword + '%') OR
				t.CompanyAlias LIKE (@keyword + '%') 
			  ) AND
			  @cid = (SELECT TOP(1) prod.CustomerID FROM [Business].[Product] prod WHERE prod.ProductID IN (SELECT ptm.ProductID FROM [Map].[ProductTrusteeMap] ptm WHERE t.TrusteeID IN (ptm.TrusteeID) ) );


END





GO
