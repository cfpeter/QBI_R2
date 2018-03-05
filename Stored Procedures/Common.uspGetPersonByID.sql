SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <06/06/2017>
-- Description:	<Get person table by person ID>
-- =============================================
CREATE PROCEDURE [Common].[uspGetPersonByID] 
	@PersonID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.*
		  ,cp.PhoneID PrimaryPhoneID
		  ,cp.PhoneTypeID PrimaryPhoneTypeID
		  ,cp.Number PrimaryPhoneNumber
		  ,pt.Name PrimaryPhoneTypeName
		 
	FROM [Customer].[Person] p
	LEFT JOIN [Customer].[Phone] cp ON p.PersonID = cp.PersonID AND cp.IsPrimary = 1
	LEFT JOIN [Definition].[PhoneType] pt ON cp.PhoneTypeID = pt.PhoneTypeID
	
	WHERE p.PersonID = @PersonID

END


GO
