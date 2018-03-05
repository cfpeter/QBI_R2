SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Security].[uspInsertSignup_delete]
@crmContactID int,
@userName varchar(50),
@passCode varchar(250),
@salt varchar(250),
@question varchar(50),
@answer varchar(50),
@createdBy varchar(50),
@updatedBy varchar(50)

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		DECLARE @loginID int
		DECLARE @CreatedUpdateDateTime datetime = CURRENT_TIMESTAMP

			INSERT INTO [Customer].[Login]
					   (
							[UserName],   
							[PassCode],
							[salt],
							[IsActive],
							[CreatedBy],
							[CreatedDateTime],
							[UpdatedBy],
							[UpdatedDateTime]
					   )
          
				 VALUES
					   (
							@userName,         
							@passCode,
							@salt,
							'true',
							@createdBy,
							@CreatedUpdateDateTime,
							@updatedBy,
							@CreatedUpdateDateTime
					   )

		 SET @loginID = scope_identity()
				INSERT INTO [Security].[securityQA]
				   (
					
					    [Question],
					    [Answer],
						[CreatedBy],
						[CreatedDateTime],
						[UpdatedBy],
						[UpdatedDateTime]

				   )
				 VALUES
				   (
						@question,
					    @answer,
						@createdBy,
						@CreatedUpdateDateTime,
						@updatedBy,
						@CreatedUpdateDateTime
				   )

				

				INSERT INTO [Customer].[Customer]
						(
						    [CRMContactID],
						    [CustomerTypeID],
						    [StatusGroupMapID],
							[IsActive],
						    [CreatedBy],
							[CreatedDateTime],
							[UpdatedBy],
							[UpdatedDateTime]
					 
						)
						VALUES
						(
							@crmContactID,
							4,
						    1,
							'true',
							@createdBy,
							@CreatedUpdateDateTime,
							@updatedBy,
							@CreatedUpdateDateTime
						)

				INSERT INTO [Map].[LoginMap]
					(
						LoginID,
						DomainGroupMapID,
						AuthenticationTypeID,
						[IsActive],
						[CreatedBy],
						[CreatedDateTime],
						[UpdatedBy],
						[UpdatedDateTime]
					)
					VALUES
					(
						@loginID,
						7,
						1,
						'true',
						@createdBy,
						@CreatedUpdateDateTime,
						@updatedBy,
						@CreatedUpdateDateTime
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
