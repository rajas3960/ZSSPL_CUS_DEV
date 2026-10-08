@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Projection View 2'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZBOM_APP02_HPV2 provider contract transactional_query 
 as projection on  ZBOM_APP02_RV2
{
    key Suid,
    key materialnumber,
    key plant,
    key bomusage,
    key alternativebom,
    validfromdate,
    bomstatus,
    changenumber,
    uom,
    @Semantics.quantity.unitOfMeasure : 'uom'
    basequantity,
    bomdescription,
    Attachment,
//    AttachmentItem,
    Minetype,
    Filename
    
    
//    Status,
//    Createdby,
//    Createdon,
 //_ITEM : redirected to composition child  ZBOM_APP02_IPV,  
// _HDR :redirected to parent ZBOM_APP02_PV2
}
