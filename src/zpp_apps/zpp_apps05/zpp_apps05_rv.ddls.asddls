@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZPP_APPS05_RV
  as select from zpp_apps05_htb
  //  left outer join ZPP_APPS05_RAWS as qty on qty.Vrno = zpp_apps05_htb.vrno
  association [1..1] to ZPP_APPS05_RAWS as _rew  on  _rew.Vrno = $projection.Vrno
  association [1..1] to zpp_apps05_att  as _form on  _form.vrno = $projection.Vrno
  association [1..1] to I_ProductText   as _text on  _text.Product  = $projection.Project
                                                 and _text.Language = 'E'
  composition [1..*] of ZPP_APPS05_IRV1 as _itemgtmark
  composition [1..*] of ZPP_APPS05_IRV2 as _itemftmark
  composition [1..*] of ZPP_APPS05_IRV3 as _itemgtlet
  composition [1..*] of ZPP_APPS05_IRV4 as _itemgtstock
  composition [1..*] of ZPP_APPS05_IRV5 as _itemftstock
  composition [1..*] of ZPP_APPS05_IRV6 as _itemrsult
  composition [1..*] of ZPP_APPS05_IRV8 as _itemsumry


{
  key uuid                  as Uuid,
      werks                 as Werks,
      //     case when werks   is initial
      //     then '1030'
      //     else '1030'
      //     end            as Werks,
      vrno                  as Vrno,
      vbeln                 as Vbeln,
      prod                  as Prod,
      @ObjectModel.text.element: [ 'Projectname' ]
      project               as Project,
      _text.ProductName     as Projectname,
      sectmat               as Sectmat,
      unitwet               as Unitwet,
      purno                 as Purno,
      delmark               as Delmark,
      status                as Status,
      statusr               as Statusr,
      statusgi              as Statusgi,
      statusgr              as Statusgr,
      relusr                as Relusr,
      pgiusr                as Pgiusr,
      pgrusr                as Pgrusr,
      gengt                 as Gengt,
      vrcuting              as Vrcuting,
      totlentq              as Totlentq,
      totwithst             as Totwithst,
      totwithmk             as Totwithmk,
      _form.attachment      as Attachment,
      _form.filename        as Filename,
      _form.mimetype        as Mimetype,
      chckmrk               as Chckmrk,
      plndt                 as Plndt,
      contr                 as Contr,
      contrname             as Contrname,
      matno                 as Matno,
      remark                as Remark,
      @Semantics.user.createdBy: true
      createdby             as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdon             as Createdon,
      @Semantics.user.localInstanceLastChangedBy: true
      lastchangedby         as Lastchangedby,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lastchangedon         as Lastchangedon,
      _rew.rqty             as qty,
     cast( _rew.rqty - totwithmk as abap.dec( 15, 3 ) ) as waste,



      _itemgtmark,
      _itemftmark,
      _itemgtlet,
      _itemgtstock,
      _itemftstock,
      _itemrsult,
      _text,
      _itemsumry



}
