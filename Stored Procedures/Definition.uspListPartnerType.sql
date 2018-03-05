SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <05/31/2017>
-- Description:	< list partner type >
-- =============================================
CREATE PROCEDURE [Definition].[uspListPartnerType]  
AS
BEGIN
 
	SET NOCOUNT ON;
  
	SELECT * 
	
	FROM [Definition].[PartnerType]  
	
	WHERE IsActive = 1

END


GO
