@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Entity For Raw Material Req Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS05_RMITM as select from zpp_apps05_itb4
//composition of target_data_source_name as _association_name
{

key uuid,
key sno,
vrno,
length,
quantity,
quanwt,
irno

}
