@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity Purchase Register'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }

define root view entity Z_MSME_REPORTS 
as select from I_JournalEntry                as JUE

left outer join  I_JournalEntryItem        as JUEI         on  JUEI.AccountingDocument = JUE.AccountingDocument
                                                           and JUEI.CompanyCode = JUE.CompanyCode
                                                           and JUEI.FiscalYear  = JUE.FiscalYear
                                                           and JUEI.FiscalPeriod =JUE.FiscalPeriod
                                                           and JUEI.SourceLedger       = '0L'
                                                           and JUEI.Ledger             =  '0L'
                                                           and JUEI.LedgerGLLineItem   =  '000001'
                                                      //     and JUEI.DebitCreditCode = 'H'
                                                     //     and (JUE.AccountingDocumentType =  'RE' or JUE.AccountingDocumentType = 'KZ'  )
                                              //                   and JUEI.DebitCreditCode = 'H'
                                                         and JUEI.TaxCode            <> ''
                                             //              AND JUEI.su
 left outer join  I_JournalEntryItem        as JUEI2         on  JUEI2.AccountingDocument = JUE.AccountingDocument
                                                           and JUEI2.CompanyCode = JUE.CompanyCode
                                                           and JUEI2.FiscalYear  = JUE.FiscalYear
                                                           and JUEI2.FiscalPeriod =JUE.FiscalPeriod
                                                           and JUEI2.SourceLedger       = '0L'
                                                           and JUEI2.Ledger             =  '0L'
                                                           and JUEI2.LedgerGLLineItem   =  '000002'                                          
 left outer join  I_Supplier                  as Supplier on Supplier.Supplier = JUEI2.Supplier  
                                                          and Supplier.SupplierLanguage = 'E'
                                                          
 left outer join  I_JournalEntryItem        as JUEI3         on  JUEI3.AccountingDocument = JUE.AccountingDocument
                                                           and JUEI3.CompanyCode = JUE.CompanyCode
                                                           and JUEI3.FiscalYear  = JUE.FiscalYear
                                                           and JUEI3.FiscalPeriod =JUE.FiscalPeriod
                                                           and JUEI3.SourceLedger       = '0L'
                                                           and JUEI3.Ledger             =  '0L'
                                                           and JUEI3.LedgerGLLineItem   =  '000002'
                                                       //    and JUEI3.LedgerGLLineItem   =  '000001'
                                                           and JUEI3.AccountingDocumentType = 'KZ'
// left outer join  I_MaterialDocumentItem_2  as   MDII   on MDII.MaterialDocument = JUEI.ReferenceDocument
                                                       //  and MDII.Material  = JUEI2.Material
                                                     //    and MDII.Supplier = JUEI.Supplier
left outer join I_OperationalAcctgDocItem    as ACI      on  ACI.AccountingDocument =  JUE.AccountingDocument
                                                              and ACI.FiscalYear         =  JUE.FiscalYear
                                                              and ACI.ProfitCenter       <> ''

left outer join I_MaterialDocumentItem_2    as MDI      on  MDI.MaterialDocument = substring(ACI.Reference3IDByBusinessPartner,5,10)
                                                        and MDI.MaterialDocumentItem = substring(ACI.Reference3IDByBusinessPartner,15,4)

                                                        
{   
    key JUEI2.Supplier           as AccCode,
    key JUE.AccountingDocument  as BillNo,
    JUE.FiscalYear              as FinancialYearFrom,
    JUE.FiscalYear              as FinancialYearTo,
    Supplier.BPSupplierFullName as NameofSupplier,
    Supplier.BusinessPartnerPanNumber as PANofSupplier,
    
     
    JUE.DocumentDate as BillDate,  
    
    case JUEI3.AccountingDocumentType when 'KZ' 
    then( JUEI3.NetDueDate ) else JUEI.NetDueDate
    end            as DueDate,
     
    JUEI2.GlobalCurrency     as GRCurrency,
    @Semantics.amount.currencyCode:       'GRCurrency'
    
    case JUEI3.AccountingDocumentType when 'KZ' 
    then( JUEI3.AmountInCompanyCodeCurrency ) else 
    JUEI.AmountInCompanyCodeCurrency * -1  
    end    as AmountDue,
    
    
    case JUEI3.AccountingDocumentType when 'KZ' 
    then( JUEI3.NetDueDate ) else JUEI.NetDueDate
    end as SpecifyDueDate,
    
    case JUEI3.AccountingDocumentType when 'KZ' 
    then( JUEI3.ClearingDate ) else JUEI.ClearingDate
    end as DateofPayment,
     
    @Semantics.durationInDays: true
    cast( dats_days_between( JUE.DocumentDate , JUEI.NetDueDate ) as abap.int4 )  as REdays,
    MDI.DocumentDate            as GRNDate
}

where ( JUE.AccountingDocumentType = 'RE' or JUE.AccountingDocumentType = 'KZ')
