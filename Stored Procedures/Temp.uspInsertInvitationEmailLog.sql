SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <10/18/2016>
-- Description:	<Insert InvitationEmailLog table>
-- =============================================
CREATE PROCEDURE [Temp].[uspInsertInvitationEmailLog] 
	@ContactID int,
	@ClientID int,
	@TemplatePath varchar(150),
    @TemplateType varchar(30),
	@FullName varchar(60),
	@Email varchar(120),
    @DateTimeSent datetime,
    @Count int,
    @Errored bit = null,
    @Message varchar(max) = null,
    @UpdatedDateTime datetime,
	@UpdatedBy varchar(50),
    @Notes [Note]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO [Temp].[InvitationEmailLog]
           ([ContactID]
           ,[ClientID]
           ,[TemplatePath]
           ,[TemplateType]
		   ,[FullName]
		   ,[Email]
           ,[DateTimeSent]
           ,[Count]
           ,[Errored]
           ,[Message]
           ,[CreatedDateTime]
           ,[CreatedBy]
           ,[UpdatedDateTime]
           ,[UpdatedBy]
           ,[Notes])
     VALUES
           (@ContactID
           ,@ClientID
           ,@TemplatePath
           ,@TemplateType
		   ,@FullName
		   ,@Email
           ,@DateTimeSent
           ,@Count
           ,@Errored
           ,@Message
           ,CURRENT_TIMESTAMP
           ,@UpdatedBy
           ,@UpdatedDateTime
           ,@UpdatedBy
           ,@Notes)

		SELECT * FROM [Temp].[InvitationEmailLog]
		WHERE InvitationEmailLogID = SCOPE_IDENTITY()
END




GO
