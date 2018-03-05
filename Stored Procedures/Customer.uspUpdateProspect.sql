SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspUpdateProspect]
 
 @CustomerID bigint,
 @EntityID int,
 @ProductOriginID int = null,
 @ProductTypeMapID int,
 @Name varchar(50),
 @CallerName varchar(50),
 @CallerEmail varchar(150),
 @CallerPhone varchar(15),
 @Favorite bit = null,
 @Followup bit = null,
 @Followupdate date = null,
 --@salesPerson varchar(50),  -- branch listSalesPerson  commented by peter 6/15/16
 @assets int ,
 @Description text = null,
 --@LocationZipcode varchar(10),
 @Location varchar(50),
 @PriceProposal varchar(50),
 @illustrationProposal varchar(50),
 @Participants int = null,
 @InvestmentVendorIDs varchar(50),
 @UserName varchar(50),
 @salesPersonID int = null, --  branch listSalesPerson added by peter 6/15/16
 @SuperVisorPersonID int,
 @updatedDate datetime 

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		 DECLARE @updatedDateTime dateTime = CURRENT_TIMESTAMP
		 DECLARE @CustomerTypeID int = (SELECT CustomerTypeID FROM [Definition].[CustomerType] WHERE Name='Prospect')
		 DECLARE @SuperVisorCustomerID bigint 
		 DECLARE @ProductID bigint = null
		 DECLARE @Org_ProductOriginID int = (SELECT ProductOriginID FROM [Customer].[Entity] WHERE EntityID = @EntityID )
			
			UPDATE [Customer].[Entity] 
					SET   
							[Name] = @Name,
							[CallerName] = @CallerName,
							[CallerEmail] = @CallerEmail,
							[CallerPhone] = @CallerPhone,
							[Description] = @Description,
						  --[LocationZipcode] = @LocationZipcode,
							[Location] = @Location,
						  --[SalesPerson] = @salesPerson, -- branch listSalesPerson commented by peter 6/15/16
							[Assets] = @assets,
							[ProductTypeMapID] = @ProductTypeMapID,
							[Participants] = @Participants,
							[ProductOriginID] = @ProductOriginID,
							[InvestmentVendorIDs] = @InvestmentVendorIDs,
							[Favorite] = @Favorite,
							[FollowUp] = @Followup,
							[FollowUpDate] = @Followupdate,
							[UpdatedBy] = @UserName,
							[UpdatedDateTime] = @updatedDateTime
					  
					   WHERE EntityID = @EntityID
          
				



				--DECLARE @CustomerID int
				DECLARE @StatusGroupMapID int = null
				
				if (@PriceProposal = 0 AND  @illustrationProposal = 0 )
					BEGIN
						SET @StatusGroupMapID = (SELECT TOP 1 sgm.StatusGroupMapID 
											 FROM [Map].[StatusGroupMap] sgm 
													INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
											WHERE st.Name = 'Pending' and sgm.StatusGroupID = 2)
					END
				else if (@PriceProposal = 1 AND  @illustrationProposal = 1 )
					BEGIN
						SET @StatusGroupMapID = (SELECT TOP 1 sgm.StatusGroupMapID 
											 FROM [Map].[StatusGroupMap] sgm 
													INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
											WHERE st.Name = 'Price & Illustration Proposal Sent' and sgm.StatusGroupID = 2 )
					END
				else if (@illustrationProposal = 1 and @PriceProposal = 0 )
					BEGIN
						SET @StatusGroupMapID = (SELECT TOP 1 sgm.StatusGroupMapID 
											 FROM [Map].[StatusGroupMap] sgm 
													INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
											WHERE st.Name = 'Illustration Proposal Sent' and sgm.StatusGroupID = 2)
					END
				else if (@PriceProposal = 1 and @illustrationProposal = 0 )
					BEGIN
						SET @StatusGroupMapID = (SELECT TOP 1 sgm.StatusGroupMapID 
											 FROM [Map].[StatusGroupMap] sgm 
													INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
											WHERE st.Name = 'Price Proposal Sent' and sgm.StatusGroupID = 2)
					END


				UPDATE [Customer].[Customer]
				  SET
						--CustomerTypeID = @CustomerTypeID
					   -- EntityID = @EntityID
					   [SalesPersonID] = @salesPersonID, --branch listSalesPerson  added by peter 6/15/16
					   [Description] = null,
					   [IsActive] = 1,
					   [StatusGroupMapID] = @StatusGroupMapID,
					   [UpdatedBy] = @UserName,
					   [UpdatedDateTime] = @updatedDateTime


				--  WHERE Customer.EntityID = @EntityID AND 
				WHERE Customer.CustomerID = @CustomerID
			
				--SET @CustomerID = scope_identity()

				SET @SuperVisorCustomerID = ( SELECT CustomerID FROM [Customer].[Customer] WHERE PersonID = @SuperVisorPersonID )

				UPDATE  [Map].[CustomerSupervisorMap]
						   SET
						    [CustomerID] = @CustomerID
						   ,[Supervisor_PersonID] = @SuperVisorPersonID
						   ,[Supervisor_CustomerID] = @SuperVisorCustomerID
						   ,[Description] =  @UserName + ' Supervising ' +  @Name
						   ,[IsActive] = 1
						   ,[UpdatedBy] = @UserName
						   ,[UpdatedDateTime] = @updatedDateTime

				where CustomerID = @CustomerID

				if( @Description is not null )
					exec [Customer].[uspInsertMemo] @EntityID, @Description, @UserName , null 
				
				
				SET @ProductID = (SELECT ProductID FROM [Customer].[Entity] WHERE EntityID = @EntityID )
				DECLARE @OriginalProductTypeMapID int = (SELECT ProductTypeMapID FROM [Business].[Product] WHERE ProductID = @ProductID)
 
				if( @ProductTypeMapID is not null and @ProductID is not null )
				BEGIN
					DECLARE @Note varchar(MAX) = @Name + ' | Prospect Plan updated' 
					exec [Product].[uspUpdateProduct] 
						@ProductID = @ProductID, --@ProductID
						@ProductTypeMapID = @ProductTypeMapID,--@ProductTypeMapID
						@CustomerID = @CustomerID , --@CustomerID
						@UpdatedBy = @UserName , --@UpdatedBy
						--@Number = NULL, --@Number
						--@Name = NULL, --@Name
						@ProductAssets = @assets, --@ProductAssets
						@NumberOfParticipant = @Participants,--@NumberOfParticipant
						@SalesPersonID = @salesPersonID, --@SalesPersonID
						@StatusGroupMapID = @StatusGroupMapID,--@StatusGroupMapID
						@ProductOriginID = @ProductOriginID,--@ProductOriginID
						@Note = @Note --@Note
					
						 
				END	
				IF(@OriginalProductTypeMapID <> @ProductTypeMapID OR @Org_ProductOriginID <> @ProductOriginID )
				BEGIN
					DELETE FROM [Map].[ProductWorkflow] WHERE ProductID = @ProductID

					DECLARE @ProductOriginName varchar(50) = (SELECT Name FROM [Definition].[ProductOrigin] WHERE ProductOriginID = @ProductOriginID )	
					DECLARE @WorkflowTypeID int = (SELECT WorkflowTypeID FROM [Definition].[WorkflowType] WHERE Name = @ProductOriginName)

					IF( @WorkflowTypeID IS NULL )
					BEGIN
						SET @WorkflowTypeID = (SELECT WorkflowTypeID FROM [Definition].[WorkflowType] WHERE Name = 'Take Over')
					END
					
					DECLARE @ProductID_OUT bigint
					exec [Workflow].[uspInsertAllProductWorkflowsByType] 
								 @ProductTypeMapID,
								 @WorkflowTypeID,
								 @ProductID,
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
