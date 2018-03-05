SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <2/24/2017>
-- Description:	<Delete address by addressID>
-- =============================================
CREATE PROCEDURE [Common].[uspDeleteAddress] 
	@AddressID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [Customer].[Address]
	WHERE AddressID = @AddressID
END


GO
