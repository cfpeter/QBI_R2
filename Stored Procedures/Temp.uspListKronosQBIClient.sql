SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <09/20/2017>
-- Description:	<List all Kronos in temp>
-- =============================================
CREATE PROCEDURE [Temp].[uspListKronosQBIClient] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [KronosQBIClientID]
      ,[AccountID]
      ,[CompanyID]
      ,[EmployeeID]
      ,[AccountStatus]
      ,[CompanyName]
      ,[CompanyShortName]
      ,[CompanyType]
      ,[EIN]
      ,[Created]
      ,[Email]
      ,[ExternalID]
      ,[FirstName]
      ,[LastName]
      ,[Locked]
      ,[SecurityProfile]
      ,[Username]
      ,[ImportedAsQBIClient]
      ,[CreateDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[Note]
  FROM [Temp].[KronosQBIClient]
END




GO
