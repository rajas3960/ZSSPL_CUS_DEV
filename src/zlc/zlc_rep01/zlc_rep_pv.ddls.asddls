@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Maintainence Report Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZLC_REP_PV provider contract transactional_query as projection on ZLC_REP_RV
{
    key Lnum,
    Valfrm,
    Valto,
    Banknam,
    BankBranch,
    Stp,
    StpName,
    @Semantics.amount.currencyCode: 'LcCurr'
    TlcAmt,
    @Semantics.amount.currencyCode: 'LcCurr'
    TlcUtilz,
    @Semantics.amount.currencyCode: 'LcCurr'
    TotBalance,
    LcCurr,
    Project,
    Applicant,
    Ldd,
    Mark as mark,
    Beneficiary,
    Incoterm as Incoterm,
    Remark as Remark,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    Totalqty,
    Unit,
    Popi,
    @Semantics.amount.currencyCode: 'LcCurr'
    Aclcamt,
    @Semantics.amount.currencyCode: 'LcCurr'
    Planlcamt,
    @Semantics.amount.currencyCode: 'LcCurr'
    Totboeamt,
    @Semantics.amount.currencyCode: 'LcCurr'
    Totavamt,
    Torlce,
    NOOFDAYS,
    Intrest,
    /* Associations */
    _item : redirected to composition child ZLC_REP_IPV
}
