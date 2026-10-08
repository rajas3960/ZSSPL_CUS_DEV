@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Max date of material'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zmm_Maxdate as select from I_MaterialDocumentItem_2 as Md

{
    key Material,
    max( PostingDate ) as LastPostingDate
//    max( MaterialDocument ) as LastDocument
}
where GoodsMovementType = '101'
group by Material
