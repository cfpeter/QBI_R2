SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <10/24/2016>
-- Description:	<Organization and organization branch cleanup process for CRM clients>
-- =============================================
CREATE PROCEDURE [Temp].[uspCRMOrganizationCleanUpProcess]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY

--Protect against simultaneous access
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

	BEGIN TRANSACTION

			DECLARE @OrganizationID int
			DECLARE @NewOrganizationBranchID int
			DECLARE @OrganizationBranchIterator int

			

			ALTER TABLE [Map].[OrganizationBranchAddress] DROP CONSTRAINT [FK_OrganizationBranchAddress_OrganizationBranch]
			ALTER TABLE [Customer].[OrganizationBranch] DROP CONSTRAINT [FK_OrganizationBranch_Organization]
			ALTER TABLE [Customer].[Person] DROP CONSTRAINT [FK_Person_OrganizationBranch]
			ALTER TABLE [Map].[OrganizationBranchAddress] DROP CONSTRAINT [FK_OrganizationBranchAddress_Address]

			
			DECLARE OrganizationBranch_CURSOR CURSOR FOR 
			SELECT OrganizationBranchID
			FROM [Customer].[OrganizationBranch]
			WHERE OrganizationBranchID IN (select orgb.OrganizationBranchID from [Customer].[OrganizationBranch] orgb 
																				inner join [Customer].[Person] p on orgb.OrganizationBranchID = p.OrganizationBranchID
																				inner join [Customer].[Customer] cust on p.PersonID = cust.PersonID
																				Where cust.CRMClientID is not null and cust.MainClient = 1)
	
			--Open cursor
			OPEN OrganizationBranch_CURSOR


			--Loop through all OrganizationBranch IDs to be cloned
			FETCH NEXT FROM OrganizationBranch_CURSOR --Get first row
			INTO @NewOrganizationBranchID
		

			WHILE @@FETCH_STATUS = 0
			BEGIN
		
			--increment counter
				SET @OrganizationBranchIterator = @OrganizationBranchIterator + 1
			
				Print 'Organization Branch ID'
				Print @NewOrganizationBranchID
			
				SET @OrganizationID = (SELECT OrganizationID FROM [Customer].[OrganizationBranch] WHERE OrganizationBranchID = @NewOrganizationBranchID )
			
				Print 'Organization ID'
				Print @NewOrganizationBranchID

				DELETE FROM [Customer].[Address] where AddressID in (SELECT AddressID from [Map].[OrganizationBranchAddress] WHERE OrganizationBranchID =  @NewOrganizationBranchID )
			
				DELETE FROM [Map].[OrganizationBranchAddress] where OrganizationBranchID =  @NewOrganizationBranchID
				
				
				DELETE FROM [Customer].OrganizationBranch WHERE OrganizationBranchID = @NewOrganizationBranchID

				DELETE FROM [Customer].[Organization] WHERE OrganizationID = @OrganizationID



				--Get next row
				FETCH NEXT FROM OrganizationBranch_CURSOR
				INTO @NewOrganizationBranchID

			END
					
		--Close cursor
		CLOSE OrganizationBranch_CURSOR
		DEALLOCATE OrganizationBranch_CURSOR

		ALTER TABLE [Map].[OrganizationBranchAddress]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationBranchAddress_Address] FOREIGN KEY([AddressID])
		REFERENCES [Customer].[Address] ([AddressID])
		ALTER TABLE [Map].[OrganizationBranchAddress] CHECK CONSTRAINT [FK_OrganizationBranchAddress_Address]


		ALTER TABLE [Map].[OrganizationBranchAddress]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationBranchAddress_OrganizationBranch] FOREIGN KEY([OrganizationBranchID])
		REFERENCES [Customer].[OrganizationBranch] ([OrganizationBranchID])
		ALTER TABLE [Map].[OrganizationBranchAddress] CHECK CONSTRAINT [FK_OrganizationBranchAddress_OrganizationBranch]

		ALTER TABLE [Customer].[OrganizationBranch]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationBranch_Organization] FOREIGN KEY([OrganizationID])
		REFERENCES [Customer].[Organization] ([OrganizationID])
		ALTER TABLE [Customer].[OrganizationBranch] CHECK CONSTRAINT [FK_OrganizationBranch_Organization]


		/*ALTER TABLE [Customer].[Person]  ADD  CONSTRAINT [FK_Person_OrganizationBranch] FOREIGN KEY([OrganizationBranchID])
		REFERENCES [Customer].[OrganizationBranch] ([OrganizationBranchID])
		ALTER TABLE [Customer].[Person] CHECK CONSTRAINT [FK_Person_OrganizationBranch]*/
		
		


		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION

		CLOSE OrganizationBranch_CURSOR
		DEALLOCATE OrganizationBranch_CURSOR		
		
		--Throw an error
		execute uspRethrowError

	END CATCH

END




GO
