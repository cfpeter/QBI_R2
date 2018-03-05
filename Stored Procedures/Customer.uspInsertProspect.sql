SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspInsertProspect]
 @EntityTypeID int, --sole
 @ProductOriginID int,
 @ProductTypeMapID int,
 @Name varchar(50),
 @CallerName varchar(50),
 @CallerEmail varchar(150),
 @CallerPhone varchar(15),
 @Favorite bit = null,
 @Followup bit = null,
 @Followupdate date = null,
 @Description text = null,
 --@LocationZipcode varchar(10),
 @Location varchar(50),
 -- @SalesPerson varchar(50),  branch listSalesPerson commented by peter 6/15/16
 @PriceProposal varchar(50),
 @illustrationProposal varchar(50),
 @Participants int,
 @Assets int,
 @InvestmentVendorIDs varchar(50),
 @UserName varchar(50),
 @SuperVisorPersonID int,
 @salesPersonID int, --branch listSalesPerson added by peter 6/15/16
 @CustomerID int OUT

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		 DECLARE @EntityID int
		 DECLARE @CustomerTypeID int = (SELECT CustomerTypeID FROM [Definition].[CustomerType] WHERE Name='Prospect')
		 DECLARE @SuperVisorCustomerID bigint 
		 print ('ENTITY')
			INSERT INTO [Customer].[Entity]
					   (
							[EntityTypeID],   
							[Name],
							[CallerName],
							[CallerEmail],
							[CallerPhone],
							[Description],
							[Location],
							--	[salesPerson], --branch listSalesPerson commented by peter 6/15/16
							[ProductTypeMapID],
							[Participants],
							[ProductOriginID],
							[InvestmentVendorIDs],
							[Favorite],
							[Assets],
							[FollowUp],
							[FollowUpDate],
							[CreatedBy],
							[UpdatedBy]
					   )
          
				 VALUES
					   (
							@EntityTypeID,         
							@Name,
							@CallerName,
							@CallerEmail,
							@CallerPhone,
							@Description,
							@Location,
							--@SalesPerson, --branch listSalesPerson commented by peter 6/15/16
							@ProductTypeMapID,
							@Participants,
							@ProductOriginID,
							@InvestmentVendorIDs,
							@Favorite,
							@Assets,
							@Followup,
							@Followupdate,
							@UserName,
							@UserName
					   )

				SET @EntityID = scope_identity()
				print (@EntityID)
				DECLARE @StatusID int = (SELECT StatusID FROM [Definition].[Status] WHERE Name = 'Pending')
				DECLARE @StatusGroupMapID int = (SELECT StatusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusID = @StatusID )
				--DECLARE @CustomerID int
				print ('Customer')
				INSERT INTO [Customer].[Customer]
				   (
						[CustomerTypeID]
					   ,[EntityID]
					   ,[SalesPersonID] --branch listSalesPerson added by peter 6/15/16
					   ,[Description]
					   ,[IsActive]
					   ,[StatusGroupMapID]
					   ,[CreatedBy]
					   ,[UpdatedBy]

				   )
				 VALUES
				   (
						@CustomerTypeID
					   ,@EntityID
					   ,@salesPersonID  --branch listSalesPerson added by peter 6/15/16
					   ,null
					   ,1
					   ,@StatusGroupMapID
					   ,@UserName
					   ,@UserName
				   )

					SET @CustomerID = scope_identity()
					print (@CustomerID)
					SET @SuperVisorCustomerID = ( SELECT CustomerID FROM [Customer].[Customer] WHERE PersonID = @SuperVisorPersonID )
				print ('@SuperVisorCustomerID')
				print (@SuperVisorCustomerID)
				INSERT INTO [Map].[CustomerSupervisorMap]
						   ([CustomerID]
						   ,[Supervisor_PersonID]
						   ,[Supervisor_CustomerID]
						   ,[Description]
						   ,[IsActive]
						   ,[CreatedBy]
						   ,[UpdatedBy])
					 VALUES(
						    @CustomerID
						   ,@SuperVisorPersonID
						   ,@SuperVisorCustomerID
						   ,@UserName + ' Supervising ' +  @Name
						   ,1
						   ,@UserName
						   ,@UserName)
				
				if( @Description is not null )
				BEGIN
					print ('uspInsertMemo')
					exec [Customer].[uspInsertMemo] @EntityID, @Description, @UserName , null 
				END

				if( @ProductTypeMapID is not null )
				BEGIN
					print ('uspInsertProduct')
					DECLARE @Note varchar(100) = @Name + ' | Prospect Plan' 
					DECLARE @ProductID_OUT bigint 
						
						exec @ProductID_OUT		= [Product].[uspInsertProduct] 
						@ProductID				= 0,
						@ProductTypeMapID		= @ProductTypeMapID,--@ProductTypeMapID
						@CustomerID				= @CustomerID ,  
						@number					= '000', -- by default 
						@CreatedBy				= @UserName ,  
						@ProductAssets			= @assets  , 
						@NumberOfParticipant	= @Participants,--@NumberOfParticipant
						@salesPersonID			= @salesPersonID, --@SalesPersonID
						@StatusGroupMapID		= @StatusGroupMapID,--@StatusGroupMapID
						@ProductOriginID		= @ProductOriginID,--@ProductOriginID
						@Note					= @Note,  
						@isProspect				= 1  

					print ('@ProductID_OUT')
					print(@ProductID_OUT)
						
					print ('Entity')	 
					UPDATE [Customer].[Entity] 
					SET ProductID = @ProductID_OUT
					WHERE EntityID = @EntityID
					print (@EntityID)	 
					print ('@ProductOriginName')	
					DECLARE @ProductOriginName varchar(50) = (SELECT Name FROM [Definition].[ProductOrigin] WHERE ProductOriginID = @ProductOriginID )	
					print (@ProductOriginName)
					DECLARE @WorkflowTypeID int = (SELECT WorkflowTypeID FROM [Definition].[WorkflowType] WHERE Name = @ProductOriginName)
					print (@WorkflowTypeID)

					/*IF( @WorkflowTypeID IS NULL )
					BEGIN
						SET @WorkflowTypeID = (SELECT WorkflowTypeID FROM [Definition].[WorkflowType] WHERE Name = 'Take Over')
					END*/
					
					print ('uspInsertAllProductWorkflowsByType')
					exec [Workflow].[uspInsertAllProductWorkflowsByType] 
								 @ProductTypeMapID,
								 @WorkflowTypeID,
								 @ProductID_OUT,
								 @UserName,
								 NULL,
								 NULL
				END					
			 COMMIT
	
	 END TRY
	 BEGIN CATCH
		if(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			exec dbo.uspRethrowError
		END
	 END CATCH
END













GO
