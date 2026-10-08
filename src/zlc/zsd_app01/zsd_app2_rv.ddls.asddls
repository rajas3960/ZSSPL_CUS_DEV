@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Update Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_APP2_RV
  as select from zsd_app2_tb as _SDH
  association[1..*] to ZSD_APP2_IRV as _SDI on _SDI.SalesDocument = $projection.salesdocument

{
  key _SDH.salesdocument,
      _SDH.soldtoparty,
      _SDH.salesdocumentdate,
      _SDH.purchaseorderbycustomer,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      _SDH.totalnetamount,
      _SDH.transactioncurrency,
      _SDH.incotermsclassification,
      _SDH.fiscalyear,
      _SDH.fiscalperiod,
    _SDH.yy1_lcnumber_1_sdh,
      @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_5_SDHC'
       _SDH.yy1_lcamount_5_sdh,
      _SDH.yy1_lcamount_5_sdhc,
    _SDH.yy1_lcnumber_4_sdh,
  _SDH.yy1_lcnumber_8_sdh,
  _SDH.yy1_lcnumber_5_sdh,
        @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_1_SDHC'
_SDH.yy1_lcamount_1_sdh,
_SDH.yy1_lcamount_1_sdhc,
      @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_4_SDHC'
     _SDH.yy1_lcamount_4_sdh,
  _SDH.yy1_lcamount_4_sdhc,
//      YY1_PortofLoading_SDH,
      @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_7_SDHC'
    _SDH.yy1_lcamount_7_sdh,
      _SDH.yy1_lcamount_7_sdhc,
      @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_6_SDHC'
  _SDH.yy1_lcamount_6_sdh,
_SDH.yy1_lcamount_6_sdhc,
 _SDH.yy1_lcnumber_7_sdh,
      @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_10_SDHC'
  _SDH.yy1_lcamount_10_sdh,
   _SDH.yy1_lcamount_10_sdhc,
     _SDH.yy1_lcnumber_3_sdh,
      @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_2_SDHC'
       _SDH.yy1_lcamount_2_sdh,
      _SDH.yy1_lcamount_2_sdhc,
      @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_3_SDHC'
_SDH.yy1_lcamount_3_sdh,
    _SDH.yy1_lcamount_3_sdhc,
//      YY1_Panno_sd_SDH,
     _SDH.yy1_lcnumber_10_sdh,
      @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_8_SDHC'
   _SDH.yy1_lcamount_8_sdh,
      _SDH.yy1_lcamount_8_sdhc,
//      YY1_Statename_Sd_SDH,
//      YY1_Gstno_sd_SDH,
      _SDH.yy1_lcnumber_2_sdh,
      @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_9_SDHC'
      _SDH.yy1_lcamount_9_sdh,
_SDH.yy1_lcamount_9_sdhc,
 _SDH.yy1_lcnumber_9_sdh,
    _SDH.yy1_lcnumber_6_sdh,
      _SDH. createdbyuser,
      _SDH.creationdate,
      _SDH.lastchangedbyuser,
      _SDH.lastchangedatetime,
     _SDH.mark  as Mark,
      
      /* Association */
      _SDI

}
