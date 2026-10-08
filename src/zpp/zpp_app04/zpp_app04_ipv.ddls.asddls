@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order App Child Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP04_IPV as projection on  ZPP_APP04_IRV
{
    key Jobsheet,
    key Sfgordnum,
    Sfgordnitm,
    Burks,
    Sfgordtyp,
    Sfgordtxt,
    Sfgmatnr,
    Sfgmaktx,
    Sfgbatch,
    Sfgsloc,
    @Semantics.quantity.unitOfMeasure: 'Sfgplndunt'
    Sfgplndqty,
    Sfgplndunt,
    @Semantics.quantity.unitOfMeasure: 'Sfgplndunt'
    Reqty,
    Ernam,
    Erdat,
    Salesord,
    Soitem,
        @Semantics.user.createdBy: true
    Createdby,
        @Semantics.systemDateTime.createdAt: true
    Createdon,
   Weakrs,
    /* Associations */
    _Header : redirected to parent ZPP_APP04_PV
}
