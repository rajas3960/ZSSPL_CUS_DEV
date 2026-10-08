@AbapCatalog.sqlViewName: 'ZVVSLOCF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Storage location f4'
@Metadata.ignorePropagatedAnnotations: true
define view ZVXSLOCF4
  as select from I_StorageLocation

{
  key Plant           as plant,
  key StorageLocation as storagelocation,
  StorageLocationName
}
