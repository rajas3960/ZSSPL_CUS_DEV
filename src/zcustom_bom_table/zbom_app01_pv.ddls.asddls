@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZBOM_APP01_PV
  provider contract transactional_query
  as projection on ZBOM_APP01_RV
{
  key Suid,  
        @EndUserText.label: 'Attachments'
      @Semantics.largeObject:{fileName: 'Filename' ,
      acceptableMimeTypes: [ 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],
                                mimeType: 'Minetype',
                                contentDispositionPreference: #INLINE
                                 } 
  key materialnumber,
  key plant,
  key bomusage,
  key alternativebom,
      validfromdate,
      bomstatus,
      uom,
      @Semantics.quantity.unitOfMeasure : 'uom'
      basequantity,
      baseunitofmeasureforbom,
      bomdescription,
      attachment,
      @Semantics.mimeType: true
      minetype,
      filename,
      status,
      createdby,
      createdon,

      _ITEM : redirected to composition child ZBOM_APP01_IPV
}
