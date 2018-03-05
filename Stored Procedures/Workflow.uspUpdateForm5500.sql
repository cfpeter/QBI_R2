SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <11/29/2016>
-- Description:	<update workflow process record for balance reporting>
-- =============================================
CREATE PROCEDURE [Workflow].[uspUpdateForm5500]
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
	@FilePath varchar(250) = null,
	@ErrorMessage varchar(250) = null,
	@ErrorDetail [dbo].[NOTE]= null,
    @SortOrder [dbo].[SORTORDER] = null,
    @UpdatedDateTime [dbo].[UPDATEDDATETIME],
    @UpdatedBy [dbo].[UPDATEDBY],
    @Note [dbo].[NOTE]= NULL,
    @ConsultantName varchar(50)=null,
	@ConsultantEMail VARCHAR(150)=null,
	@VerifiesAddress char(1)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [Workflow].[Form5500]
	   SET  [PlanName] = ISNULL(@PlanName,[PlanName])
		   ,[PlanNumber] = ISNULL(@PlanNumber,[PlanNumber])
		   ,[BusinessCode] = ISNULL(@BusinessCode,[BusinessCode])
		   ,[TotalParticipants] = ISNULL(@TotalParticipants,[TotalParticipants])
		   ,[TotalAssets] = ISNULL(@TotalAssets,[TotalAssets])
		   ,[FormDocType] = ISNULL(@FormDocType,[FormDocType])
		   ,[Status] = ISNULL(@Status,[Status])
		   ,[FilePath] = ISNULL(@FilePath,[FilePath])
		   ,[ErrorMessage] = ISNULL(@ErrorMessage,[ErrorMessage])
		   ,[ErrorDetail] = ISNULL(@ErrorDetail,[ErrorDetail])
		   ,[UpdatedBy] = @UpdatedBy
		   ,[Note] = ISNULL(@Note,[Note])
		   ,[ConsultantName] = ISNULL(@ConsultantName,[ConsultantName])
		   ,[ConsultantEMail] = ISNULL(@ConsultantEMail,[ConsultantEMail])
		   ,[VerifiesAddress] = ISNULL(@VerifiesAddress,[VerifiesAddress])
		   		  
		 WHERE EIN = @EIN
		 AND [FormSource] = @FormSource
		 AND FormYear = @FormYear

END


GO
