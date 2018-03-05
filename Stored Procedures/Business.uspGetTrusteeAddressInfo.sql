SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet>
-- Create date: <9/15/2017>
-- Description:	<get address information for trustee>
-- =============================================
CREATE PROCEDURE [Business].[uspGetTrusteeAddressInfo]
	@trusteeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ad.*, st.Code StateCode, st.Name StateName, adt.Name AddressTypeName, tam.IsPrimary IsPrimaryAddress
	FROM [Customer].[Address]  ad 
	INNER JOIN [Map].[TrusteeAddressMap] tam ON tam.AddressID = ad.AddressID
	INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
	INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
	WHERE ad.AddressID IN (SELECT AddressID FROM [Map].[TrusteeAddressMap] WHERE TrusteeID = @trusteeID)	
END




GO
