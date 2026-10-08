@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD ROOT VIEW ENTITY'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_ITEM_RV as select from I_SalesDocument as SDB
//inner join ZSD_LC_RCV as TAB on TAB.Lcnum = SDB.YY1_LC_Number__SDH

//association to parent ZSD_LC_RCV as _Header on $projection.LCNUMER = _Header.Lcnum
{
    key SDB.SalesDocument as SALENO,
    //TAB.Lcnum as LCNUMER,
    SDB.CreatedByUser,
    SDB.CreationDate,
    SDB.LastChangedByUser,
    SDB.LastChangeDate
   // _Header
}
