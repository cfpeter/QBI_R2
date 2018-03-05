SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <03/13/2017>
-- Description:	<List all assistance per giver consultant>
-- =============================================
CREATE PROCEDURE [Employee].[uspListConsultantAssitance] 
	@ConsultantPersonID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	  SELECT [ConsultantAssistanceID]
		     ,c.CustomerID
			,c.[CRMClientID]
			,c.[CRMContactID]
		    ,p.*
			,p.FirstName + ' ' + p.LastName ContactFullName

	  FROM [Map].[ConsultantAssistance] cas
	  INNER JOIN [Customer].[Person] p ON cas.AssistancePersonID = p.PersonID
	   INNER JOIN [Customer].[Customer] c ON p.PersonID = c.PersonID
	  WHERE ConsultantPersonID = @ConsultantPersonID
	 AND c.[IsActive] = 1 AND cas.[IsActive] = 1

END


GO
