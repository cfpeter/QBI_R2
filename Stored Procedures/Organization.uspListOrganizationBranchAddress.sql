SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <03/15/2017>
-- Description:	<list organization branch addresses by given branchID>
-- =============================================
CREATE PROCEDURE [Organization].[uspListOrganizationBranchAddress] 
	@OrganizationBranchID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT ob.OrganizationBranchID
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

	  FROM  [Customer].[OrganizationBranch] ob 
	  INNER JOIN [MAP].[OrganizationBranchAddress] oba ON ob.OrganizationBranchID = oba.OrganizationBranchID
	  INNER JOIN [Customer].[Address] ad ON oba.AddressID = ad.AddressID
	  INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
	  INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID

	  WHERE ob.OrganizationBranchID = @OrganizationBranchID
	 
END


GO
