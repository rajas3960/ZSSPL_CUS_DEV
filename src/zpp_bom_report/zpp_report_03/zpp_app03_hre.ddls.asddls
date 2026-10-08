@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Release Document Root view'
@Metadata.ignorePropagatedAnnotations: true
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZPP_APP03_HRE
  as select from zpp_app03_db as hdr
  association [1..1] to zpp_rel_db     as form on  form.reldocno = $projection.Reldocno
  association [1..1] to ZPP_DESC       as d    on  d.Material = $projection.Matnr
  association [1..1] to I_ProductText  as pd   on  pd.Product  = $projection.Matnr
                                               and pd.Language = $session.system_language
  composition [0..*] of ZPP_APP03_IRE  as item
  composition [0..*] of zpp_app03_ire2 as item2

{
  key uuid                 as Uuid,
  key matnr                as Matnr,
      reldocs,
      d.BOMAlternativeText as Maktx,
      reldocno             as Reldocno,
      pd.ProductName       as Project,
      d.BOMHeaderText      as Contractor,
      realeasdt            as Realeasdt,
      preparedby           as Preparedby,
      createby             as Createby,
      createon             as Createon,
      form.attachment      as Attachment,
      form.mimetype        as Mimetype,
      form.filename        as Filename,
      item,
      item2
}
