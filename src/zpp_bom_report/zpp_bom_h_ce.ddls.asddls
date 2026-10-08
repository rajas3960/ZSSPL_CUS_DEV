@EndUserText.label: 'Custom Entity Of header'
@ObjectModel.query.implementedBy: 'ABAP:ZPP_BOM_PRINT_IMP'
define custom entity ZPP_BOM_H_CE
  // with parameters  : parameter_type
{
  key bomnum        : abap.char(10);
      projectno     : matnr;
      purchaser     : abap.char(40);
      refdocno      : abap.char(40);
      projectname   : abap.char(40);
      drawingno     : abap.char(40);
      bomno         : abap.char(40);
      towertypedesc : abap.char(40);
      structuredesc : abap.char(40);
      BOMVERSION  : abap.char(2);
      bomdat        : abap.dats;
@ObjectModel.filter.enabled  : false
      _item :association [1..*] to ZPP_BOM_I_CE on  _item.bomnumber = $projection.bomnum;
@ObjectModel.filter.enabled  : false
      ZPP_BOM_SECTION : association [1..*] to ZPP_BOM_SECTION_CE on ZPP_BOM_SECTION.bomnum = $projection.bomnum;
@ObjectModel.filter.enabled: false
       ZPP_SUBTYPE : association[1..*] to ZPP_SUBTYPE_CE on ZPP_SUBTYPE.Bomnumber = $projection.bomnum;
}
