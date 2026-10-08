@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Child Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP04_IRV as select from zpp_app04_tb2
association to parent ZPP_APP04_RV as _Header on _Header.Jobsheet = $projection.Jobsheet
{
    key jobsheet as Jobsheet,
    key sfgordnum as Sfgordnum,
    sfgordnitm as Sfgordnitm,
    burks as Burks,
    sfgordtyp as Sfgordtyp,
    sfgordtxt as Sfgordtxt,
    sfgmatnr as Sfgmatnr,
    sfgmaktx as Sfgmaktx,
    sfgbatch as Sfgbatch,
    sfgsloc as Sfgsloc,
    @Semantics.quantity.unitOfMeasure: 'Sfgplndunt'
    sfgplndqty as Sfgplndqty,
    sfgplndunt as Sfgplndunt,
    @Semantics.quantity.unitOfMeasure: 'Sfgplndunt'
    reqty as Reqty,
    ernam as Ernam,
    erdat as Erdat,
    salesord as Salesord,
    soitem as Soitem,
        @Semantics.user.createdBy: true
    createdby as Createdby,
        @Semantics.systemDateTime.createdAt: true
    createdon as Createdon,
      weakrs  as Weakrs,
    _Header
}
