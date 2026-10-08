@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cutting Allocation  Item'
@Metadata.ignorePropagatedAnnotations: true
define  view entity ZPP_APPS05_RMITEM as select from zpp_apps05_itb6
composition[1..*] of ZPP_APPS05_RMCITEM as _item

{
 key   vrno as Vrno,
 key srcid as Srcid,
 srclent as Srclent,
 srcpcs as Srcpcs,
 lengthstr as Lengthstr,
 actlent as Actlent,
 wast as Wast,
 rtnlent as Rtnlent,
 wastepr as Wastepr,
 trmwste as Trmwste,
 totlen as Totlen,
 _item
}
