SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <02/22/2017>
-- Description:	<Get organization branch address>
-- =============================================
CREATE PROCEDURE [Organization].[uspGetOrganizationBranchAddress] 
	-- Add the parameters for the stored procedure here
	@addressID int,
	@OrganizationBranchID bigint
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
	WHERE ad.AddressID = @addressID	and [OrganizationBranchID] = @OrganizationBranchID
END







GO
