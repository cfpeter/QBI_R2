SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <12/27/2016>
-- Description:	<Update customer date time and username during update process for related tables>
-- =============================================
CREATE PROCEDURE [Customer].[uspUpdateCustomerPerson]
	@CustomerID bigint,
	@PersonID bigint = null,
	@IsPrimary bit = 1,
	@CRMClientID int = null,
	@crmContactID  int = null,
	@MainClient bit = 1,
	@UpdatedBy varchar(50),
	@UpdatedDateTime datetime,
	@Note [NOTE] = null--'Customer person information updated'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	UPDATE [Customer].[Customer]
	SET PersonID		= @PersonID, 
		IsPrimary		= @IsPrimary,  
		CRMClientID		= @CRMClientID,
		CRMContactID	= @crmContactID,
		MainClient		= @MainClient,
		UpdatedBy		= @UpdatedBy, 
		UpdatedDateTime = @UpdatedDateTime,
		Note			= IsNull(@Note, Note)
	WHERE CustomerID	= @CustomerID
	
	
	
	--if(@CRMClientID IS NOT NULL)
		--BEGIN
			SELECT *
			FROM [Customer].[Customer] c
			INNER JOIN [Customer].[Person] p on c.PersonID = p.PersonID
				
			WHERE CustomerID = @CustomerID
	--	END
	
END
GO
