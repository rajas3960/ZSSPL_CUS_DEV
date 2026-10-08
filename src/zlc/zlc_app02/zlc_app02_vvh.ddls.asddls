@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help for LC'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZLC_APP02_VVH as select from ZLC_APP02_RV as lc
left outer join ZSD_APP02_VH_LC as so on so.Lnum = lc.Lnum
{
@EndUserText.label: 'LC Number'
    key lc.Lnum,
    @EndUserText.label: 'Customer No'
    lc.Stp as Cust,
    @Semantics.amount.currencyCode: 'Currency'
    lc.TlcAmt ,
    @UI.hidden: true
    lc.LcCurr as Currency,
     @EndUserText.label: 'Last Date Of Dispatch'
    lc.Ldd,
//    @Semantics.amount.currencyCode: 'Currency'
//   
coalesce(cast(lc.TlcAmt as abap.dec(15,2)), 0) 
- coalesce(so.Lcamount , 0) as Balance


    
   
} where lc.Valto >= $session.system_date
