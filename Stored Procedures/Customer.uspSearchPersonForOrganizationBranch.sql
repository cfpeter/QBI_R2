SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Customer].[uspSearchPersonForOrganizationBranch]
@Name varchar(150),
@firstname varchar(50),
@lastName varchar(50),
@email varchar(50)
	 
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN   
				 
				 SELECT	customerID
						,org.OrganizationID 
						,orgb.OrganizationBranchID 
						,orgb.Name
						,p.FirstName
						,p.LastName 
						,p.Email
		
					FROM [Customer].[Customer] c
						INNER JOIN [Customer].[Person] p ON c.PersonID = p.PersonID
						INNER JOIN [Customer].[OrganizationBranch] orgb ON p.OrganizationBranchID = orgb.OrganizationBranchID
						INNER JOIN [Customer].[Organization] org ON orgb.OrganizationID = org.OrganizationID  
						WHERE orgb.Name like '%' + @Name + '%'
						AND ( p.Email = @email OR ( p.FirstName like '%' + @firstname + '%' AND p.LastName like '%'+ @lastName + '%' ) )
				 
			
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
