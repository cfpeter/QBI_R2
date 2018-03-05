SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <09/11/2017>
-- Description:	<Insert Kronos users to temp table>
-- =============================================
CREATE PROCEDURE [Temp].[uspInsertOrUpdateKronosQBIClient] 
	 @AccountID INT 
    ,@CompanyID int
    ,@EmployeeID VARCHAR(15)
    ,@AccountStatus VARCHAR(50)
    ,@CompanyName VARCHAR(150)
    ,@CompanyShortName VARCHAR(50)
    ,@CompanyType VARCHAR(25)
    ,@EIN VARCHAR(50)
    ,@Created DATETIME
    ,@Email VARCHAR(150) = null
    ,@ExternalID INT = null
    ,@FirstName VARCHAR(50)
    ,@LastName VARCHAR(50)
    ,@Locked VARCHAR(3)
    ,@SecurityProfile VARCHAR(150)
    ,@Username VARCHAR(50)
    ,@ImportedAsQBIClient BIT = null
	,@CreatedBy VARCHAR(50)
    ,@UpdatedDateTime DATETIME
    ,@UpdatedBy VARCHAR(50)
    ,@Note TEXT = null
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AccountCount INT = (SELECT COUNT(@AccountID) FROM [Temp].[KronosQBIClient] WHERE AccountID = @AccountID)

    -- Insert statements for procedure here
	IF( @AccountCount = 0 )
	BEGIN
	INSERT INTO [Temp].[KronosQBIClient]
           ([AccountID]
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
           ,[Note])
     VALUES
           (@AccountID
           ,@CompanyID
           ,@EmployeeID
           ,@AccountStatus
           ,@CompanyName
           ,@CompanyShortName
           ,@CompanyType
           ,@EIN
           ,@Created
           ,@Email
           ,@ExternalID
           ,@FirstName
           ,@LastName
           ,@Locked
           ,@SecurityProfile
           ,@Username
           ,@ImportedAsQBIClient
           ,CURRENT_TIMESTAMP
           ,@CreatedBy
           ,@UpdatedDateTime
           ,@UpdatedBy
           ,@Note)
		END
		ELSE
		BEGIN
			UPDATE [Temp].[KronosQBIClient]
			   SET 
				   [CompanyID] = @CompanyID
				  ,[EmployeeID] = @EmployeeID
				  ,[AccountStatus] = @AccountStatus
				  ,[CompanyName] = @CompanyName
				  ,[CompanyShortName] = @CompanyShortName
				  ,[CompanyType] = @CompanyType
				  ,[EIN] = @EIN
				  ,[Created] = @Created
				  ,[Email] = @Email
				  ,[ExternalID] = @ExternalID
				  ,[FirstName] = @FirstName
				  ,[LastName] = @LastName
				  ,[Locked] = @Locked
				  ,[SecurityProfile] = @SecurityProfile
				  ,[Username] = @Username
				  ,[ImportedAsQBIClient] = @ImportedAsQBIClient
				  ,[UpdatedDateTime] = CURRENT_TIMESTAMP
				  ,[UpdatedBy] = @UpdatedBy
				  ,[Note] = @Note
			 WHERE AccountID = @AccountID
		END



END




GO
