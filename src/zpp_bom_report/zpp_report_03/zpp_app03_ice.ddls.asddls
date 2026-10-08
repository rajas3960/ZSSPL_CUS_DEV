@EndUserText.label: 'Custom Entity Of Item'
@ObjectModel.query.implementedBy: 'ABAP:ZPP_REL_DOC_ITEM'
define custom entity ZPP_APP03_ICE
{
  key uuid   : sysuuid_x16 ;
  key srno   : abap.char(10);
  proj       : matnr;
  towertype  : matnr;
  ttdesc     : maktx;
  ttsub      : matnr;
  ttsdesc    : maktx;
  str        : matnr;
  strdesc    : maktx;
  mark       : matnr;
  combi      : abap.char(50);
  bom        : abap.char(10);
}
