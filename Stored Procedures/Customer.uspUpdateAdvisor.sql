SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <8/31/2017>
-- Description:	<update advisor>
-- =============================================
CREATE PROC [Customer].[uspUpdateAdvisor]
	 
	 @customerID int 
	,@productID int 
	,@advisorTypeID int
	,@phoneTypeID int = null 
	,@firstName varchar (50)
	,@lastName varchar(50)
	,@email varchar(50) = null
	,@phoneNumberID bigint 
	,@phoneNumber varchar(12) = null
	,@phoneExtension varchar(12) = null
	,@userName varchar(50)

	
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN			
			
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP 
			DECLARE  
				@personID int 
				,@phoneID int 
		
		DECLARE @addAdvisorToMap_true_false int 

		SET @addAdvisorToMap_true_false = (	SELECT count(ProductAdvisorMapID)  from [Map].ProductAdvisorMap  where ProductID = @productID and AdvisorCustomerID = @customerID )

			

			SET @personID = ( SELECT PersonID from [Customer].[Customer] WHERE customerID = @customerID )
			SET @phoneID = ( SELECT @phoneID from [Customer].[Phone] WHERE PersonID = @personID )
		 
			UPDATE [Customer].[Person]
			SET 
			  [FirstName]		=	@firstName
			 ,[LastName]		=	@lastName
			 ,[Email]			=	@email
			 ,[UpdatedBy]		=	@userName
			 ,[UpdatedDateTime]	=	@UpdateDateTime
			 WHERE PersonID		= @personID
			  
			
			UPDATE [Customer].[Customer]
			 SET
				 [AdvisorTypeID]	= @advisorTypeID 
				,[UpdatedDateTime]	= @UpdateDateTime
				,[UpdatedBy]		= @userName
			WHERE CustomerID		= @customerID
			 	
		
		IF( @addAdvisorToMap_true_false = 0 )
				BEGIN  

				INSERT INTO [Map].[ProductAdvisorMap]
					   (
					    [ProductID]
					   ,[AdvisorCustomerID]
					   ,[Name]
					   ,[Description]
					   ,[CreatedDateTime]
					   ,[CreatedBy]
					   ,[UpdatedDateTime]
					   ,[UpdatedBy]
					   )
				 VALUES
					   (
					    @productID
					   ,@customerID
					   ,null
					   ,null
					   ,@UpdateDateTime
					   ,@userName
					   ,@UpdateDateTime
					   ,@userName
					   )
 


				END

		if( @phoneNumber IS NOT NULL )
			BEGIN

				UPDATE [Customer].[Phone]
					SET
						 [PhoneTypeID]		= @phoneTypeID
						,[Number]			= @phoneNumber
						,[NumberExt]		= @phoneExtension
						,[UpdatedDateTime]	= @UpdateDateTime
					    ,[UpdatedBy]		= @userName
				WHERE PhoneID = @phoneNumberID
				 
			END	
		
		SELECT	
				c.CustomerID AdvisorCustomerID,
				c.AdvisorTypeID,
				c.UpdatedDateTime,
				c.UpdatedBy,
				ad.Name advisorTypeName,
				p.PersonID , p.FirstName,p.LastName,p.Email,p.UpdatedBy,
				ph.Number,ph.PhoneID,ph.PhoneTypeID  , ph.NumberExt
		FROM [Customer].[Customer] c
			INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
			LEFT JOIN [Customer].[Phone] ph on ph.PhoneID = (SELECT ppm.PhoneID FROM [Map].[PersonPhoneMap] ppm WHERE  p.PersonID = ppm.PersonID)
			INNER JOIN [Definition].[AdvisorType] ad on c.AdvisorTypeID = ad.AdvisorTypeID
		WHERE c.CustomerID = @CustomerID



		/* SELECT p.PersonID , p.FirstName,p.LastName,p.Email,p.UpdatedBy,
				ph.Number,ph.PhoneID,ph.PhoneTypeID 
		 FROM [Customer].[Person] p
			INNER JOIN [Customer].[Phone] ph on p.PersonID = ph.PersonID
		 WHERE p.PersonID = @personID*/

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
