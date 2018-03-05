SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak	Avakian	>
-- Create date: <07/08/2016>
-- Description:	<Get investment vendors by given ID>
-- =============================================
CREATE PROCEDURE [Business].[uspGetInvestmentVendor]
	@InvestmentVendorID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM [Definition].[InvestmentVendor]
	Where InvestmentVendorID = @InvestmentVendorID
END





GO
