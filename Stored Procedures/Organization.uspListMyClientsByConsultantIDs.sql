SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <03/14/2017>
-- Description:	<List client information by given list of consultant IDs>
-- =============================================
CREATE PROCEDURE [Organization].[uspListMyClientsByConsultantIDs] 
	@ConsultantIDs varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT 
		  Distinct (c.[CustomerID])
		  ,MAX(c.UpdatedDateTime) UpdatedDateTime
		  ,c.[CRMContactID]	
		  ,ct.Name customerTypeName	  
		  ,p.FirstName
		  ,p.LastName
		  ,p.FirstName + ' ' + p.LastName ContactFullName
		  ,orgb.Name FullName
		  ,bp.ConsultantPersonID
		  
		  FROM [Customer].[Customer] c 	
		  INNER JOIN [Definition].[CustomerType] ct ON c.CustomerTypeID = ct.CustomerTypeID
		  INNER JOIN [Customer].[Person] p ON c.PersonID = p.PersonID
		  INNER JOIN [Customer].[OrganizationBranch] orgb ON p.OrganizationBranchID = orgb.OrganizationBranchID
		  INNER JOIN [Customer].[Organization] org ON orgb.OrganizationID = org.OrganizationID
		  INNER JOIN [Business].[Product] bp ON c.CustomerID = bp.CustomerID
		  
		 WHERE (c.CRMContactID is not null or c.CRMContactID <> '')
		 AND ct.Name = 'CRM Customer'
		 AND c.CreatedDateTime > DATEADD(year,-2,GETDATE())
		 AND c.IsActive = 1
		 AND c.IsPrimary = 1
		 AND c.MainClient = 1
		 AND ConsultantPersonID IN (SELECT number FROM intlist_to_tbl( @ConsultantIDs) )
		-- AND bp.ConsultantPersonID = @ConsultantPersonID
		 GROUP BY c.[CustomerID] ,c.UpdatedDateTime
		  ,c.[CRMContactID]	
		  ,ct.Name 	  
		  ,p.FirstName
		  ,p.LastName
		  ,p.FirstName + ' ' + p.LastName 
		  ,orgb.Name 
		  ,bp.ConsultantPersonID
		 Order by Max(c.UpdatedDateTime) DESC, c.[CustomerID]
END


GO
