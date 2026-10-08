@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Root View Of Bom Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.supportedCapabilities: [ #OUTPUT_FORM_DATA_PROVIDER ]
define view entity ZPP_BOM_IRE
  as select from zpp_bom_itb
  association to parent ZPP_BOM_HRE as _hdr on _hdr.Uuid = $projection.Uuid
{
  key uuid              as Uuid,
  key srno              as Srno,
      bomnum            as bomnumber,
      markno            as Markno,
      member            as Member,
      markdesc          as Markdesc,
      leng              as Length,
      width_s           as Width,
      unit_s            as Unit,
      unitperpcs        as unitperpcs,
      quantitys         as Quantity,
      totalwt           as totalwt,
      markshortno       as Markshortno,
      itemcreatedby     as Itemcreatedby,
      itemcreatedat     as Itemcreatedat,
      itemlastchangedby as Itemlastchangedby,
      _hdr
}
