SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <11/29/2016>
-- Description:	<insert workflow process record for balance reporting>
-- =============================================
CREATE PROCEDURE [Workflow].[uspInsertForm5500]
	@FormSource varchar(15) = null,
	@FormYear char(4) = null,
	@EIN varchar(15) = null,
	@PlanName varchar(50) = null,
	@PlanNumber char(3) = null,
	@BusinessCode varchar(15) = null,
    @TotalParticipants int = null,
    @TotalAssets int = null,
    @FormDocType varchar(15) = null,
	@Status varchar(15) = null,
    @SortOrder [dbo].[SORTORDER] = null,
    @CreatedDateTime [dbo].[CREATEDDATETIME],
    @CreatedBy [dbo].[CREATEDBY],
    @UpdatedDateTime [dbo].[UPDATEDDATETIME],
    @UpdatedBy [dbo].[UPDATEDBY],
    @Note [dbo].[NOTE]= null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO [Workflow].[Form5500]
           ([FormSource]
           ,[FormYear]
           ,[EIN]
           ,[PlanName]
           ,[PlanNumber]
           ,[BusinessCode]
           ,[TotalParticipants]
           ,[TotalAssets]
           ,[FormDocType]
		   ,[Status]
           ,[SortOrder]
           ,[CreatedDateTime]
           ,[CreatedBy]
           ,[UpdatedDateTime]
           ,[UpdatedBy]
           ,[Note])
     VALUES
           (
		   @FormSource,
           @FormYear, 
           @EIN, 
           @PlanName,
           @PlanNumber,
           @BusinessCode,
           @TotalParticipants,
           @TotalAssets,
           @FormDocType,
		   @Status,
           @SortOrder,
           @CreatedDateTime,
           @CreatedBy, 
           @UpdatedDateTime, 
           @UpdatedBy, 
           @Note )
END




GO
