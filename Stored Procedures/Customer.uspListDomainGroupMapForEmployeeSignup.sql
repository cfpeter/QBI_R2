SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <11/8/2016>
-- Description:	< get only the domain for the employee signup to choose a department from a dropdown list >
-- =============================================
CREATE PROCEDURE  [Customer].[uspListDomainGroupMapForEmployeeSignup]
AS
BEGIN
	SET NOCOUNT ON;

	select 
	 DomainGroupMapID ,
	 DomainGroupID ,
	 DomainGroupOverrideID ,
	 Name
	    from map.DomainGroupMap  
	WHERE DomainGroupMapID in ( 8,10,11,12 )   
END









GO
