SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <10/18/2016>
-- Description:	<Update InvitationEmailLog Data>
-- =============================================
CREATE PROCEDURE [Temp].[uspUpdateInvitationEmailLog]
	@InvitationEmailLogID int,
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

    -- Insert statements for procedure here
	UPDATE [Temp].[InvitationEmailLog]
    SET [ContactID] = @ContactID
       ,[ClientID] = @ClientID
       ,[TemplatePath] = @TemplatePath
       ,[TemplateType] = @TemplateType
	   ,[FullName] = @FullName
	   ,[Email] = @Email
       ,[DateTimeSent] = @DateTimeSent
       ,[Count] = @Count
       ,[Errored] = @Errored
       ,[Message] = @Message 
       ,[UpdatedDateTime] = @UpdatedDateTime
       ,[UpdatedBy] = @UpdatedBy
       ,[Notes] = @Notes
 WHERE InvitationEmailLogID = @InvitationEmailLogID

 SELECT * FROM [Temp].[InvitationEmailLog]
 WHERE InvitationEmailLogID = @InvitationEmailLogID
END




GO
