SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian>
-- Create date: <10/16/2017>
-- Description:	< get customer info bu customerID, this could expanded to get more info about the customer>
-- =============================================
CREATE PROC [Customer].[uspGetCustomerInfoByID] 
	
	  @CustomerID	bigint 

	

AS 
BEGIN
	BEGIN TRY 

 

		SELECT [LoginID]
			  ,[CustomerID]
			  ,[UserName]
			  ,[PassCode]
			  ,[Salt]
			  ,[LastLoginDateTime]
			  ,[IsActive]
			  ,[CreatedDateTime]
			  ,[CreatedBy]
			  ,[UpdatedDateTime]
			  ,[UpdatedBy]
			  ,[Note]
			  ,[LoginAttempts]
		  FROM [Customer].[Login] 

 		 WHERE CustomerID = @CustomerID

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
