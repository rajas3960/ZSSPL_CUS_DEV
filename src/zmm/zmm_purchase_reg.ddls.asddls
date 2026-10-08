//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Purchase Register report'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
//define view entity zmm_purchase_reg as select from  ZMM_PURREQ_MATERIAL as MDH
//left outer join  I_PurchaseOrderAPI01               as POH  on POH.PurchaseOrder = MDH.PurchaseOrder
////                                                         AND MDH.PurchaseOrderItem = POH.PurchaseOrderItem   
//   inner join I_PurchaseOrderItemAPI01               as POI        on POI.PurchaseOrder = MDH.PurchaseOrder
//                                                         and POI.PurchaseOrderItem = MDH.PurchaseOrderItem
//                                                       
//  left outer join  I_Supplier                        as Supplier   on Supplier.Supplier = POH.Supplier
//
////  left outer join ZMM_PURREQ_MATERIAL as MDH on MDH.PurchaseOrder = POI.PurchaseOrder and MDH.PurchaseOrderItem = POI.PurchaseOrderItem
////                                                                     and POI.Material = MDH.Material
//   
//                                                           
//{ key MDH.Material,  
//   MDH.PurchaseOrder                                 as PurchaseOrder,
//  MDH.PurchaseOrderItem                             as purchaseorderitem,
//      Supplier.Supplier                                 as Vendor,
//      Supplier.SupplierName                             as VendorName,
//      Supplier.Region                                   as VendorRegion,
//      Supplier.TaxNumber3                               as VendorTax,
//      Supplier.Country                                  as VendorCountry,
//      Supplier.BusinessPartnerPanNumber                 as VendorPanNumber,
//    MDH.MaterialDocument as GRDocument,
//    POI.DocumentCurrency as cucy,
//    @Semantics.amount.currencyCode: 'cucy'
//    POI.NetPriceAmount as NetAmount  
//  
//}
//
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Register report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zmm_purchase_reg 
  as select from ZMM_PURREQ_MATERIAL as MDH

  inner join I_PurchaseOrderItemAPI01 as POI
      on POI.PurchaseOrder     = MDH.PurchaseOrder
     and POI.PurchaseOrderItem = MDH.PurchaseOrderItem

  left outer join I_PurchaseOrderAPI01 as POH
      on POH.PurchaseOrder = POI.PurchaseOrder    // Join header via item

  left outer join I_Supplier as Supplier
      on Supplier.Supplier = POH.Supplier

{
    key MDH.Material,
    MDH.PurchaseOrder        as PurchaseOrder,
    MDH.PurchaseOrderItem    as PurchaseOrderItem,

    Supplier.Supplier        as Vendor,
    Supplier.SupplierName    as VendorName,
    Supplier.Region          as VendorRegion,
    Supplier.TaxNumber3      as VendorTax,
    Supplier.Country         as VendorCountry,
    Supplier.BusinessPartnerPanNumber as VendorPanNumber,

    MDH.MaterialDocument     as GRDocument,

    POI.DocumentCurrency     as cucy,

    @Semantics.amount.currencyCode: 'cucy'
    POI.NetPriceAmount       as NetAmount
}
