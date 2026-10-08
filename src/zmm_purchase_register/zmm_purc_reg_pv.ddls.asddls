@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Register Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }
define root view entity zmm_purc_reg_PV
  provider contract transactional_query
  as projection on ZMM_PURC_REG_RE

{   

  key PurchaseOrder,
    key PurchaseOrderItem,
    key GRDocument,
    key MATDOCITEM,
    key YEARSSD,
    key GLNumber,
     key SupplierInvoiceItem,
//    key compcode,
    key GRYear,
  
 
    SupplierInvoiceNo,
    GRNDate,
    GRpostingDate,
    InvoiceDate,
    DocumentReferenceID,
   // GlAccount,
    PurchaseType,
    Podate,
    Pogrp,
    hsnno,
    MaterialType,
    GLCode,
    GLDescription,
    Matgrp,
     @Semantics.quantity.unitOfMeasure:    'Baseunit'
    OrdQty,
    plant,
    taxcod,
     TaxDescription,
    Baseunit,
     @Semantics.amount.currencyCode: 'PriceUnit'
    Rate,
    condcurr,
    GoodsMovement,
    StgLoc,
    EntryUnit,
       @Semantics.quantity.unitOfMeasure:    'EntryUnit'  
    GRNQuantity,
    BASE,
         @Semantics.quantity.unitOfMeasure:    'BASE'
    Quantity,
    DebitCreditCode,
//     @Semantics.amount.currencyCode: 'PriceUnit'
//    TCS,
//     @Semantics.amount.currencyCode: 'PriceUnit'
//    CESS,
//     @Semantics.amount.currencyCode: 'PriceUnit'
//    FreightExpo,
//     @Semantics.amount.currencyCode: 'PriceUnit'
//    FreightSpare,
//     @Semantics.amount.currencyCode: 'PriceUnit'
//    RoundOff,
    dCCode,
           @Semantics.amount.currencyCode: 'PriceUnit'
    taxablevalue,
    
    PriceUnit,
           @Semantics.amount.currencyCode: 'PriceUnit'
    cgstamount,
           @Semantics.amount.currencyCode: 'PriceUnit'
    sgstamount,
           @Semantics.amount.currencyCode: 'PriceUnit'
    igstamount,
//    Vendor,
//    VendorName,
//    VendorTax,
//    VendorRegion,
//    VendorCountry,
//    VendorPanNumber,
    Material,
    MaterialDescription,
    CGSTPercent,
    SGSTPercent,
    IGSTPercent,
           @Semantics.amount.currencyCode: 'PriceUnit'
    grossamount,
         @Semantics.amount.currencyCode: 'PriceUnit'
    discountvalue,
    POType,
    @Semantics.amount.currencyCode: 'PriceUnit'
   AMTRoundoff,
   @Semantics.amount.currencyCode: 'PriceUnit'
   cess,
   @Semantics.amount.currencyCode: 'PriceUnit'
   TCS,
   @Semantics.amount.currencyCode: 'PriceUnit'
   FreightEXO,
   @Semantics.amount.currencyCode: 'PriceUnit'
   FreightSpare
    

}

