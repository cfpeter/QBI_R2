SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <03/01/2017>
-- Description:	<Insert memo into memo table>
-- =============================================
CREATE PROCEDURE [Common].[uspInsertMemo] 
	-- Add the parameters for the stored procedure here
	@Memo text,
	@UserName varchar(50),
	@MemoName varchar(50) = NULL,
	@MemoID int OUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Business].[Memo]
           ([Memo]
           ,[Name]
           ,[CreatedDateTime]
           ,[CreatedBy]
           ,[UpdatedDateTime]
           ,[UpdatedBy])
     VALUES
           (@Memo
           ,@MemoName
           ,CURRENT_TIMESTAMP
           ,@UserName
           ,CURRENT_TIMESTAMP
           ,@UserName)

	SET @MemoID = scope_identity()
	RETURN @MemoID
END





GO
