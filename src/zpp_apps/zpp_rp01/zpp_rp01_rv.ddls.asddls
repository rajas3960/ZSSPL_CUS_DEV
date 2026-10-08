@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bom Report Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_RP01_RV as select from I_MaterialBOMLink as MBOM
left outer join I_Product as prct on prct.Product = MBOM.Material
left outer join I_BillOfMaterialItemDEX_3 as boim on boim.BillOfMaterial  = MBOM.BillOfMaterial and boim.BillOfMaterialVariant = MBOM.BillOfMaterialVariant
{
key boim.BillOfMaterialCategory,
//key boim.BillOfMaterial,
key boim.BillOfMaterialItemNodeNumber,
key boim.BOMItemInternalChangeCount,
key cast(MBOM.BillOfMaterial as abap.numc( 8 ) ) as BOM,
key MBOM.BillOfMaterialVariant,
key MBOM.Material,
key MBOM.Plant,
key MBOM.BillOfMaterialVariantUsage,
boim.BillOfMaterialItemUUID,
boim.InheritedNodeNumberForBOMItem,
boim.InheritedNodeNumberVersionBOM,
boim.ValidityStartDate,
boim.ValidityEndDate,
boim.EngineeringChangeDocument,
boim.ChgToEngineeringChgDocument,
boim.BOMItemRecordCreationDate,
boim.BOMItemCreatedByUser,
boim.BOMItemLastChangeDate,
boim.BOMItemLastChangedByUser,
boim.BillOfMaterialComponent,
boim.BillOfMaterialItemCategory,
//boim.BillOfMaterialItemNumber,
boim.BillOfMaterialItemUnit,
@Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
boim.BillOfMaterialItemQuantity,
boim.IsSubItem,
boim.BOMItemSorter,
//boim.FixedQuantity,
boim.PurchasingGroup,
boim.Currency,
@Semantics.amount.currencyCode: 'Currency'
boim.MaterialComponentPrice,
boim.IdentifierBOMItem,
boim.MaterialPriceUnitQty,
boim.ComponentScrapInPercent,
boim.OperationScrapInPercent,
boim.IsNetScrap,
//@Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
//boim.NumberOfVariableSizeItem,
@Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
boim.QuantityVariableSizeItem,
boim.FormulaKey,
//boim.BOMItemText1,
boim.BOMItemText2,
boim.MaterialGroup,
boim.DocumentType,
boim.DocNumber,
boim.DocumentVersion,
boim.DocumentPart,
boim.ClassNumber,
boim.ClassType,
boim.ResultingItemCategory,
boim.DependencyObjectNumber,
//boim.ObjectType,
boim.IsClassificationRelevant,
boim.IsBulkMaterial,
boim.BOMItemIsSparePart,
boim.BOMItemIsSalesRelevant,
boim.IsProductionRelevant,
boim.BOMItemIsPlantMaintRelevant,
boim.BOMItemIsCostingRelevant,
boim.IsEngineeringRelevant,
boim.SpecialProcurementType,
boim.IsBOMRecursiveAllowed,
boim.OperationLeadTimeOffset,
boim.OpsLeadTimeOffsetUnit,
boim.IsMaterialProvision,
boim.BOMIsRecursive,
boim.DocumentIsCreatedByCAD,
boim.DistrKeyCompConsumption,
boim.DeliveryDurationInDays,
//boim.Creditor,
boim.CostElement,
@Semantics.quantity.unitOfMeasure: 'UnitOfMeasureForSize1To3'
boim.Size1,
@Semantics.quantity.unitOfMeasure: 'UnitOfMeasureForSize1To3'
boim.Size2,
@Semantics.quantity.unitOfMeasure: 'UnitOfMeasureForSize1To3'
boim.Size3,
boim.UnitOfMeasureForSize1To3,
boim.GoodsReceiptDuration,
boim.PurchasingOrganization,
boim.RequiredComponent,
boim.MultipleSelectionAllowed,
boim.ProdOrderIssueLocation,
boim.MaterialIsCoProduct,
boim.ExplosionType,
boim.FollowUpGroup,
boim.DiscontinuationGroup,
boim.ReinsurContrOrgUnit,
boim.IsConfigurableBOM,
boim.ReferencePoint,
boim.LeadTimeOffset,
boim.IsSoftwareComponent,
boim.ProductionSupplyArea,
boim.IsDeleted,
boim.IsALE,
boim.AlternativeItemGroup,
boim.AlternativeItemPriority,
boim.AlternativeItemStrategy,
boim.UsageProbabilityPercent,
MBOM.BillOfMaterialCategory as CAT,
MBOM.IsConfiguredMaterial,
MBOM.MaterialBOMObjectID,
MBOM.CreatedByUser,
MBOM.LastChangedByUser,
@Semantics.quantity.unitOfMeasure: 'YY1_LENGTH_MM_PRDU'
prct.YY1_LENGTH_MM_PRD,

prct.YY1_LENGTH_MM_PRDU,
@Semantics.quantity.unitOfMeasure: 'YY1_UNIT_WGT_PRDU'
prct.YY1_UNIT_WGT_PRD,
prct.YY1_UNIT_WGT_PRDU,
@Semantics.quantity.unitOfMeasure: 'YY1_WGT_PC_PRDU'
prct.YY1_WGT_PC_PRD,
prct.YY1_WGT_PC_PRDU,
@Semantics.quantity.unitOfMeasure: 'YY1_WIDTH_MM_PRDU'
prct.YY1_WIDTH_MM_PRD,
prct.YY1_WIDTH_MM_PRDU,
prct.YY1_ComponentType_PRD,
/* Associations */


MBOM._BillOfMaterialUsage
  }
