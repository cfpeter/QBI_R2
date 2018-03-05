SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <12/27/2016>
-- Description:	<Update customer date time and username during update process for related tables>
-- =============================================
CREATE PROCEDURE [Customer].[uspUpdateCustomerDateAndUser]
	@CustomerID bigint,
	@UpdatedBy varchar(50),
	@UpdatedDateTime datetime,
	@Note [NOTE] = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Customer].[Customer]
	SET UpdatedBy = @UpdatedBy, 
		UpdatedDateTime = @UpdatedDateTime,
		Note = IsNull(@Note, Note)
	WHERE CustomerID = @CustomerID
END







GO
