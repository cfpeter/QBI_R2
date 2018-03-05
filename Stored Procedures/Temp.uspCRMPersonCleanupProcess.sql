SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <10/24/2016>
-- Description:	<Delete perso information for CRM client>
-- =============================================
CREATE PROCEDURE [Temp].[uspCRMPersonCleanupProcess] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY

--Protect against simultaneous access
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

	BEGIN TRANSACTION

			DECLARE @NewPersonID int
			DECLARE @PersonIterator int

			--ALTER TABLE [Customer].[Customer] DROP CONSTRAINT [FK_Customer_Person]
			ALTER TABLE [Map].[PersonAddress] DROP CONSTRAINT [FK_PersonAddress_Person]
			ALTER TABLE [Map].[PersonAddress] DROP CONSTRAINT [FK_PersonAddress_Address]

			DECLARE Person_CURSOR CURSOR FOR 
			SELECT PersonID
			FROM [Customer].[Person]
			WHERE PersonID IN (select cust.PersonID from [Customer].[Customer] cust 
																				inner join [Customer].[Person] p on cust.PersonID = p.PersonID
																				Where cust.CRMClientID is not null )
	
			--Open cursor
			OPEN Person_CURSOR


			--Loop through all OrganizationBranch IDs to be cloned
			FETCH NEXT FROM Person_CURSOR --Get first row
			INTO @NewPersonID
		

			WHILE @@FETCH_STATUS = 0
			BEGIN
		
			--increment counter
				SET @PersonIterator = @PersonIterator + 1
			
				Print 'Person ID'
				Print @NewPersonID

				DELETE FROM [Customer].[Address] where AddressID in (SELECT AddressID from [Map].[PersonAddress] WHERE PersonID =  @NewPersonID )
			
				DELETE FROM [Map].[PersonAddress] where PersonID =  @NewPersonID
				
				DELETE FROM [Customer].[Phone] Where PersonID = @NewPersonID
				
				DELETE FROM [Customer].[Person] Where PersonID = @NewPersonID

				--Get next row
				FETCH NEXT FROM Person_CURSOR
				INTO @NewPersonID

			END
					
		--Close cursor
		CLOSE Person_CURSOR
		DEALLOCATE Person_CURSOR

		ALTER TABLE [Map].[PersonAddress]  WITH CHECK ADD  CONSTRAINT [FK_PersonAddress_Person] FOREIGN KEY([PersonID])
		REFERENCES [Customer].[Person] ([PersonID])
		ALTER TABLE [Map].[PersonAddress] CHECK CONSTRAINT [FK_PersonAddress_Person]


		ALTER TABLE [Map].[PersonAddress]  WITH CHECK ADD  CONSTRAINT [FK_PersonAddress_Address] FOREIGN KEY([AddressID])
		REFERENCES [Customer].[Address] ([AddressID])
		ALTER TABLE [Map].[PersonAddress] CHECK CONSTRAINT [FK_PersonAddress_Address]


		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION

		CLOSE Person_CURSOR
		DEALLOCATE Person_CURSOR		
		
		--Throw an error
		execute uspRethrowError

	END CATCH

END




GO
