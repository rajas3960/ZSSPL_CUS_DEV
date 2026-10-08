@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RAW MATERIAL REPORT ROOT'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_RM_REP_RV
  as select from    zpp_apps05_htb  as h
    left outer join zpp_apps05_itb8 as i on i.uuid = h.uuid
    left outer join I_ProductText   as p on  p.Product  = h.sectmat
                                         and p.Language = $session.system_language
{
  key h.uuid    as uuid,
  key h.sectmat as sectmat,
  key h.vrno,
  key h.project,
  key i.irno,
      p.ProductName,
      i.length,
      i.used,
      i.uqty
      
}
