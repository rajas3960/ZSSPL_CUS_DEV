@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rolling Production Report'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZPP_REP_02
  as select from ZR_BILLET_HDR as a
    left outer join ZR_BILLET_HDR as b
      on b.plant = a.plant
     and b.status = 'Completed'
     and b.postingdate >= cast(
           concat(
             substring( a.postingdate,1,6 ),
             '01'
           ) as abap.dats
         )
     and b.postingdate <= a.postingdate

{
  key a.plant,
  key a.postingdate,

  @Semantics.quantity.unitOfMeasure: 'uom'
  sum( b.totalpostquantity ) as mactqty,
  
  a.uom
}
where  a.status = 'Completed'

group by
  a.plant,
  a.postingdate,
  a.uom
