SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Workflow].[uspInsertWorkflowMemo] 
@entityID int,
@productWorkflowID int,
@memo text,
@actualFinishDate datetime = null,
@UserName varchar(50)

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		 DECLARE @MemoID int 
		
		 if @actualFinishDate IS NULL
			SET @actualFinishDate = CURRENT_TIMESTAMP  
		 

			INSERT INTO [Business].[Memo]
					   (
						 [Memo]
						,[CreatedBy]
						,[UpdatedBy]  
					   )
          
				 VALUES(
						 @memo
						,@UserName
						,@UserName
				)

				SET @MemoID = scope_identity()
				
				INSERT INTO [Map].[WorkflowMemoMap]
				   (
					  [ProductWorkflowID]
					 ,[MemoID]
					 ,[EntityID]
					 ,[CreatedBy]
					 ,[CreatedDateTime]
					 ,[UpdatedBy]
					 ,[UpdatedDateTime]
					)
				 VALUES(
					 @ProductWorkflowID
					,@MemoID
					,@entityID
					,@UserName
					,CURRENT_TIMESTAMP
					,@UserName
					,CURRENT_TIMESTAMP
				)
				 
	
		--EXECUTE [Workflow].[uspUpdateProductWorkflow] @ProductWorkflowID , @actualFinishDate
		 							
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
