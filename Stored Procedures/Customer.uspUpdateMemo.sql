SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspUpdateMemo]
@MemoID int,
@Memo text,
@UserName varchar(50) 
AS 
BEGIN
	BEGIN TRY
		-- DECLARE @MemoID int.
		DECLARE @updatedDateTime dateTime = CURRENT_TIMESTAMP
			UPDATE [Business].[Memo]
				SET
					 [Memo] = @Memo
					,[UpdatedBy] = @UserName
					,[UpdatedDateTime] = @updatedDateTime
				WHERE MemoID = @MemoID
											
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
