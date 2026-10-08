@EndUserText.label: 'Custom Entity Of header'
@ObjectModel.query.implementedBy: 'ABAP:ZPP_REL_DOC_FORM'
define custom entity ZPP_APP03_HCE
{
  key reldocno   : abap.char(8);
      uuid       : sysuuid_x16;
      matnr      : matnr;
      reldocs    : abap.char(10);
      maktx      : maktx;
      project    : maktx;
      contractor : maktx;
      preparedby : abap.char(40);
      realeasdt  : abap.dats;
      @ObjectModel.filter.enabled  : false
      _item      : association [1..*] to ZPP_APP03_ICE on _item.Uuid = $projection.uuid;
}
