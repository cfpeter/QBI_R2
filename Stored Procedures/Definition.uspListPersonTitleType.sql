SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <06/1/2017>
-- Description:	< list Person Title Type >
-- =============================================
CREATE PROCEDURE [Definition].[uspListPersonTitleType]  
AS
BEGIN
 
	SET NOCOUNT ON;
  
	SELECT * 
	
	FROM [Definition].[PersonTitleType]  
	 

END


GO
