SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <4/17/2017>
-- Description:	<get address information by addressID>
-- =============================================
CREATE PROCEDURE [Common].[uspGetAddressByID]
	@AddressID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ad.*, oba.IsPrimary, st.Code, st.Name StateName, adt.Name AddressTypeName
	FROM [Customer].[Address]  ad 
	INNER JOIN [Map].[OrganizationBranchAddress] oba on ad.AddressID = oba.AddressID
	INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
	INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
	WHERE ad.AddressID = @addressID	
END


GO
