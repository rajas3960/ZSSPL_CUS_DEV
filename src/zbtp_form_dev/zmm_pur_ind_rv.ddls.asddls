@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Indent - Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PUR_IND_RV as select from ZMM_PUR_IND_RE1
association [0..*] to  ZMM_PUR_IND_IV as _Item on $projection.purreq_no = _Item.Purcreq
                                                 and $projection.purreq_itno = _Item.purreqitno

{
    key purreq_no,
    key purreq_itno,
    Hdesc,
    itemtext,
    CostCenter,
    GLAccount,
    COSTNAME,
    remarks,
    reqdate,
    indetdate,
    dept,
//    GRDocument,
//    VendorName,
    PurchasingDocument,
    PurchasingDocumentItem,
    _Item
}
