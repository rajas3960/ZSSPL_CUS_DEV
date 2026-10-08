@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZNS_PKG_RV ROOT VIEW'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZNS_PKG_RV1 as select from zns_pkg_tb1
composition [0..*] of ZNS_PKG_IV2 as _item
//association[1..1] to zstatus_f as _stus on _stus.value_low = $projection.Status

{
    key uuid as Uuid,
     @EndUserText.label: 'Attachments'
      @Semantics.largeObject:{fileName: 'Filename' ,
      acceptableMimeTypes: [ 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],
                                mimeType: 'Minetype',
                                contentDispositionPreference: #INLINE
                                 }
    attachment as Attachment,
    @Semantics.mimeType: true
    minetype as Minetype,
    filename as Filename,
    @Semantics.user.createdBy: true
    createdby as Createdby,
      @Semantics.systemDateTime.createdAt: true
    createdon as Createdon,
    @Semantics.user.lastChangedBy: true
    lastchangedby as Lastchangedby,
     @Semantics.systemDateTime.lastChangedAt: true
    lastchangedon as Lastchangedon,
    status as Status,
    decs as Decs,
    _item
}
