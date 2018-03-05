SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <09/27/2016>
-- Description:	<get organization branch addresses>
-- =============================================
CREATE PROCEDURE [Business].[uspGetOrganizationAddress] 
	@OrganizationBranchID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT org.OrganizationID
		  ,ob.OrganizationBranchID
		  ,ad.AddressID
		  ,ad.AddressTypeID
		  ,oba.OrganizationBranchAddressID
		  ,adt.Name AddressTypeName
		  ,isNull(oba.IsPrimary,0) IsPrimaryAddress
		  ,ad.Address1
		  ,ad.Address2
		  ,ad.City
		  ,ad.CountryID
		  ,isNull(ad.StateID,0) StateID
		  ,st.Code StateCode
		  ,ad.Zipcode
		  ,ad.isCRMImported

	  FROM  [Customer].[OrganizationBranch] ob 
	  INNER JOIN [Customer].[Organization] org ON ob.OrganizationID = org.OrganizationID
	 
	  LEFT JOIN [Definition].[OrganizationType] orgT ON org.OrganizationTypeID = orgT.OrganizationTypeID
	  LEFT JOIN [MAP].[OrganizationBranchAddress] oba ON ob.OrganizationBranchID = oba.OrganizationBranchID
	  LEFT JOIN [Customer].[Address] ad ON oba.AddressID = ad.AddressID
	  LEFT JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
	  LEFT JOIN [Definition].[State] st ON ad.StateID = st.StateID

	  WHERE ob.OrganizationBranchID = @OrganizationBranchID
	 
END




GO
