@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Child_Projection_View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZMAT_DOC_IPV1 
as projection on ZMAT_DOC_IV1
{
    key Uuid,
    key Itemno,
    Gmtype,
    Matdoc,
    @Consumption.valueHelpDefinition: [{ entity:{name: 'I_ProductVH_2', element: 'Product'},useForValidation: true}]
    Material,
    Mdesc,
    @Consumption.valueHelpDefinition: [{ entity:{name: 'I_PlantStdVH', element: 'Plant'},useForValidation: true}]
    Plant,
    @Consumption.valueHelpDefinition: [{ entity:{name: 'I_StorageLocationStdVH', element: 'StorageLocation'},useForValidation: true}]
    Sloc,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Matqty,
    Uom,
    Rate,
    @Consumption.valueHelpDefinition: [{ entity:{name: 'I_CostCenterStdVH', element: 'CostCenter'},useForValidation: true}]
    Costcenter,
    @Consumption.valueHelpDefinition: [{ entity:{name: 'I_GLAccountStdVH', element: 'GLAccount'},useForValidation: true}]
    Glaccount,
    Spsfqty,
    Hdrdesc,
    Mark,
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    /* Associations */
    _Header : redirected to parent ZMAT_DOC_RPV
}
