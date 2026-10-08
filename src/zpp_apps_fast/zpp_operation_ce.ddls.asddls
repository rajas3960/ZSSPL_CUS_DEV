@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Entity For Process'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_OPERATION_CE as select from ZPP_OPERATION_RV
{
    key Uuid,
    key Process,
    processno,
    Machine
}
