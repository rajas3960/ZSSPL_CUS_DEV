@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Value'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_MAT_f4 as select from I_Product
{
    key Product
}where ProductGroup = 'PROJ'
