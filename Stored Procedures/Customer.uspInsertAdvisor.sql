SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <8/31/2017>
-- Description:	<insert advisor>
-- =============================================
CREATE PROC [Customer].[uspInsertAdvisor]
	 @advisorTypeID int 
	,@phoneTypeID int = null
	,@OrganizationBranchID int 
	,@ProductID bigint
	,@firstName varchar (50)
	,@lastName varchar(50)
	,@email varchar(50) = null
	,@phoneNumber varchar(12) = null
	,@phoneExtension varchar(12) = null
	,@userName varchar(50)

	
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN			
			
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP 
			DECLARE @statusGroupMapID int 
			SET @statusGroupMapID = ( SELECT StatusGroupMapID from [Map].[StatusGroupMap] sgm 
				INNER JOIN [Definition].[StatusGroup] sg on sgm.StatusGroupID = sg.StatusGroupID AND sg.Name = 'Customer'
				INNER JOIN [Definition].[Status] s on sgm.StatusID = s.StatusID AND s.Name = 'Active' )

			INSERT INTO [Customer].[Person]
			(
				 [OrganizationBranchID]
				,[FirstName]
				,[LastName]
				,[Email]
				,[CreatedDateTime]
				,[CreatedBy]
				,[UpdatedDateTime]
				,[UpdatedBy]
			)
			VALUES(
				 null -- no organization for advisor 
				,@firstName
				,@lastName
				,@email
				,@UpdateDateTime
				,@userName
				,@UpdateDateTime
				,@userName
			)
			DECLARE @personID int = scope_identity()
			
			DECLARE @customerTypeID int =  ( SELECT CustomerTypeID from [Definition].[CustomerType] WHERE Name = 'Advisor' )
			INSERT INTO [Customer].[Customer]
			(
				 [CustomerTypeID]
				,[StatusGroupMapID]
				,[PersonID]
				,[AdvisorTypeID]
				,[IsActive]
				,[CreatedDateTime]
				,[CreatedBy]
				,[UpdatedDateTime]
				,[UpdatedBy]
			)
			values(
				 @customerTypeID
				,@statusGroupMapID
				,@personID
				,@advisorTypeID
				,1 -- active 
				,@UpdateDateTime
				,@userName
				,@UpdateDateTime
				,@userName
			)	

			DECLARE @CustomerID int = scope_identity()
			
 
			INSERT INTO [Map].[ProductAdvisorMap]
			   (
			    [ProductID]
			   ,[AdvisorCustomerID]
			   ,[Name]
			   ,[Description]
			   ,[CreatedDateTime]
			   ,[CreatedBy]
			   ,[UpdatedDateTime]
			   ,[UpdatedBy])
			 VALUES
			   (
			    @ProductID
			   ,@CustomerID
			   ,null
			   ,null
			   ,@UpdateDateTime
			   ,@userName
			   ,@UpdateDateTime
			   ,@userName
			   )
 



		if( @phoneNumber IS NOT NULL )
			BEGIN
				INSERT INTO [Customer].[Phone]
					(
						[PhoneTypeID]
					  -- ,[PersonID]
					   ,[Number]
					   ,[NumberExt]
					   ,[CreatedDateTime]
					   ,[CreatedBy]
					   ,[UpdatedDateTime]
					   ,[UpdatedBy]

					)
					VALUES
					(
						 @phoneTypeID
					--	,@personID
						,@phoneNumber
						,@phoneExtension
						,@UpdateDateTime
						,@userName
						,@UpdateDateTime
						,@userName
					)
			DECLARE @PhoneID int = scope_identity()
 

			INSERT INTO [Map].[PersonPhoneMap]
				   (
				   [PersonID]
				   ,[PhoneID]
				   ,[Description]
				   ,[CreatedDateTime]
				   ,[CreatedBy]
				   ,[UpdatedDateTime]
				   ,[UpdatedBy])
			 VALUES
				   ( 
				   @personID
				   ,@PhoneID
				   ,null
				  ,@UpdateDateTime
				  ,@userName
				  ,@UpdateDateTime
				  ,@userName
				   )
 


			END	
		
		SELECT	
				c.CustomerID AdvisorCustomerID,
				c.AdvisorTypeID,
				c.UpdatedDateTime,
				c.UpdatedBy,
				ad.Name advisorTypeName,
				p.PersonID , p.FirstName,p.LastName,p.Email,p.UpdatedBy,
				ph.Number,ph.PhoneID,ph.PhoneTypeID , ph.NumberExt
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
