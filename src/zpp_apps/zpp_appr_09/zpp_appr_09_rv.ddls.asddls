@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Structure and HT AND MS Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_APPR_09_RV
  as select from    I_Product       as p
    left outer join zpp_appr_09_htb as h on h.product = p.Product
{
  key p.Product as Product,
      h.price   as Price,
      h.mark    as Mark



}
