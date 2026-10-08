@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Maintainence Item Report'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
define view entity ZLC_REP_IPV 
as projection on ZLC_REP_IRV
{
    key Lnum,
    key Salesdocument,
    key Lcline,

    @Semantics.amount.currencyCode: 'Lcurr'
    Lcamount,

    Lcurr,

    _hdr : redirected to parent ZLC_REP_PV
}
