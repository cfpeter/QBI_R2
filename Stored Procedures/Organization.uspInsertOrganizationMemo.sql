SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <03/01/2017>
-- Description:	<Inser memo for organization using map table>
-- =============================================
CREATE PROCEDURE [Organization].[uspInsertOrganizationMemo] 
	@CustomerID bigint,
	@OrganizationBranchID bigint,
	@Memo text,
	@UserName varchar(50),
	@MemoName varchar(50) = NULL
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
			SET NOCOUNT ON;
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP
			DECLARE	@return_value int,@MemoID int

			EXEC	@return_value = [Common].[uspInsertMemo]
					@Memo = @Memo,
					@UserName = @UserName,
					@MemoName = @MemoName,
					@MemoID = @MemoID OUTPUT

			-- Insert statements for procedure here
			INSERT INTO [Map].[OrganizationMemo]
				   ([OrganizationBranchID]
				   ,[MemoID]
				   ,[IsActive]
				   ,[SortOrder]
				   ,[CreatedDateTime]
				   ,[CreatedBy]
				   ,[UpdatedDateTime]
				   ,[UpdatedBy])
			 VALUES
				   (@OrganizationBranchID
				   ,@MemoID
				   ,1
				   ,NULL
				   ,@UpdateDateTime
				   ,@UserName
				   ,@UpdateDateTime
				   ,@UserName)
			
			execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , 'Memo Added to Organization'
				
			SELECT m.*, om.OrganizationBranchID
					FROM [Map].[OrganizationMemo]  om 
					INNER JOIN [Business].[Memo] m on om.MemoID = m.MemoID
					WHERE om.OrganizationBranchID = @OrganizationBranchID	
					AND om.MemoID = @MemoID
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
