SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <06/21/2017> 
-- Description:	<list contacts by organization branchID>
-- =============================================
CREATE PROCEDURE [Contact].[uspListContactByOrganizationBranchID]
	@OrganizationBranchID bigint
AS
BEGIN

	 
	SET NOCOUNT ON;

    SELECT p.*  
	,ph.PhoneID AS PhoneNumberID, ph.Number as PhoneNumber, ph.PhoneTypeID
	, c.IsPrimary , c.MainClient

	 from [Customer].[Person] p
	LEFT JOIN [Customer].[Customer] c on p.PersonID = c.PersonID
	LEFT JOIN [Map].[PersonPhoneMap] ppm on p.PersonID = ppm.PersonID
	LEFT JOIN [Customer].[Phone] ph	ON ppm.PhoneID = ph.PhoneID

	WHERE OrganizationBranchID = @OrganizationBranchID
	
END


GO
