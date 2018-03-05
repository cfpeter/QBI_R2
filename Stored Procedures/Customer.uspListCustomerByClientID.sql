SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspListCustomerByClientID]
@theID int,
@flag int

AS
BEGIN
	


	IF ( @flag = '0' )
	BEGIN
		SELECT 
		
		 c.CustomerID
		,c.CRMClientID 
		,c.CRMContactID 
		,c.isPrimary 
		,c.CustomerTypeID
		,c.IsActive
		,c.isActivationEmailSent
		,p.PersonID
		,p.FirstName
		,p.LastName
		,p.DateOfBirth
		,p.Email
		,p.OrganizationBranchID

	FROM [customer].[Customer] c 
	INNER JOIN [Customer].[Person] p ON c.PersonID = p.PersonID

		WHERE c.CRMClientID = @theID
	END
	else if(@flag = '1')
	begin
		SELECT 
		
		 c.CustomerID
		,c.CRMClientID 
		,c.CRMContactID 
		,c.isPrimary 
		,c.CustomerTypeID
		,c.IsActive
		,c.isActivationEmailSent
		,p.PersonID
		,p.FirstName
		,p.LastName
		,p.DateOfBirth
		,p.Email
		,p.OrganizationBranchID

	FROM [customer].[Customer] c 
	INNER JOIN [Customer].[Person] p ON c.PersonID = p.PersonID
	
	WHERE c.CustomerID  = @theID 
	end
	 
END










GO
