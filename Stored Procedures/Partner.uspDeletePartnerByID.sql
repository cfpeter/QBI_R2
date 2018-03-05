SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <9/21/2017>
-- Description:	<delte partner >
-- =============================================
CREATE PROCEDURE [Partner].[uspDeletePartnerByID]
	@PartnerID bigint
AS
BEGIN
	 
	 DELETE FROM [Map].[CustomerPartner]
		WHERE PartnerID = @PartnerID

	 DELETE from [Partner].[Partner] 
		WHERE PartnerID = @PartnerID

		
END


GO
