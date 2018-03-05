SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <12/27/2016>
-- Description:	<Update product (Plans) from CRM Save. the update only valid for active plans>
-- =============================================
CREATE PROCEDURE [Product].[uspUpdatePlanByCRMClientID]  
	@CRMClientID int,
	@PlanNumber varchar(3),
	@UserName varchar(50),
	@PYEDay int,
	@PYEMonth int,
	@CustomerID bigint = null,
	@ProductID bigint = null,
	@PlanType varchar(100)=null,
	@Status varchar(100)=null,
	@ProductOriginName varchar(20)=null,
	
	@PlanName varchar(100) = null,
	@PlanAssets int = null,
	@NumberOfParticipant int = null,
	@CurrentYearEnd date = null,
	@PlanYearEnd date = null,
	@ConsultantPersonID bigint = null,
	@ConsultantCustomerID bigint = null, -- added by Hamlet 12/11/17; for updating consultants
	@ConsultantEmail varchar(150) = null,
	@consultantFirstName varchar(50) = null,
	@consultantLastName varchar(50) = null,
	@BillingAddressSameAsClient bit = null,
	
	@Note [NOTE] = null
AS
BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ClinetID varchar(15) =  IsNull( (SELECT cast( @CRMClientID as varchar(15))), 'undefined')
	DECLARE @pNumber varchar(3) =  IsNull( (SELECT cast( @PlanNumber as varchar(3))), 'N/A')
	DECLARE @DateTimeStamp datetime = CURRENT_TIMESTAMP;
	DECLARE @ProductOriginID bigint = (SELECT ProductOriginID FROM [Definition].[ProductOrigin] WHERE Name = @ProductOriginName)

	DECLARE @Msg3 varchar(100)

	BEGIN TRY
		BEGIN TRAN
			

			IF( @CustomerID is NULL and @CRMClientID is not NULL)
				BEGIN
					SET @CustomerID = ( SELECT CustomerID FROM [Customer].[Customer] WHERE CRMClientID = @CRMClientID AND MainClient = 1)
					PRINT '@CustomerID'
					PRINT @CustomerID
				END
				
			IF( @CustomerID is not NULL )
				BEGIN
			
					DECLARE @ProductSubTypeID int = (SELECT ProductSubTypeID FROM [Definition].[ProductSubType] WHERE Name = @PlanType )
					PRINT '@ProductSubTypeID'
					PRINT @ProductSubTypeID
					
					DECLARE @subTypeCount int = ( SELECT COUNT(ProductSubTypeID) FROM customer.customer c
								Inner JOIN Business.Product p ON p.CustomerID = c.CustomerID
								INNER JOIN map.ProductTypeMap ptm ON ptm.ProductTypeMapID = p.ProductTypeMapID
		
								WHERE ptm.ProductSubTypeID = @ProductSubTypeID 
									AND c.CRMClientID = @CRMClientID 
									AND ( p.isProspect is NULL or p.isProspect = 0 )
						)

					DECLARE @ProductTypeID int;
					IF ( @subTypeCount = 1 )
						BEGIN
						
						
							SET @ProductTypeID = (SELECT productTypeID FROM customer.customer c
								Inner JOIN Business.Product p ON p.CustomerID = c.CustomerID
								INNER JOIN map.ProductTypeMap ptm ON ptm.ProductTypeMapID = p.ProductTypeMapID
		
								WHERE ptm.ProductSubTypeID = @ProductSubTypeID 
									AND c.CRMClientID = @CRMClientID 
									AND ( p.isProspect is NULL or p.isProspect = 0 )
							)
						END
					ELSE IF (@subTypeCount = 0)
						BEGIN
							if(@PlanType = 'Cash Balance' OR @PlanType  = 'Defined Benefit' )
								BEGIN
										SET @ProductTypeID = ( SELECT productTypeID from [Definition].[ProductType] where name = 'Pension Plan' )
								END
							ELSE
								BEGIN
									SET @ProductTypeID = ( SELECT productTypeID from [Definition].[ProductType] where name = 'Defined Contribution Plan' )
								END
									
							/*SET @ProductTypeID = (SELECT pt.productTypeID FROM [Definition].[ProductType] pt
								INNER JOIN [Map].[ProductTypeMap] ptm ON ptm.ProductSubTypeID = (SELECT ProductSubTypeID FROM [Definition].[ProductSubType] WHERE Name = @PlanType)
							)*/
						END
					ELSE
						BEGIN
							SET @Msg3  = 'Code:50000 More than one product with a given subtype was found for ClientID: ' + @ClinetID
							RAISERROR (@Msg3, -- Message text.  
										   16, -- Severity.  
										   1 -- State.  
										   );  
						END
					
							

					/*DECLARE @ProductTypeID int = (SELECT ProductTypeID FROM [Definition].[ProductType] WHERE Name = 'Plans' )
					PRINT '@ProductTypeID'
					PRINT @ProductTypeID*/
					DECLARE @ProductTypeMapID int = (SELECT ProductTypeMapID FROM [Map].[ProductTypeMap] WHERE ProductSubTypeID = @ProductSubTypeID AND ProductTypeID = @ProductTypeID )
					PRINT '@ProductTypeMapID'
					PRINT @ProductTypeMapID
					DECLARE @StatusID int = (SELECT StatusID FROM [Definition].[Status] WHERE Name = @Status)
					PRINT '@StatusID'
					PRINT @StatusID
					DECLARE @StatusGroupID int = (SELECT StatusGroupID FROM [Definition].[StatusGroup] WHERE Name = 'CRM Plans')
					PRINT '@StatusGroupID'
					PRINT @StatusGroupID
					DECLARE @StatusGroupMapID int = (SELECT StatusGroupMapID FROM [Map].[StatusGroupMap] WHERE StatusGroupID = @StatusGroupID AND StatusID = @StatusID )
					PRINT '@StatusGroupMapID'
					PRINT @StatusGroupMapID

					IF (@ConsultantPersonID IS NULL)
						BEGIN
							IF (@ConsultantCustomerID IS NOT NULL)
								BEGIN
									SET @ConsultantPersonID = (SELECT PersonID FROM [Customer].[Customer] WHERE CustomerID = @ConsultantCustomerID);
								END
							ELSE IF (@ConsultantEmail IS NOT NULL)
								BEGIN
									SET @ConsultantPersonID = ( SELECT PersonID FROM [Customer].[Person] WHERE Email = @ConsultantEmail);
								END
							ELSE
								BEGIN
									SET @ConsultantPersonID = ( SELECT PersonID FROM [Customer].[Person] WHERE firstName = @ConsultantFirstName and LastName = @ConsultantLastName );
								END
						END
									
					PRINT '@ConsultantPersonID'
					PRINT @ConsultantPersonID

					PRINT '@ProductID Before IF'
					PRINT @ProductID

					IF( @ProductID is NULL )
					BEGIN
										

					-- set @ProductSubTypeID  = 	( select ProductSubTypeID from [map].[ProductTypeMap] WHERE ProductTypeMapID = 5 )
						DECLARE @ProductCount int = ( SELECT COUNT(p.ProductID) FROM [Business].[Product] p
														INNER JOIN [Customer].[Customer] c on p.CustomerID = c.CustomerID
														INNER JOIN [Map].[ProductTypeMap] ptm ON ptm.ProductTypeMapID = p.ProductTypeMapID 
														INNER JOIN [Definition].[ProductSubType] pst ON pst.ProductSubTypeID = ptm.ProductSubTypeID
														INNER JOIN [Map].[StatusGroupMap] sgm on p.StatusGroupMapID = sgm.StatusGroupMapID
														INNER JOIN [Definition].[Status] st on sgm.StatusID = st.StatusID
														INNER JOIN [Definition].[StatusGroup] stg on sgm.StatusGroupID = stg.StatusGroupID

														WHERE c.CustomerID = @CustomerID 
														AND pst.ProductSubTypeID = @ProductSubTypeID
														AND ( p.isProspect is NULL or p.isProspect = 0 )
															--AND stg.StatusGroupID = @StatusGroupID
															--AND st.Name = 'Active'
													)
												
						PRINT '@ProductCount'
						PRINT @ProductCount
						IF( @ProductCount = 0 )
							BEGIN
								INSERT INTO [Business].[Product] 
								(customerID, ProductTypeMapID, StatusGroupMapID, ProductOriginID, ConsultantPersonID, Name, Number , ProductAssets, NumberOfParticipant, ProductYearEnd, BillingAddressSameAsClient, PYEDay, PYEMonth, CreatedDateTime, UpdatedDateTime, CreatedBy, UpdatedBy, Note) 
							
								VALUES (@CustomerID, @ProductTypeMapID, @StatusGroupMapID, @ProductOriginID, @ConsultantPersonID, @PlanName, @PlanNumber , @PlanAssets, @NumberOfParticipant, @PlanYearEnd, @BillingAddressSameAsClient, @PYEDay, @PYEMonth, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, @UserName, @UserName, '' )

								execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @DateTimeStamp , @Note

								DECLARE @pID bigint = SCOPE_IDENTITY()
							 
								SELECT * FROM [Business].[Product] WHERE ProductID = @pID

							END
						IF( @ProductCount = 1 )
							BEGIN
								SET @ProductID = ( SELECT p.ProductID FROM [Business].[Product] p
													INNER JOIN [Customer].[Customer] c on p.CustomerID = c.CustomerID
													--INNER JOIN [Map].[ProductTypeMap] ptm ON ptm.ProductTypeMapID = p.ProductTypeMapID
													--INNER JOIN [Definition].[ProductSubType] pst ON pst.ProductSubTypeID = ptm.ProductSubTypeID
													INNER JOIN [Map].[StatusGroupMap] sgm on p.StatusGroupMapID = sgm.StatusGroupMapID
													INNER JOIN [Definition].[Status] st on sgm.StatusID = st.StatusID
													INNER JOIN [Definition].[StatusGroup] stg on sgm.StatusGroupID = stg.StatusGroupID

													WHERE c.CustomerID = @CustomerID 
													AND p.ProductTypeMapID = @ProductTypeMapID
													AND ( p.isProspect is NULL or p.isProspect = 0 )
													--	AND pst.ProductSubTypeID = @ProductSubTypeID
													--	AND stg.StatusGroupID = @StatusGroupID
														--AND st.Name = 'Active'
												) 
							END
						ELSE IF(@ProductCount > 1)
							BEGIN
								DECLARE @Msg1 varchar(100) =  'Code:50000 More than one product ID record returned for Client ' + @ClinetID + ' And Plan number ' + @pNumber
								RAISERROR (@Msg1, -- Message text.  
										   16, -- Severity.  
										   1 -- State.  
										   ); 
							END
						/*ELSE
							BEGIN
								DECLARE @Msg2 varchar(100) = 'Code:50000 Product ID record does not exist for Client ' + @ClinetID + ' And Plan number ' + @pNumber
								RAISERROR (@Msg2, -- Message text.  
										   16, -- Severity.  
										   1 -- State.  
										   ); 
							END*/
					END

					IF( @ProductID is not NULL )
						BEGIN
							
							PRINT '@ProductID'
							PRINT @ProductID

							UPDATE [Business].[Product]
							   SET [ProductTypeMapID] = IsNull(@ProductTypeMapID, ProductTypeMapID)
								  ,[StatusGroupMapID] = IsNull(@StatusGroupMapID, StatusGroupMapID)
								  ,[ProductOriginID] = IsNull(@ProductOriginID, ProductOriginID)
								  ,[ConsultantPersonID] = IsNull(@ConsultantPersonID,ConsultantPersonID)
								  ,[Name] = IsNull(@PlanName, Name)
								  ,[number] = IsNull(@PlanNumber, Number)
								  ,[ProductAssets] = IsNull(@PlanAssets, ProductAssets)
								  ,[NumberOfParticipant] = IsNull(@NumberOfParticipant, NumberOfParticipant)
								  ,[ProductYearEnd] = IsNull(@PlanYearEnd,ProductYearEnd)
								  ,[BillingAddressSameAsClient] = IsNull(@BillingAddressSameAsClient,BillingAddressSameAsClient)
								  ,[PYEDay] = IsNull(@PYEDay, [PYEDay])
								  ,[PYEMonth] = IsNull(@PYEMonth, [PYEMonth])
								  ,[UpdatedDateTime] = CURRENT_TIMESTAMP
								  ,[UpdatedBy] = @UserName
								  ,[Note] = IsNull(@Note, Note)

							 WHERE ProductID = @ProductID

							--DECLARE @DateTimeStamp datetime = CURRENT_TIMESTAMP;

							execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @DateTimeStamp , @Note
							
							SELECT * FROM [Business].[Product] WHERE ProductID = @ProductID
						END								 
				END
			ELSE
				BEGIN
					SET @Msg3 = 'Code:50000 Unknow Client, Unable to locate CustomerID for Client ' + @ClinetID
					RAISERROR (@Msg3, -- Message text.  
										   16, -- Severity.  
										   1 -- State.  
										   );  
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
