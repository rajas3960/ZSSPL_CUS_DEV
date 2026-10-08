@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_APP_HRV as select from zsd_app_h
composition[0..*] of ZSD_APP_IRV as _SalesItem

association[1..1] to zsd_image_dom as _image on 'X' = _image.FIXED_VAL
 
{
    key recguid as Recguid,
    ordertype as Ordertype,
    salesorg as Salesorg,
    dist as Dist,
    div as Div,
    soldto as Soldto,
    lcnumber as Lcnumber,
    lcnumber2 as Lcnumber2,
    lcnumber3 as Lcnumber3,
    lcnumber4 as Lcnumber4,
    lcnumber5 as Lcnumber5,
    lcnumber6 as Lcnumber6,
    lcnumber7 as Lcnumber7,
    lcnumber8 as Lcnumber8,
    lcnumber9 as Lcnumber9,
    lcnumber10 as Lcnumber10,
    @Semantics.amount.currencyCode: 'Lcurr'
    lcamount as Lcamount,
    @Semantics.amount.currencyCode: 'lcurr2'
    lcamount2 as Lcamount2,
    @Semantics.amount.currencyCode: 'lcurr3'
    lcamount3 as Lcamount3,
    @Semantics.amount.currencyCode: 'lcurr4'
    lcamount4 as Lcamount4,
    @Semantics.amount.currencyCode: 'lcurr5'
    lcamount5 as Lcamount5,
     @Semantics.amount.currencyCode: 'lcurr6'
    lcamount6 as Lcamount6,
     @Semantics.amount.currencyCode: 'lcurr7'
    lcamount7 as Lcamount7,
     @Semantics.amount.currencyCode: 'lcurr8'
    lcamount8 as Lcamount8,
     @Semantics.amount.currencyCode: 'lcurr9'
    lcamount9 as Lcamount9,
     @Semantics.amount.currencyCode: 'lcurr10'
    lcamount10 as Lcamount10,
    lcurr  as Lcurr,
    lcurr2 as Lcurr2,
    lcurr3 as lcurr3,
    lcurr4 as lcurr4,
    lcurr5 as lcurr5,
    lcurr6 as lcurr6,
    lcurr7 as lcurr7,
    lcurr8 as lcurr8,
    lcurr9 as lcurr9,
    lcurr10 as lcurr10,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdon as Createdon,
    @Semantics.user.lastChangedBy: true
    lastchangedby as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangedon as Lastchangedon,
    salesorderno as Salesorderno,
    /*Assocication*/
    @Semantics.imageUrl: true
    _image.IMAGES,
    cast('Standard Order' as abap.char(20)) as salesname,
    _SalesItem
    
}
