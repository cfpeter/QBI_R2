SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <02/10/2016>
-- Description:	<get organization branch addresses>
-- =============================================
CREATE PROCEDURE [Organization].[uspListOrganizationBranchAddresses] 
	@OrganizationBranchID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT oba.OrganizationBranchID
		  ,ad.AddressID
		  ,ad.AddressTypeID
		  ,oba.OrganizationBranchAddressID
		  ,adt.Name AddressTypeName
		  ,isNull(oba.IsPrimary,0) IsPrimaryAddress
		  ,ad.Address1
		  ,ad.Address2
		  ,ad.City
		  ,ad.CountryID
		  ,ad.isCRMImported
		  ,isNull(ad.StateID,0) StateID
		  ,st.Code StateCode
		  ,ad.Zipcode

	  FROM  [MAP].[OrganizationBranchAddress] oba 
	  LEFT JOIN [Customer].[Address] ad ON oba.AddressID = ad.AddressID
	  LEFT JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
	  LEFT JOIN [Definition].[State] st ON ad.StateID = st.StateID

	  WHERE oba.OrganizationBranchID = @OrganizationBranchID
	 
END


GO
