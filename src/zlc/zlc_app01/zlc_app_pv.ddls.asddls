@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Letter Of Credit Projection View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZLC_APP_PV provider contract transactional_query as projection on ZLC_APP_RV
{
@EndUserText.label: 'LC Number'
    key Lnum,
@EndUserText.label: 'Validity From'
    Valfrm,
    @EndUserText.label: 'Validity From'
    Valto,
    @EndUserText.label: 'Validity To'
    Lcissdt,
    @EndUserText.label: 'Bank Name'
    Banknam,
    @EndUserText.label: 'Bank Branch'
    Bank_Branch,
    @EndUserText.label: 'Customer'
    Stp,
    @EndUserText.label: 'Customer Name'
    Stp_Name,
    @EndUserText.label: 'LC Expiry Date'
    Lc_Expdt,
    @EndUserText.label: 'LC Amount'
    @Semantics.amount.currencyCode: 'lc_curr'
    Lc_Amt,
    @EndUserText.label: 'LC Utilization'
    @Semantics.amount.currencyCode: 'lc_curr'
    Lc_Utilz,
    @EndUserText.label: 'Balance'
    @Semantics.amount.currencyCode: 'lc_curr'
    Tot_Balance,
    @EndUserText.label: 'Currency'
    Lc_Curr,
    @EndUserText.label: 'Created by'
    Createdby,
    @EndUserText.label: 'Created on'
    Createdon,
    @EndUserText.label: 'Last Changed by'
    Lastchangedby,
    @EndUserText.label: 'Last Changed on'
    Lastchangedon,
    @EndUserText.label: 'Status'
    Status,
    @Semantics.largeObject:{fileName: 'Filename' ,
                                mimeType: 'Minetype',
                                contentDispositionPreference: #INLINE  }
       Zattachment,
       @Semantics.mimeType: true
       Minetype,
       Filename,
        @EndUserText.label: 'Project'
       Project,
         @EndUserText.label: 'Applicant'
       Applicant,
         @EndUserText.label: 'Last Date of Dispatch'
       Ldd,      
         @EndUserText.label: 'BOE No'
       Boeno,
         @EndUserText.label: 'BOE Date'
       Boedt,
         @EndUserText.label: 'Due Date'
       Dudt,
      @Semantics.amount.currencyCode : 'Boecurr'
      @EndUserText.label: 'BOE Amount'
       Boeamt,
         @EndUserText.label: 'BOE Currency'
       Boecurr,
         @EndUserText.label: 'No of Days'
       Noofdays,
         @EndUserText.label: 'Status'
       Accbstus 
}
