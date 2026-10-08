@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Document Schedule View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPSR_SSCHV as select from I_SalesDocumentScheduleLine
{
    key SalesDocument,
    key SalesDocumentItem,
    key max(ScheduleLine ) as ScheduleLine,
    max(DeliveryDate) as DeliveryDate

}
group by 
SalesDocument,
 SalesDocumentItem
