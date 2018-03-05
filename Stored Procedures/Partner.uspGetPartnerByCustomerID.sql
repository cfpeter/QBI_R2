SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <05/30/2017>
-- Description:	< get partner by id>
-- =============================================
CREATE PROCEDURE [Partner].[uspGetPartnerByCustomerID] 
	@CustomerID bigint
AS
BEGIN
 
	SET NOCOUNT ON;

  

	/*SELECT *
		FROM [Partner].[Partner] pp
			INNER JOIN [Map].[CustomerPartner] cpm on pp.PartnerID = cpm.PartnerID 
		
		WHERE cpm.CustomerID = @CustomerID*/
 

	 SELECT pp.* from [Map].[CustomerPartner] cpm 
			INNER JOIN [Partner].[Partner] pp on cpm.PartnerID = pp.PartnerID

	 WHERE CPM.CustomerID = @CustomerID

END


GO
