SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<update trustee phone>
-- =============================================
CREATE PROCEDURE [Business].[uspUpdateTrusteePhone]
	@trusteeID [int],
	@phoneTypeID [int] = NULL,
	@number [varchar](25) = NULL,
	@numberExt [varchar](10) = NULL,

	@notes [dbo].[NOTE] = 'updated trustee phone',

 	@userName [varchar](50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [Customer].[Phone] SET
				PhoneTypeID = @phoneTypeID,
				Number = @number,
				NumberExt = @numberExt,

				Note = @notes,
				CreatedBy = @username,
				CreatedDateTime = CURRENT_TIMESTAMP,
				UpdatedBy = @userName,
				UpdatedDateTime = CURRENT_TIMESTAMP
	WHERE PhoneID = (SELECT PhoneID FROM [Map].[TrusteePhoneMap] WHERE TrusteeID = @trusteeID)


END









GO
