SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Security].[uspInsertEmployeeSignup]
	

	 @customerID int
	,@userName varchar(50) 
	,@passCode varchar(250)
	,@salt varchar(250)
	--,@domainGroupMapID int

	

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		
		DECLARE @insertType varchar(50)		=  'Employee Signup'
		DECLARE @CreatedUpdateDateTime datetime = CURRENT_TIMESTAMP

				INSERT INTO [Customer].[Login]
					   (
							[CustomerID],
							[UserName],   
							[PassCode],
							[salt],
							[IsActive],
						 	[CreatedBy],
							[CreatedDateTime],
						  	[UpdatedBy],
							[UpdatedDateTime],
							[Note]
					   )
          
				 VALUES
					   (
							@CustomerID,
							@userName,         
							@passCode,
							@salt,
							1,
							@userName ,
							@CreatedUpdateDateTime,
						 	@userName,
							@CreatedUpdateDateTime,
							@insertType
					   )

				 DECLARE @loginID int = scope_identity()


				 DECLARE @authType  varchar(50) = 'Basic'
				 DECLARE @domainName varchar(50)	= (SELECT dgm.Name FROM map.DomainGroupMap dgm where dgm.Name = 'Pension Consultant' )
				 DECLARE @domainGroupMapID int		= (SELECT dgm.DomainGroupMapID FROM map.DomainGroupMap dgm where dgm.Name = 'Pension Consultant' )
				 

				INSERT INTO [Map].[LoginMap]
					(
						LoginID,
						DomainGroupMapID,
						AuthenticationTypeID,
						[IsActive],
						[Description],
						[CreatedBy],
						[CreatedDateTime],
						[UpdatedBy],
						[UpdatedDateTime],
						[Note]
					)
					VALUES
					(
						@loginID,
						@domainGroupMapID, --TODO: need to change later on!!
						1,--Basic
						1,-- Active
						@userName + ' | ' + @domainName + ' | ' + @authType,
						@userName ,
						@CreatedUpdateDateTime,
						@userName,
						@CreatedUpdateDateTime,
						@insertType
					)
								
		COMMIT
	
	 END TRY
	 BEGIN CATCH
		if(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			exec dbo.uspRethrowError
		END
	 END CATCH
END





GO
