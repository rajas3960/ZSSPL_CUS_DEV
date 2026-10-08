@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TOTAL QUANTITY OF THE JOB CARD'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS01_TQTY as select from ZPP_APPS01_IRV02 as tqty
{
    key tqty.Uuid,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    sum(tqty.Menge )as toty,
    tqty.Meins
}
group by
tqty.Uuid,
tqty.Meins
