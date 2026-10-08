@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Master Maintainence B Line Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZLC_APP02_IV2 as select from zlc_app02_tb3
association to parent ZLC_APP02_RV as _Hdr on _Hdr.Lnum = $projection.Lnum
{
    key lnum as Lnum,
    key lcline as Lcline,
    @EndUserText.label: 'BOE No:'
    key boeno as Boeno,
    boedt as Boedt,
    dudt as Dudt,
     @Semantics.quantity.unitOfMeasure : 'Unit'
    boeqty as Boeqty,
    unit as Unit,
    @Semantics.amount.currencyCode: 'Boecurr'
    instdebt as Instdebt,
    @Semantics.amount.currencyCode: 'Boecurr'
    fright as Fright,
    @Semantics.amount.currencyCode: 'Boecurr'
    tboeamt as Tboeamt,
    @Semantics.amount.currencyCode: 'Boecurr'
    boeamt as Boeamt,
    boecurr as Boecurr,
    createdby as Createdby,
    createdon as Createdon,
    _Hdr
}
