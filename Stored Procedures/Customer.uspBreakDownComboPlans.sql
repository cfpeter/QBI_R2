SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
	CREATE PROC [Customer].[uspBreakDownComboPlans]
	 @customerID int 
	,@UserName varchar(45)
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN			
			
			DECLARE 
			 @combo_productTypeMapID int 
			,@ProductTypeMapID int 
			,@eachProductTypeMapID int
			,@ProductID_OUT int
			,@assets int = null
			,@Participants int = null
			,@salesPersonID int = null 
			,@StatusGroupMapID int = null
			,@ProductOriginID int = null
			,@Note varchar(200) = 'Added while being proceed with convert to customer'
			,@EntityID int
			,@productCount int 
			
			update top(1) [Business].[Product]
				SET isProspect = 1 
			WHERE CustomerID = @customerID  

			SET @assets				= ( SELECT   [ProductAssets]		FROM [Business].[Product] WHERE CustomerID = @customerID	and isProspect = 1 )
			SET @Participants		= ( SELECT   [NumberOfParticipant]	FROM [Business].[Product] WHERE CustomerID = @customerID	and isProspect = 1 )
			SET @salesPersonID		= ( SELECT   [SalesPersonID]		FROM [Business].[Product] WHERE CustomerID = @customerID	and isProspect = 1 )
			SET @StatusGroupMapID	= ( SELECT   [StatusGroupMapID]		FROM [Business].[Product] WHERE CustomerID = @customerID	and isProspect = 1 )
			SET @ProductOriginID	= ( SELECT  [ProductOriginID]		FROM [Business].[Product] WHERE CustomerID = @customerID	and isProspect = 1 )

			SET @EntityID = (SELECT EntityID from [Customer].[Customer] WHERE CustomerID = @customerID ) 
			SET @ProductTypeMapID = ( SELECT productTypeMapID FROM [Business].[Product] WHERE CustomerID = @customerID  and isProspect = 1  )
			
			SET @combo_productTypeMapID = ( SELECT top(1) [PlanComboBreakdownID]  FROM [Map].[PlanComboBreakdown] WHERE ComboProductTypeMapID = @ProductTypeMapID )
		 
			SET @productCount = (SELECT COUNT(*) as num  FROM [Business].[Product] WHERE CustomerID = @customerID )
			if( @productCount = 1 )
				BEGIN
					if( @combo_productTypeMapID is not NULL )
						BEGIN
							DECLARE @crsr Cursor
							SET @crsr = Cursor For 
							SELECT ProductTypeMapID FROM [Map].[PlanComboBreakdown] WHERE ComboProductTypeMapID = @ProductTypeMapID
							OPEN @crsr
							FETCH NEXT FROM @crsr INTO @eachProductTypeMapID 

							WHILE ( @@FETCH_STATUS = 0 )
								BEGIN
								 exec @ProductID_OUT = [Product].[uspInsertProduct] 
									@ProductID			= 0,
									@ProductTypeMapID	= @eachProductTypeMapID,--@ProductTypeMapID
									@CustomerID			= @CustomerID , --@CustomerID
									@CreatedBy			= @UserName , --@UpdatedBy
									@Number			    = NULL, --@Number
									@Name				= NULL, --@Name
									@ProductAssets		= @assets, --@ProductAssets
									@NumberOfParticipant= @Participants,--@NumberOfParticipant
									@SalesPersonID		= @salesPersonID, --@SalesPersonID
									@StatusGroupMapID	= @StatusGroupMapID,--@StatusGroupMapID
									@ProductOriginID	= @ProductOriginID,--@ProductOriginID
									@Note				= @Note --@Note
				
					
									/*
									UPDATE [Customer].[Entity] 
									SET ProductID = @ProductID_OUT
									WHERE EntityID = @EntityID 
									*/
									FETCH NEXT FROM @crsr INTO @eachProductTypeMapID  
								END

							Close @crsr
							Deallocate @crsr

						END
				END
			

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
