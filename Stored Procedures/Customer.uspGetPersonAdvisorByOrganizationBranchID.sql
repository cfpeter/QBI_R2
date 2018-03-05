SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Customer].[uspGetPersonAdvisorByOrganizationBranchID]
	 @organizationBranchID int 
	
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN			
			
		 SELECT	c.AdvisorTypeID,
				ad.Name advisorTypeName,
				p.PersonID , p.FirstName,p.LastName,p.Email,p.UpdatedBy, p.UpdatedDateTime,
				ph.Number,ph.PhoneID,ph.PhoneTypeID 
		FROM [Customer].[Customer] c
			INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
			LEFT JOIN [Map].[PersonPhoneMap] ppm on p.PersonID = ppm.PersonID
			LEFT JOIN [Customer].[Phone] ph	ON ppm.PhoneID = ph.PhoneID

			INNER JOIN [Definition].[AdvisorType] ad on c.AdvisorTypeID = ad.AdvisorTypeID
		WHERE p.OrganizationBranchID = @organizationBranchID

		COMMIT	
	
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
