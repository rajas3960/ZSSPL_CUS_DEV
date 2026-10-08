@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View -  Sales Reports'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_SAle_pv
  provider contract transactional_query
  as projection on ZSD_Sale_re
{
    key BILLDOC,
    key BILLITNO,
    CMPC,
    SALESORG,
    DISTCHLN,
    Division,
    BILLDCTY,
    BILLDT,
    BILLTOPARTY,
    BILLTOPARTYNAME,
    PAYER,
    PAYERNAME,
    SoldToParty,
    SOLDTOPARTYNAME,
    GSTNO,
    MATERIALNO,
    PRODUCT,
    HSNNO,
    uom,
     @Semantics.quantity.unitOfMeasure: 'uom'
    BILLQTY,
    BILLQTUNIT,
    PlantName,
    STRLOCT,
     @Semantics.quantity.unitOfMeasure: 'uom'
    NETWEIGHT,
     @Semantics.quantity.unitOfMeasure: 'uom'
    GROSSWEIGHT,
    CURRENCY,
      @Semantics.amount.currencyCode: 'currency'
    netamt,
      @Semantics.amount.currencyCode: 'currency'
    taxamt,
      @Semantics.amount.currencyCode: 'currency'
    TOTALAMT,
    curr,
   // @Semantics.amount.currencyCode: 'curr'
   // FREIGHT,
   // @Semantics.amount.currencyCode: 'curr'
   // MATERIALVAL,
    @Semantics.amount.currencyCode: 'curr'
    IGSTAMT,
    @Semantics.amount.currencyCode: 'curr'
    CGSTAMT,
    @Semantics.amount.currencyCode: 'curr'
    SGSTAMT,
    //@Semantics.amount.currencyCode: 'curr'
    //TCS,
    exchangerate,
    referencedoc,
    salesorder,
    docno,
    cancel,
    billcan,
    ponumber
}
