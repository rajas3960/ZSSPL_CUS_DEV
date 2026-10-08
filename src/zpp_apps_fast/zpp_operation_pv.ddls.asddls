@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Operation Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_OPERATION_PV as projection on ZPP_OPERATION_RV
{
    key Uuid,
    key Process,
    Machine,
    processno,
    _hdr :  redirected to parent ZPP_APPS01_PV01
}
