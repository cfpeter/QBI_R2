SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <03/10/2016>
-- Description:	<List all time prospects no filter>
-- =============================================
CREATE PROCEDURE [Customer].[uspListAllProspects] 
@Year varchar(4) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF( @Year is null OR @Year = '')
	BEGIN
		SELECT cust.CustomerID
				,ent.EntityID
				,ent.EntityTypeID
				,ent.ProductOriginID
				,sgm.StatusGroupMapID
				,stu.StatusID
				,stu.Name StatusName
				,ent.ProductTypeMapID
				,ct.CustomerTypeID
				,pst.ProductSubTypeID
				,ptm.ProductTypeMapID
				,pst.Name ProductSubTypeName
				,isNull(csm.Supervisor_PersonID,0) Supervisor_PersonID
				,isNull(csm.Supervisor_CustomerID,0) Supervisor_CustomerID
				,ct.Name CustomerTypeName
				--,pst.Name ProductSubTypeName
				,entt.Name EntityTypeName
				,po.Name ProductOriginName
				,ent.CallerName
				,ent.CallerEmail
				,ent.CallerPhone
				,ent.[Description] Notes
				,ent.InvestmentVendorIDs
				,ent.Location
				,ent.LocationZipcode
				,ent.Name EntityLegalName
				,isNull(ent.Participants,0) Participants
				,cust.UpdatedBy
				,cust.UpdatedDateTime
				,cust.CreatedBy
				,cust.CreatedDateTime
				,m.Memo

		FROM [Customer].[Entity] ent 
		INNER JOIN [Customer].[Customer] cust ON ent.EntityID = cust.EntityID
		INNER JOIN [Definition].[CustomerType] ct ON cust.CustomerTypeID = ct.CustomerTypeID
		INNER JOIN [Map].[StatusGroupMap] sgm ON cust.StatusGroupMapID = sgm.StatusGroupMapID
		INNER JOIN [Definition].[Status] stu ON sgm.StatusID = stu.StatusID
		INNER JOIN [Map].[ProductTypeMap] ptm ON ptm.ProductTypeMapID = ent.ProductTypeMapID
		INNER JOIN [Definition].[ProductSubType] pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID
		INNER JOIN [Definition].[ProductOrigin] po ON ent.ProductOriginID = po.ProductOriginID
		LEFT JOIN [Definition].[EntityType] entt ON ent.EntityTypeID = entt.EntityTypeID
		LEFT JOIN [Map].[CustomerSupervisorMap] csm ON cust.CustomerID = csm.CustomerID

		 LEFT JOIN (
		SELECT EntityID, max(CreatedDateTime) as MaxRowDate
		FROM [Map].[EntityMemoMap]
		GROUP BY EntityID
		) bm ON bm.EntityID = ent.EntityID
		LEFT JOIN [Map].[EntityMemoMap] emm ON bm.EntityID = emm.EntityID
		and bm.MaxRowDate = emm.CreatedDateTime
		LEFT join [Business].[Memo] m ON emm.MemoID = m.MemoID

		Order by cust.UpdatedDateTime DESC
	END
	ELSE
	BEGIN
		SELECT cust.CustomerID
				,ent.EntityID
				,ent.EntityTypeID
				,ent.ProductOriginID
				,sgm.StatusGroupMapID
				,stu.StatusID
				,stu.Name StatusName
				,pst.ProductSubTypeID
				,ptm.ProductTypeMapID
				,pst.Name ProductSubTypeName
				,ct.CustomerTypeID
				,isNull(csm.Supervisor_PersonID,0) Supervisor_PersonID
				,isNull(csm.Supervisor_CustomerID,0) Supervisor_CustomerID
				,ct.Name CustomerTypeName
				--,pst.Name ProductSubTypeName
				,entt.Name EntityTypeName
				,po.Name ProductOriginName
				,ent.CallerName
				,ent.CallerEmail
				,ent.CallerPhone
				,ent.[Description]
				,ent.InvestmentVendorIDs
				,ent.Location
				,ent.LocationZipcode
				,ent.Name EntityLegalName
				,ent.Participants
				,cust.UpdatedBy
				,cust.UpdatedDateTime
				,cust.CreatedBy
				,cust.CreatedDateTime
				,m.Memo

		FROM [Customer].[Entity] ent 
		INNER JOIN [Customer].[Customer] cust ON ent.EntityID = cust.EntityID
		INNER JOIN [Definition].[CustomerType] ct ON cust.CustomerTypeID = ct.CustomerTypeID
		INNER JOIN [Map].[StatusGroupMap] sgm ON cust.StatusGroupMapID = sgm.StatusGroupMapID
		INNER JOIN [Definition].[Status] stu ON sgm.StatusID = stu.StatusID
		INNER JOIN [Map].[ProductTypeMap] ptm ON ptm.ProductTypeMapID = ent.ProductTypeMapID 
		INNER JOIN [Definition].[ProductSubType] pst ON ptm.ProductSubTypeID = pst.ProductSubTypeID
		INNER JOIN [Definition].[ProductOrigin] po ON ent.ProductOriginID = po.ProductOriginID
		LEFT JOIN [Definition].[EntityType] entt ON ent.EntityTypeID = entt.EntityTypeID
		LEFT JOIN [Map].[CustomerSupervisorMap] csm ON cust.CustomerID = csm.CustomerID
		
		LEFT JOIN (
		SELECT EntityID, max(CreatedDateTime) as MaxRowDate
		FROM [Map].[EntityMemoMap]
		GROUP BY EntityID
	) bm ON bm.EntityID = ent.EntityID
	LEFT JOIN [Map].[EntityMemoMap] emm ON bm.EntityID = emm.EntityID
		and bm.MaxRowDate = emm.CreatedDateTime
	LEFT join [Business].[Memo] m ON emm.MemoID = m.MemoID

		Where YEAR(cust.UpdatedDateTime)  between @Year and Year(GetDate())
		Order by cust.UpdatedDateTime DESC
	END

END


 


GO
