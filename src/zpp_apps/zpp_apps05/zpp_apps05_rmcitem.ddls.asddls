@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cutting Allocation Child Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS05_RMCITEM as select from zpp_apps05_itb7
//composition of target_data_source_name as _association_name
association to parent ZPP_APPS05_RMITEM as _hdr on _hdr.Vrno = $projection.Vrno and _hdr.Srcid = $projection.Srcid
{
    
key vrno as Vrno,
key srcid as Srcid,
key parid as Parid,
marno as Marno,
length as Length,
process as Process,
pcs as Pcs,
balpcs as Balpcs,
_hdr
}
