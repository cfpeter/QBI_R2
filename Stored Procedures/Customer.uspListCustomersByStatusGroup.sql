SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian	>
-- Create date: <02/29/2016>
-- Description:	<List customer by given Status group>
-- =============================================
CREATE PROCEDURE [Customer].[uspListCustomersByStatusGroup] 
	@StatusGroupName varchar(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Select c.CustomerID
	  ,c.CustomerTypeID
	  ,c.EntityID
	  ,ent.EntityTypeID
	  ,c.PersonID
	  ,c.IsActive
	  ,c.StatusGroupMapID
	  ,st.StatusID
	  ,stg.StatusGroupID
	  ,st.Name StatusName
	  ,stg.Name StatusGroupName
	  ,ct.Name CustomerType
	  ,per.FirstName
	  ,per.LastName
	  ,per.DateOfBirth
	  ,per.Gender
	  ,ent.CallerEmail
	  ,ent.CallerName
	  ,ent.CallerPhone
	  ,ent.Name EntityName

	 From Customer.Customer c
		INNER JOIN [Map].StatusGroupMap sgm ON c.StatusGroupMapID = sgm.StatusGroupMapID
		INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
		INNER JOIN [Definition].StatusGroup stg ON sgm.StatusGroupID = stg.StatusGroupID
		INNER JOIN [Definition].[CustomerType] ct ON c.CustomerTypeID = ct.CustomerTypeID
		LEFT JOIN [Customer].[Person] per ON c.PersonID = per.PersonID
		LEFT JOIN [Customer].[Entity] ent ON c.EntityID = ent.EntityID


	Where stg.Name = @StatusGroupName
	Order by c.UpdatedDateTime DESC
END








GO
