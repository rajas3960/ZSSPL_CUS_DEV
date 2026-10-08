@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZBOM_APP01_RV as select from zbom_htb
composition[0..*] of ZBOM_APP01_IRV as _ITEM
{
    
  key suid                as Suid,
     @EndUserText.label: 'Attachments'
      @Semantics.largeObject:{fileName: 'Filename' ,
      acceptableMimeTypes: [ 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],      
                                mimeType: 'Minetype',
                                contentDispositionPreference: #INLINE
                                 }
  key materialnumber      as materialnumber,
  key plant               as plant,
  key bomusage            as bomusage,
  key alternativebom      as alternativebom,
  validfromdate           as validfromdate,
  bomstatus               as bomstatus,
  uom                     as uom,
  @Semantics.quantity.unitOfMeasure : 'uom'
  basequantity            as basequantity,
  baseunitofmeasureforbom as baseunitofmeasureforbom,
  bomdescription          as bomdescription,
  attachment              as attachment,
  @Semantics.mimeType: true
  minetype                as minetype,
  filename                as filename,
  status     as status,
  createdby   as createdby,
  createdon  as createdon,
   _ITEM 
}

