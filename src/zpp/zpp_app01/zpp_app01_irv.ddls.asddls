@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage Production Order Application Item Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP01_IRV as select from zpp_app01_itb1
association to parent ZPP_APP01_HRV as _Mhdr on $projection.Uuid = _Mhdr.Uuid
{
    key uuid as Uuid,
    key sno as Sno,
    ccode as Ccode,
    plant as Plant,
    fgproduct as Fgproduct,
    bomid as Bomid,
    component as Component,
    bomvar as Bomvar,
    bomitmnode as Bomitmnode,
    bomintchgcnt as Bomintchgcnt,
    bomver as Bomver,
    bomcat as Bomcat,
    componentdescription as Componentdescription,
    @Semantics.quantity.unitOfMeasure: 'Componentuom'
    componentquantity as Componentquantity,
    componentuom as Componentuom,
    manuford as Manuford,
    _Mhdr
}
