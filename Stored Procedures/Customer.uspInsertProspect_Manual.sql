SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspInsertProspect_Manual]
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
 @UpdatedDateTime datetime = null,
 @CreatedDateTime datetime = null,
 @CustomerID int OUT

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		 DECLARE @EntityID int
		 DECLARE @CustomerTypeID int -- Prospect

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
							[UpdatedBy],
							[UpdatedDateTime],
							[CreatedDateTime]
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
							@UserName,
							@UpdatedDateTime,
							@CreatedDateTime

					   )

				SET @EntityID = scope_identity()
				
				SET @CustomerTypeID = (SELECT TOP 1 CustomerTypeID FROM [Definition].[CustomerType] WHERE Name = 'Prospect')
				
				DECLARE @StatusGroupMap int
				
				if (@PriceProposal = 0 AND  @illustrationProposal = 0 )
					BEGIN
						SET @StatusGroupMap = (SELECT TOP 1 sgm.StatusGroupMapID 
											 FROM [Map].[StatusGroupMap] sgm 
													INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
											WHERE st.Name = 'Pending' and sgm.StatusGroupID = 2)
					END
				else if (@PriceProposal = 1 AND  @illustrationProposal = 1 )
					BEGIN
						SET @StatusGroupMap = (SELECT TOP 1 sgm.StatusGroupMapID 
											 FROM [Map].[StatusGroupMap] sgm 
													INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
											WHERE st.Name = 'Price & Illustration Proposal Sent' and sgm.StatusGroupID = 2 )
					END
				else if (@illustrationProposal = 1 and @PriceProposal = 0 )
					BEGIN
						SET @StatusGroupMap = (SELECT TOP 1 sgm.StatusGroupMapID 
											 FROM [Map].[StatusGroupMap] sgm 
													INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
											WHERE st.Name = 'Illustration Proposal Sent' and sgm.StatusGroupID = 2)
					END
				else if (@PriceProposal = 1 and @illustrationProposal = 0 )
					BEGIN
						SET @StatusGroupMap = (SELECT TOP 1 sgm.StatusGroupMapID 
											 FROM [Map].[StatusGroupMap] sgm 
													INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
											WHERE st.Name = 'Price Proposal Sent' and sgm.StatusGroupID = 2)
					END



				--DECLARE @CustomerID int
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
					   ,[UpdatedDateTime]
					   ,[CreatedDateTime]
				   )
				 VALUES
				   (
						@CustomerTypeID
					   ,@EntityID
					   ,@salesPersonID  --branch listSalesPerson added by peter 6/15/16
					   ,null
					   ,1
					   ,@StatusGroupMap
					   ,@UserName
					   ,@UserName
					   ,@UpdatedDateTime
					   ,@CreatedDateTime
				   )

					SET @CustomerID = scope_identity()

				INSERT INTO [Map].[CustomerSupervisorMap]
						   ([CustomerID]
						   ,[Supervisor_PersonID]
						   ,[Description]
						   ,[IsActive]
						   ,[CreatedBy]
						   ,[UpdatedBy]
						   ,[UpdatedDateTime]
						   ,[CreatedDateTime])
					 VALUES(
						    @CustomerID
						   ,@SuperVisorPersonID
						   ,null
						   ,1
						   ,@UserName
						   ,@UserName
						   ,@UpdatedDateTime
						   ,@CreatedDateTime)
				
				if( @Description is not null )
					exec [Customer].[uspInsertMemo] @EntityID, @Description, @UserName , null 
										
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
