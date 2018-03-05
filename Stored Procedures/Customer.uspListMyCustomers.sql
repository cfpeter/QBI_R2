SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <02/02/2016>
-- Description:	<List customers for givin supervisor>
-- =============================================
CREATE PROCEDURE [Customer].[uspListMyCustomers]
	-- Add the parameters for the stored procedure here
	@Supervisor_PersonID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
		SELECT csm.[CustomerSupervisorMapID]
			  ,csm.Supervisor_PersonID
			  ,csm.Supervisor_CustomerID
			  ,c.[CustomerID]
			  ,ent.[EntityID]
			  ,st.StatusID
			  ,sg.StatusGroupID
			  ,sgm.StatusGroupMapID
			  ,ct.CustomerTypeID 
			  ,p.PersonID
			  ,csm.[IsActive]
			  ,sup.FirstName SupervisorFirstName
  			  ,sup.LastName SupervisorLastName			  
			  ,p.FirstName
			  ,p.LastName
			  ,p.DateOfBirth
			  ,p.Gender
			  ,ptt.Name PersonTitleName		  
			  ,ct.Name CustomerTypeName
			  ,ent.Name EntityName
			  ,ent.CallerName CallerName
			  ,ent.Rollover -- Added by Shirak 09/29/2016 R1V1.C1
			  ,st.Name StatusName
			  ,sg.Name StatusGroupName
			  ,c.CreatedBy
			  ,c.UpdatedBy
			  ,c.UpdatedDateTime
			  ,c.CreatedDateTime
		  FROM [Map].[CustomerSupervisorMap] csm
		  INNER JOIN [Customer].[Person] sup ON csm.Supervisor_PersonID = sup.PersonID
		  INNER JOIN [Customer].[Customer] c ON csm.CustomerID = c.CustomerID
		  INNER JOIN [Map].[StatusGroupMap] sgm ON c.StatusGroupMapID = sgm.StatusGroupMapID
		  INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
		  INNER JOIN [Definition].[StatusGroup] sg ON sgm.StatusGroupID = sg.StatusGroupID
		  LEFT JOIN [Definition].[CustomerType] ct ON c.CustomerTypeID = ct.CustomerTypeID
		  LEFT JOIN [Customer].Entity ent ON c.EntityID = ent.EntityID
		  LEFT JOIN [Customer].[Person] p ON c.PersonID = p.PersonID
		  LEFT JOIN [Definition].[PersonTitleType] ptt ON p.PersonTitleTypeID = ptt.PersonTitleTypeID
		 WHERE csm.Supervisor_PersonID = @Supervisor_PersonID
		 AND ct.Name = 'External'
		 AND c.CreatedDateTime > DATEADD(year,-2,GETDATE())
		 AND c.IsActive = 1
		 Order by c.UpdatedDateTime DESC

		 SELECT csm.[CustomerSupervisorMapID]
			  ,csm.Supervisor_PersonID
			  ,csm.Supervisor_CustomerID
			  ,c.[CustomerID]
			  ,ent.[EntityID]
			  ,st.StatusID
			  ,sg.StatusGroupID
			  ,sgm.StatusGroupMapID
			  ,ct.CustomerTypeID 
			  ,p.PersonID
			  ,csm.[IsActive]
			  ,sup.FirstName SupervisorFirstName
  			  ,sup.LastName SupervisorLastName			  
			  ,p.FirstName
			  ,p.LastName
			  ,p.DateOfBirth
			  ,p.Gender
			  ,ptt.Name PersonTitleName			  
			  ,ct.Name CustomerTypeName
			  ,ent.Name EntityName
			  ,ent.CallerName CallerName
			  ,ent.Rollover -- Added by Shirak 09/29/2016 R1V1.C1
			  ,st.Name StatusName
			  ,sg.Name StatusGroupName
			  ,c.CreatedBy
			  ,c.UpdatedBy
			  ,c.UpdatedDateTime
			  ,c.CreatedDateTime
		  FROM [Map].[CustomerSupervisorMap] csm
		  INNER JOIN [Customer].[Person] sup ON csm.Supervisor_PersonID = sup.PersonID
		  INNER JOIN [Customer].[Customer] c ON csm.CustomerID = c.CustomerID
		  INNER JOIN [Map].[StatusGroupMap] sgm ON c.StatusGroupMapID = sgm.StatusGroupMapID
		  INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
		  INNER JOIN [Definition].[StatusGroup] sg ON sgm.StatusGroupID = sg.StatusGroupID
		  LEFT JOIN [Definition].[CustomerType] ct ON c.CustomerTypeID = ct.CustomerTypeID
		  LEFT JOIN [Customer].Entity ent ON c.EntityID = ent.EntityID
		  LEFT JOIN [Customer].[Person] p ON c.PersonID = p.PersonID
		  LEFT JOIN [Definition].[PersonTitleType] ptt ON p.PersonTitleTypeID = ptt.PersonTitleTypeID
		 WHERE csm.Supervisor_PersonID = @Supervisor_PersonID
		AND ct.Name = 'Internal'
		AND c.IsActive = 1
		Order by c.UpdatedDateTime DESC

		SELECT csm.[CustomerSupervisorMapID]
			  ,csm.Supervisor_PersonID
			  ,csm.Supervisor_CustomerID
			  ,c.[CustomerID]
			  ,ent.[EntityID]
			  ,st.StatusID
			  ,sg.StatusGroupID
			  ,sgm.StatusGroupMapID
			  ,ct.CustomerTypeID 
			  ,p.PersonID
			  ,ent.ProductTypeMapID
			  ,csm.[IsActive]
			  ,sup.FirstName SupervisorFirstName
  			  ,sup.LastName SupervisorLastName			  
			  ,p.FirstName
			  ,p.LastName
			  ,p.DateOfBirth
			  ,p.Gender
			  ,ptt.Name PersonTitleName			  
			  ,ct.Name CustomerTypeName
			  ,ent.Name EntityName
			  ,ent.CallerName CallerName
			  ,ent.Rollover -- Added by Shirak 09/29/2016 R1V1.C1
			  ,st.Name StatusName
			  ,sg.Name StatusGroupName
			  ,c.CreatedBy
			  ,c.UpdatedBy
			  ,c.UpdatedDateTime
			  ,c.CreatedDateTime
		  FROM [Map].[CustomerSupervisorMap] csm
		  INNER JOIN [Customer].[Person] sup ON csm.Supervisor_PersonID = sup.PersonID
		  INNER JOIN [Customer].[Customer] c ON csm.CustomerID = c.CustomerID
		  INNER JOIN [Map].[StatusGroupMap] sgm ON c.StatusGroupMapID = sgm.StatusGroupMapID
		  INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
		  INNER JOIN [Definition].[StatusGroup] sg ON sgm.StatusGroupID = sg.StatusGroupID
		  LEFT JOIN [Definition].[CustomerType] ct ON c.CustomerTypeID = ct.CustomerTypeID
		  LEFT JOIN [Customer].Entity ent ON c.EntityID = ent.EntityID
		  LEFT JOIN [Customer].[Person] p ON c.PersonID = p.PersonID
		  LEFT JOIN [Definition].[PersonTitleType] ptt ON p.PersonTitleTypeID = ptt.PersonTitleTypeID
		 WHERE ct.Name = 'Prospect'
		 AND c.CreatedDateTime > DATEADD(year,-2,GETDATE())
		 AND c.IsActive = 1
		 Order by c.UpdatedDateTime DESC
END






GO
