@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Report Root - BOM Summary'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_REP_RV
  as select from    I_SalesDocument        as _Hdr

    left outer join I_SalesDocumentPartner as bp   on  bp.SalesDocument   = _Hdr.SalesDocument
                                                   and bp.PartnerFunction = 'WE'

    left outer join I_Customer             as sAdd on sAdd.Customer = bp.Customer
    
    left outer join zsd_customer_add as spad on spad.Customer = sAdd.Customer
                                             and spad.AddressID = sAdd.AddressID

  left outer join I_Customer as BAdd on BAdd.Customer = _Hdr.SoldToParty
  
  left outer join zsd_customer_add as bpad on bpad.Customer = BAdd.Customer
                                                 and bpad.AddressID = BAdd.AddressID

  association [1..1] to zsd_rep_db as form on $projection.SalesDocument = form.saleorder

  composition [0..*] of ZSD_REPORT as Item
{
  key _Hdr.SalesDocument,
      _Hdr.SalesDocumentType,
      _Hdr.SalesDocumentDate,
      _Hdr.PurchaseOrderByCustomer,
      _Hdr.CustomerPurchaseOrderDate,
      _Hdr.SoldToParty,
      _Hdr.YY1_PriorityPONos_SDH,
      _Hdr.YY1_GalvaCoating_SDH,
      _Hdr.CreationDate,
      BAdd.CustomerName,
      BAdd.BPAddrStreetName,
      BAdd.PostalCode,
      BAdd.CityName,
      bpad.StreetPrefixName1,
      bpad.StreetPrefixName2,
      _Hdr.YY1_Gstno_sd_SDH,
      _Hdr.YY1_Statename_Sd_SDH,
      bp.Customer     as ShipToCustomer,
      sAdd.CustomerName as Customer_Name,
      sAdd.StreetName,
      sAdd.PostalCode as Postal_Code,
      sAdd.CityName as City_Name,
      spad.StreetPrefixName1 as street1,
      spad.StreetPrefixName2 as street2,
      form.attachment as Attachment,
      form.mimetype   as Mimetype,
      form.filename   as Filename,
      Item
}
