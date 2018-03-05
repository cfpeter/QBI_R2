SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Shirak Avakian
-- Create date: <09/08/2016>
-- Description:	<List all CRM customers in QBI Suite database where CRMContactID is not null>
-- =============================================
CREATE PROCEDURE [Customer].[uspListMyCRMCustomers] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  		SELECT 
			  c.[CustomerID]
			  ,c.[CRMContactID]
			  ,st.StatusID
			  ,sg.StatusGroupID
			  ,sgm.StatusGroupMapID
			  ,ct.CustomerTypeID 
			  ,p.PersonID 			  
			  ,p.FirstName
			  ,p.LastName
			  ,p.DateOfBirth
			  ,p.Gender
			  ,ptt.Name PersonTitleName		  
			  ,ct.Name CustomerTypeName
			  ,st.Name StatusName
			  ,sg.Name StatusGroupName
			  ,c.CreatedBy
			  ,c.UpdatedBy
			  ,c.UpdatedDateTime
			  ,c.CreatedDateTime
		  FROM [Customer].[Customer] c 
		  INNER JOIN [Map].[StatusGroupMap] sgm ON c.StatusGroupMapID = sgm.StatusGroupMapID
		  INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
		  INNER JOIN [Definition].[StatusGroup] sg ON sgm.StatusGroupID = sg.StatusGroupID
		  LEFT JOIN [Definition].[CustomerType] ct ON c.CustomerTypeID = ct.CustomerTypeID
		  LEFT JOIN [Customer].[Person] p ON c.PersonID = p.PersonID
		  LEFT JOIN [Definition].[PersonTitleType] ptt ON p.PersonTitleTypeID = ptt.PersonTitleTypeID
		 WHERE (CRMContactID is not null or CRMContactID <> '')
		 AND ct.Name = 'CRM Customer'
		 AND c.CreatedDateTime > DATEADD(year,-2,GETDATE())
		 AND c.IsActive = 1
		
		 Order by c.UpdatedDateTime DESC

END





GO
