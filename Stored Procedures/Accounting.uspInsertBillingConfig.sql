SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Accounting].[uspInsertBillingConfig]
 @UserName varchar(50),
 @CustomerID int,
 @BillingTypeID int,
 @BillingFrequencyID int,
 @StartDate date = null,
 @BaseFee int,
 @TakeoverFeeWaived bit,
 @TakeoverFee int = null,
 @DeferredParticipantFee int,
 @AnyNonDeferredParticipants bit,
 @NonDeferredParticipantFee int = null,
 @InitialRevenue int,
 @AnnualRevenue int,
 @BillingConfigID int out
 

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		 
			INSERT INTO [Accounting].[BillingConfig] (
				BillingTypeID,
				BillingFrequencyID,
				BaseFee,
				StartDate,
				TakeoverFeeWaived,
				TakeoverFee,
				DeferredParticipantFee,
				AnyNonDeferredParticipants,
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
				 @StartDate,
				 @TakeoverFeeWaived,
				 @TakeoverFee,
				 @DeferredParticipantFee,
				 @AnyNonDeferredParticipants,
				 @NonDeferredParticipantFee,
				 @InitialRevenue,
				 @AnnualRevenue,
				 @UserName,
				 CURRENT_TIMESTAMP,
				 @UserName,
				 CURRENT_TIMESTAMP
			);
			
			SET @BillingConfigID = scope_identity();

		COMMIT
		
		RETURN @BillingConfigID;
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
