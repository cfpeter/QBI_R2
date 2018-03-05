SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Business].[uspListProductByCustomerID]
	 @customerID int
	

AS 
BEGIN
	BEGIN TRY
		
		--DECLARE @clientID int					= ( SELECT CRMClientID from [Customer].[Customer] where customerID = @customerID )
		--DECLARE @customerID_OfMainClient int	= ( SELECT customerID from [Customer].[Customer] where CRMClientID = @clientID and MainClient = 1 ) 

		--DECLARE @customerID int = (SELECT customerID FROM [Customer].[customer] WHERE CRMClientID = @clientID )
		--DECLARE @productTypeMapID int = (SELECT productTypeMapID FROM [Business].[Product] WHERE CustomerID = @customerID ) 
		
		SELECT 
				 
				
				c.CustomerID
				,p.ProductID
				,c.MainClient 
				,c.CRMClientID
				,ptm.ProductTypeMapID
				,p.customerID
				,p.ConsultantPersonID
				,p.Number
				,p.ProductYearEnd
				,p.Name ProductName
				,p.IsProspect
				,p.crmPlanID
				,tppm.OneLoginProductID -- added by Hamlet 12/19/17
				--productTypeMap
				,ptm.Name ProductTypeMapName
				,ptm.ProductTypeMapID
				--productSubType
				,pst.ProductSubTypeID 
				,pst.name ProductSubName 
				--productType
				,pt.ProductTypeID
				,pt.Name productType
				--person
				,per.FirstName ConsultantFirstName
				,per.LastName  ConsultantLastName
				,per.Email	   ConsultantEmail
				,cph.Number    ConsultantPhoneNumber
				--status
				,sgm.StatusGroupMapID
				,s.Name	StatusName
				,s.StatusID	

		FROM [Business].[Product] p

		INNER JOIN [Customer].[Customer] c on p.CustomerID = c.CustomerID
		LEFT JOIN [map].[ProductTypeMap] ptm on p.ProductTypeMapID = ptm.ProductTypeMapID
		LEFT JOIN [Definition].[ProductSubType] pst on ptm.ProductSubTypeID = pst.ProductSubTypeID
		LEFT JOIN [customer].[Person] per on p.ConsultantPersonID = per.PersonID 
		LEFT JOIN [Definition].[ProductType] pt on ptm.ProductTypeID = pt.ProductTypeID
		LEFT JOIN [Customer].[Phone] cph on per.PersonID = cph.PersonID
		LEFT JOIN [map].[StatusGroupMap] sgm on p.StatusGroupMapID = sgm.StatusGroupMapID
		LEFT JOIN [Definition].[Status] s on sgm.StatusID = s.StatusID
		LEFT JOIN [Map].[ThirdPartyProviderMap] tppm ON tppm.CustomerID = p.CustomerID
		
		WHERE p.CustomerID =  @customerID	
		AND (p.IsProspect is null OR p.IsProspect = 0)
	
	
	 END TRY
	 BEGIN CATCH
		if(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			exec dbo.uspRethrowError
		END
	 END CATCH
END

SELECT customerID FROM [Business].[Product]
GROUP BY customerID
GO
