@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material stock'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MATSTC as select from I_MaterialStock_2 as Mat

{
    key Mat.Material as Material,
//    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//    sum(Mat.MatlWrhsStkQtyInMatlBaseUnit) as STcok,
    MaterialBaseUnit
,
  concat(
    concat(
      concat(
        concat(
          concat(
            concat(
              '1010_: ',
              cast(
                sum(case when Mat.Plant = '1010' then Mat.MatlWrhsStkQtyInMatlBaseUnit else 0 end)
                as abap.char(15)
              )
            ),
            concat(
              ' |1020_: ',
              cast(
                sum(case when Mat.Plant = '1020' then Mat.MatlWrhsStkQtyInMatlBaseUnit else 0 end)
                as abap.char(15)
              )
            )
          ),
          concat(
            ' |1030_: ',
            cast(
              sum(case when Mat.Plant = '1030' then Mat.MatlWrhsStkQtyInMatlBaseUnit else 0 end)
              as abap.char(15)
            )
          )
        ),
        concat(
          ' |1040_: ',
          cast(
            sum(case when Mat.Plant = '1040' then Mat.MatlWrhsStkQtyInMatlBaseUnit else 0 end)
            as abap.char(15)
          )
        )
      ),
      ''  // Dummy concat to close
    ),
    ''  // Final dummy concat
  ) as  STcok

 
}
group by
    Material,
    MaterialBaseUnit
