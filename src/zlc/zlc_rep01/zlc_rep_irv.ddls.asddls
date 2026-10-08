@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Maintainence Item Report'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZLC_REP_IRV as select from zsd_app02_itb1
association to parent ZLC_REP_RV as _hdr
    on _hdr.Lnum = $projection.Lnum
{
    key lnum           as Lnum,
    key salesdocument  as Salesdocument,
    key lcline         as Lcline,

    @Semantics.amount.currencyCode: 'Lcurr'
    lcamount           as Lcamount,

    lcurr              as Lcurr,
    mark               as Mark,

    _hdr
}
