@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order LC Utilization Amount Application Item Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_APP02_IRV
  as select from zsd_app02_itb1
  association to parent ZSD_APP02_HRV as _SalesHeader on $projection.Salesdocument = _SalesHeader.SalesDocument
{
  key salesdocument as Salesdocument,
  key lcline        as Lcline,
      lnum          as Lnum,
      @Semantics.amount.currencyCode: 'Lcurr'
      lcamount      as Lcamount,
      lcurr         as Lcurr,
      mark          as Mark,
       @Semantics.user.createdBy: true
      createdby     as Createdby,
       @Semantics.systemDateTime.createdAt: true
      createdon     as Createdon,
      @Semantics.user.lastChangedBy: true
      lastchangedbyuser  as Lastchangedbyuser,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedatetime as Lastchangedatetime,
      _SalesHeader
}
