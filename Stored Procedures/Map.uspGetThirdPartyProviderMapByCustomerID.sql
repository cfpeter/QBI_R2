SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian>
-- Create date: <10/18/2017>
-- Description:	< get  third party provider map by customer id>
-- =============================================
CREATE PROC [Map].[uspGetThirdPartyProviderMapByCustomerID] 
	
		 @CustomerID	bigint    
AS 
BEGIN
	BEGIN TRY  
		SELECT [ThirdPartyProviderMapID]
		  ,[CustomerID]
		  ,[OneLoginUserID]
		  ,[OneLoginAppID]
		  ,[ExternalID]
		  ,[CompanyID]
		  ,[AccountID]
		  ,[ThirdPartyProviderID]
		  ,[OneLoginProductID] -- added by Hamlet 12/21/17
		  ,[APISent]
		  ,[Description]
		  ,[CreatedBy]
		  ,[CreatedDateTime]
		  ,[UpdatedBy]
		  ,[UpdatedDateTime]
		  ,[Note]
	  FROM [Map].[ThirdPartyProviderMap]

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
