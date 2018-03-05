SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Customer].[uspSearchForOrganizationByName] 
	  
@Name varchar(150)
	 
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN  
		 
			
			DECLARE @orgCount int = (
							SELECT  count(OrganizationBranchID)
							FROM  [Customer].[OrganizationBranch] 
							WHERE Name = @Name 
							)
			
			IF(@orgCount = 1) 
				BEGIN

					SELECT 
						 OrganizationBranchID  
						,Name  
						,'true' exactMatch
					FROM  [Customer].[OrganizationBranch] 
					WHERE Name = @Name 
				END
			ELSE
				BEGIN
					SELECT 
						 OrganizationBranchID  
						,Name  
						,'false' exactMatch
						
					FROM  [Customer].[OrganizationBranch] 
					WHERE Name LIKE '%' + @Name + '%'  
					OR @Name LIKE '%' + Name +'%'
			
				END
			
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
