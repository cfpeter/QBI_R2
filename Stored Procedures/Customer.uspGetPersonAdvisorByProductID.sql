SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Customer].[uspGetPersonAdvisorByProductID]
	 @ProductID bigint 
	
AS 
BEGIN
	BEGIN TRY
		 	
			
		    SELECT	pam.AdvisorCustomerID,
				c.AdvisorTypeID,
				ad.Name advisorTypeName,
				p.PersonID , p.FirstName,p.LastName,p.Email,p.UpdatedBy, p.UpdatedDateTime,
				ph.Number,ph.PhoneID,ph.PhoneTypeID , ph.NumberExt
			FROM [Map].[ProductAdvisorMap] pam
				INNER JOIN [Customer].[Customer] c on pam.AdvisorCustomerID = c.CustomerID
				INNER JOIN [Customer].[Person] p  on c.PersonID = p.PersonID
				INNER JOIN [Business].[Product] pr on pam.ProductID = pr.ProductID
				LEFT JOIN [Map].[PersonPhoneMap] ppm on p.PersonID = ppm.PersonID
				LEFT JOIN [Customer].[Phone] ph on ppm.PhoneID = ph.PhoneID 
				INNER JOIN [Definition].[AdvisorType] ad on c.AdvisorTypeID = ad.AdvisorTypeID
			WHERE pam.ProductID = @ProductID

		 
	
	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			EXEC dbo.uspRethrowError
		END
	END CATCH
END


GO
