SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspInsertMemo]
@EntityID int,
@Memo text,
@UserName varchar(50),
@MemoName varchar(30) = null

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		 DECLARE @MemoID int

			INSERT INTO [Business].[Memo]
					   (
						[Memo],
						[Name],
						[CreatedBy],
						[UpdatedBy]  
					   )
          
				 VALUES(
						@Memo,
						@MemoName,
						@UserName,
						@UserName
				)

				SET @MemoID = scope_identity()
				
				INSERT INTO [Map].[EntityMemoMap]
				   (
					 [EntityID],
					 [MemoID],
					 [CreatedBy],
					 [UpdatedBy] 
					)
				 VALUES(
					@EntityID,
					@MemoID,
					@UserName,
					@UserName
				)

										
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
