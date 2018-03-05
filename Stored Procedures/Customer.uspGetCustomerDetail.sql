SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <03/29/2016>
-- Description:	<Get customer by given customer ID>
-- =============================================
CREATE PROCEDURE [Customer].[uspGetCustomerDetail] 
	-- Add the parameters for the stored procedure here
	 @CustomerID int
AS
BEGIN
--declare @list varchar(20)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
    SELECT  cust.CustomerID
	  ,cust.[CustomerTypeID]
	  ,ent.EntityID
	  ,ent.EntityTypeID
	  ,po.ProductOriginID
	  ,ent.ProductTypeMapID ProductTypeMapID
	  ,isNull(csm.Supervisor_PersonID,0) Supervisor_PersonID
	  ,isNull(csm.Supervisor_CustomerID,0) Supervisor_CustomerID
	  ,cust.IsActive
	  ,cust.SalesPersonID -- branch listSalesPerson added by peter 6/15/16
	  ,p.FirstName + ' ' + p.LastName As salesPersonName	-- branch listSalesPerson added by peter 6/16/16
	  ,custt.Name CustomerTypeName  
	  ,cust.CreatedDateTime
	  ,cust.UpdatedDateTime
	  ,cust.CreatedBy
	  ,cust.UpdatedBy
      ,ent.Name EntityLegalName  
	  ,ent.CallerName
	  ,ent.CallerPhone 
	  ,ent.CallerEmail 
	  ,ent.[Description] Notes
	  ,ent.FollowUp 
--	  ,ent.SalesPerson  --branch listSalesPerson commented by peter 6/15/16
	  ,ent.Assets
	  ,ent.Favorite 
	  ,ent.Location 
	  ,ent.Rollover
	  ,ent.ProductID
	  ,ent.InvestmentVendorIDs
--	  ,iv.Name investmentVendorName 
	  ,isNull(ent.Participants,0) Participants
	  ,ent.FollowUpDate
	  ,ent.UpdatedDateTime entityUpdatedDateTime
	  ,m.Memo
	  ,po.Name productOriginName
	  ,sgm.StatusGroupMapID
	  ,s.Name StatusName
	  ,pst.Name ProductSubTypeName
	  ,cust.MainClient

	 FROM [Customer].[Customer] cust 
	 LEFT JOIN [Customer].[Person] p on cust.SalesPersonID = p.PersonID -- branch listSalesPerson added by peter 6/15/16
	 INNER JOIN [Definition].CustomerType custt ON cust.CustomerTypeID = custt.CustomerTypeID
	 INNER JOIN [map].[StatusGroupMap] sgm on cust.StatusGroupMapID = sgm.StatusGroupMapID
	 INNER JOIN [Definition].[Status] s on sgm.StatusID = s.StatusID
	 LEFT JOIN [Customer].[Entity] ent ON cust.EntityID = ent.EntityID
	 LEFT JOIN [Definition].[ProductOrigin] po on ent.ProductOriginID = po.ProductOriginID
	 LEFT JOIN [Map].ProductTypeMap ptm ON ent.ProductTypeMapID = ptm.ProductTypeMapID
	 LEFT JOIN [Definition].[ProductSubType] pst on ptm.ProductSubTypeID = pst.ProductSubTypeID
	 LEFT JOIN [Map].[CustomerSupervisorMap] csm ON cust.CustomerID = csm.CustomerID
--   LEFT JOIN [Definition].[InvestmentVendor] iv on ent.InvestmentVendorID = iv.InvestmentVendorID
	LEFT JOIN (
		SELECT EntityID, max(CreatedDateTime) as MaxRowDate
		FROM [Map].[EntityMemoMap]
		GROUP BY EntityID
	) bm ON bm.EntityID = ent.EntityID
	LEFT JOIN [Map].[EntityMemoMap] emm ON bm.EntityID = emm.EntityID
		and bm.MaxRowDate = emm.CreatedDateTime
	LEFT join [Business].[Memo] m ON emm.MemoID = m.MemoID
	
	 

	WHERE cust.CustomerID = @CustomerID
	--AND cust.IsActive = 1
END













GO
