SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <02/09/2016>
-- Description:	<Get Current supervisor for given customer>
-- =============================================
CREATE PROCEDURE [Business].[uspGetCustomerSupervisor] 
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [CustomerSupervisorMapID]
		  ,[CustomerID]
		  ,[Supervisor_PersonID]
		  ,[Description]
		  ,[IsActive]
		  ,[CreatedDateTime]
		  ,[CreatedBy]
		  ,[UpdatedDateTime]
		  ,[UpdatedBy]
	  FROM [Map].[CustomerSupervisorMap]
	  WHERE [CustomerID] = @CustomerID
	  AND IsActive = 1
END






GO
