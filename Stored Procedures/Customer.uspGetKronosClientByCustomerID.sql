SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Customer].[uspGetKronosClientByCustomerID] 
	
 @customerID bigint
	

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN 
			 
 
		/*SELECT [KronosQBIClientID]
			  ,[AccountID]
			  ,[CompanyID]
			  ,[EmployeeID]
			  ,[AccountStatus]
			  ,[CompanyName]
			  ,[CompanyShortName]
			  ,[CompanyType]
			  ,[EIN]
			  ,[Created]
			  ,[Email]
			  ,[ExternalID]
			  ,[FirstName]
			  ,[LastName]
			  ,[Locked]
			  ,[SecurityProfile]
			  ,[Username]
			  ,[ImportedAsQBIClient]
			  ,[CreateDateTime]
			  ,k.[CreatedBy]
			  ,k.[UpdatedDateTime]
			  ,k.[UpdatedBy]
			  ,k.[Note]
		  FROM [Temp].[KronosQBIClient] k

		  INNER JOIN [Map].[CustomerKronosClientMap] ck on k.KronosQBIClientID = ck.KronosClientID

		  WHERE ck.CustomerID = @customerID*/
	
	SELECT 
		  tpm.*
		, p.FirstName 
		, p.LastName
		, p.Email
	
	FROM [Map].[ThirdPartyProviderMap] tpm 
	INNER JOIN [Customer].[Customer] c on tpm.CustomerID = c.CustomerID
	INNER JOIN [customer].[Person] p on c.PersonID = p.PersonID
	WHERE tpm.CustomerID = @customerID



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
