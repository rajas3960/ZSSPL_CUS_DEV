@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Operation Root View'
@Metadata.ignorePropagatedAnnotations: true
@UI.presentationVariant: [{ sortOrder: [{by: 'processno' , direction: #ASC}] }]
define view entity ZPP_OPERATION_RV as select from zpp_operation_db
association to parent ZPP_APPS01_RE as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key process as Process,
    processno,
    machine as Machine,
    _hdr
}
