SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Business].[uspInsertSalesBilling]
 @CustomerID int,
 @BillingTypeID int,
 @BillingFrequencyID int,
 @BaseFee int = null,
 @TakeoverFee int = null,
 @TakeoverFeeWaived bit = null,
 @ParticipantFee int = null,
 @NonDeferredParticipantFee int = null,
 @InitialRevenue int = null,
 @AnnualRevenue int = null,
 @UserName varchar(50) = null
 

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		 
			INSERT INTO [Business].[Billing] (
				BillingTypeID,
				BillingFrequencyID,
				BaseFee,
				TakeoverFee,
				TakeoverFeeWaived,
				ParticipantFee,
				NonDeferredParticipantFee,
				InitialRevenue,
				AnnualRevenue,
				CreatedBy,
				CreatedDateTime,
				UpdatedBy,
				UpdatedDateTime
			)

			VALUES (
				 @BillingTypeID,
				 @BillingFrequencyID,
				 @BaseFee,
				 @TakeoverFee,
				 @TakeoverFeeWaived,
				 @ParticipantFee,
				 @NonDeferredParticipantFee,
				 @InitialRevenue,
				 @AnnualRevenue,
				 @UserName,
				 CURRENT_TIMESTAMP,
				 @UserName,
				 CURRENT_TIMESTAMP
			)
			
			DECLARE @billingID int = scope_identity()

			SELECT * FROM [Business].[Billing] WHERE billingID = @billingID
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
