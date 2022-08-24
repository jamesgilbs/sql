WITH cte AS (
    SELECT
        [PurchaseOrderNumber]
      ,[PurchaseCreatedOn]
      ,[ReleaseCode]
      ,[NameReleaseCode]
      ,[CompanyCode]
      ,[CompanyName]
      ,[CountryName]
      ,[Region]
      ,[Cluster]
      ,[SupplierCode]
      ,[SupplierName]
      ,[SupplierL1]
      ,[SupplierL2]
      ,[SupplierMultipleCategorization]
      ,[ItemNumberPurchasingDoc]
      ,[MaterialCode]
      ,[MaterialName]
      ,[MaterialGroup]
      ,[MaterialQty]
      ,[MaterialUnit]
      ,[InvoiceDocNumber]
      ,[PostingDate]
      ,[InvoiceDocFiscalYear]
      ,[PurchaseNegotiatedCurrency]
      ,[CompanyCurrencyKey]
      ,[AccountDocumentNumber]
      ,[PaymentStatus]
      ,[PaymentDate]
      ,[GrossSpendLocalCurrency]
      ,[GrossSpendBRLStandard]
      ,[GrossSpendGBPStandard]
      ,[GrossSpendUSDStandard]
      ,[NetSpendLocalCurrency]
      ,[NetSpendBRLStandard]
      ,[NetSpendGBPStandard]
      ,[NetSpendUSDStandard]
      ,[TaxSpendLocalCurrency]
      ,[TaxSpendBRLStandard]
      ,[TaxSpendGBPStandard]
      ,[TaxSpendUSDStandard],
        ROW_NUMBER() OVER (
            PARTITION BY
                [PurchaseOrderNumber]
      ,[PurchaseCreatedOn]
      ,[ReleaseCode]
      ,[NameReleaseCode]
      ,[CompanyCode]
      ,[CompanyName]
      ,[CountryName]
      ,[Region]
      ,[Cluster]
      ,[SupplierCode]
      ,[SupplierName]
      ,[SupplierL1]
      ,[SupplierL2]
      ,[SupplierMultipleCategorization]
      ,[ItemNumberPurchasingDoc]
      ,[MaterialCode]
      ,[MaterialName]
      ,[MaterialGroup]
      ,[MaterialQty]
      ,[MaterialUnit]
      ,[InvoiceDocNumber]
      ,[PostingDate]
      ,[InvoiceDocFiscalYear]
      ,[PurchaseNegotiatedCurrency]
      ,[CompanyCurrencyKey]
      ,[AccountDocumentNumber]
      ,[PaymentStatus]
      ,[PaymentDate]
      ,[GrossSpendLocalCurrency]
      ,[GrossSpendBRLStandard]
      ,[GrossSpendGBPStandard]
      ,[GrossSpendUSDStandard]
      ,[NetSpendLocalCurrency]
      ,[NetSpendBRLStandard]
      ,[NetSpendGBPStandard]
      ,[NetSpendUSDStandard]
      ,[TaxSpendLocalCurrency]
      ,[TaxSpendBRLStandard]
      ,[TaxSpendGBPStandard]
      ,[TaxSpendUSDStandard]
            ORDER BY
            [PurchaseOrderNumber]
      ,[PurchaseCreatedOn]
      ,[ReleaseCode]
      ,[NameReleaseCode]
      ,[CompanyCode]
      ,[CompanyName]
      ,[CountryName]
      ,[Region]
      ,[Cluster]
      ,[SupplierCode]
      ,[SupplierName]
      ,[SupplierL1]
      ,[SupplierL2]
      ,[SupplierMultipleCategorization]
      ,[ItemNumberPurchasingDoc]
      ,[MaterialCode]
      ,[MaterialName]
      ,[MaterialGroup]
      ,[MaterialQty]
      ,[MaterialUnit]
      ,[InvoiceDocNumber]
      ,[PostingDate]
      ,[InvoiceDocFiscalYear]
      ,[PurchaseNegotiatedCurrency]
      ,[CompanyCurrencyKey]
      ,[AccountDocumentNumber]
      ,[PaymentStatus]
      ,[PaymentDate]
      ,[GrossSpendLocalCurrency]
      ,[GrossSpendBRLStandard]
      ,[GrossSpendGBPStandard]
      ,[GrossSpendUSDStandard]
      ,[NetSpendLocalCurrency]
      ,[NetSpendBRLStandard]
      ,[NetSpendGBPStandard]
      ,[NetSpendUSDStandard]
      ,[TaxSpendLocalCurrency]
      ,[TaxSpendBRLStandard]
      ,[TaxSpendGBPStandard]
      ,[TaxSpendUSDStandard]
        ) row_num
     FROM
        [Base].[dbo].[temp_spend_directs_sap]
)
SELECT
    *
FROM    cte
WHERE   row_num >= 2
ORDER BY 1