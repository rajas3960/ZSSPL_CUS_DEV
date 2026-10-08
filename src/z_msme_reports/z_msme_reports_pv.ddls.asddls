@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MSME REPORTS Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }
define root view entity Z_MSME_REPORTS_PV 
as select from Z_MSME_REPORTS
{   
    key AccCode,
    key BillNo,
    FinancialYearFrom,
    FinancialYearTo,
    NameofSupplier,
    PANofSupplier,
     BillDate,
     DueDate,
     GRCurrency,
     @Semantics.amount.currencyCode:       'GRCurrency'
      
      AmountDue,
      SpecifyDueDate,
      DateofPayment,
      @Semantics.durationInDays: true
       REdays,
      GRNDate
}
