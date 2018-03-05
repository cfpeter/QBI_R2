SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:    <Hamlet Tamazian>
-- Create date: <10/2/2017>
-- Description: <get address information by Customer ID>
-- =============================================
CREATE PROCEDURE [Common].[uspGetPrimaryAddressByCustomerID]
  @customerID int
AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.
  SET NOCOUNT ON;

    -- Insert statements for procedure here
  SELECT ad.*, pa.IsPrimary, st.Code, st.Name StateName, adt.Name AddressTypeName
  FROM [Customer].[Address]  ad 
  INNER JOIN [Map].[PersonAddress] pa on ad.AddressID = pa.AddressID
  INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
  INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
  WHERE pa.PersonID = (SELECT PersonID FROM [Customer].[Customer] WHERE customerID =  @customerID )
  AND pa.IsPrimary = 1
END





GO
