SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <09/20/2017>
-- Description:	<List all Kronos managers from temp that haven't been invited yet>

-- =============================================
CREATE PROCEDURE [Temp].[uspListKronosManagersNoInvite] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [KronosQBIClientID]
      ,kqc.[AccountID]
      ,kqc.[CompanyID]
      ,[EmployeeID]
      ,[AccountStatus]
      ,[CompanyName]
      ,[CompanyShortName]
      ,[CompanyType]
      ,[EIN]
      ,[Created]
      ,[Email]
      ,kqc.[ExternalID]
      ,[FirstName]
      ,[LastName]
      ,[Locked]
      ,[SecurityProfile]
      ,[Username]
      ,[ImportedAsQBIClient]
      ,kqc.[CreateDateTime]
      ,kqc.[CreatedBy]
      ,kqc.[UpdatedDateTime]
      ,kqc.[UpdatedBy]
      ,kqc.[Note]
  FROM [Temp].[KronosQBIClient] kqc
  LEFT JOIN [Map].[ThirdPartyProviderMap] tppm ON tppm.AccountID = kqc.AccountID 
  WHERE tppm.AccountID is null
  AND SecurityProfile <> 'Employee'
 -- AND kqc.SendInvitation = 'true'
  AND kqc.Email <> 'NULL'
  AND kqc.Locked = 'No'
   
END




GO
