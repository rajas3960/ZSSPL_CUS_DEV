@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Batch Value Help'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_BATCH_F4 as select from ZPP_BATCH_DETAILS
{
    key Product as matnr,
    key Batch,
    Totqty as Totqt,
    sbatch as mat
    
}where Totqty is not initial
