SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Customer].[uspDeleteAdvisorByAdvisorCustomerID]
	  @AdvisorCustomerID bigint 
	 ,@productID int 
	
AS 
BEGIN
	BEGIN TRY
		
	DECLARE @PersonID int 	
	
	SET @PersonID = ( SELECT personID from [Customer].[Customer] WHERE customerID = @AdvisorCustomerID )
	

	
	declare @addressID table(
	  id int not null
	)
	insert into @addressID
	 SELECT addressID from [Customer].[Address] where addressID in ( select addressID from [Map].[PersonAddress] where PersonID = @PersonID )

	DECLARE @addAdvisorToMap_true_false int 

	SET @addAdvisorToMap_true_false = (	SELECT count(ProductAdvisorMapID)  from [Map].ProductAdvisorMap  where AdvisorCustomerID = @AdvisorCustomerID )

	/*IF( @addAdvisorToMap_true_false = 1 )
		BEGIN  
		
			DELETE FROM [Map].[PersonAddress]
				WHERE PersonID = @PersonID 	

			DELETE from [Customer].[Address] 
				where addressID in ( select * from  @addressID )


			DELETE FROM [Map].[PersonPhoneMap]
				WHERE PersonID = @PersonID 
	
			DELETE FROM [Customer].[Phone]
				WHERE PersonID = @PersonID

		END*/
	
	DELETE FROM [Map].[ProductAdvisorMap]
		WHERE AdvisorCustomerID = @AdvisorCustomerID
		AND ProductID = @productID
	

	/*DELETE FROM [Customer].[Customer]
		WHERE CustomerID = @AdvisorCustomerID

	DELETE FROM [Customer].[Person]
		WHERE PersonID = @PersonID*/

	
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
