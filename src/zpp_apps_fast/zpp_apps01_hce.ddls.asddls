@ObjectModel.query.implementedBy: 'ABAP:ZPP_JC_FORM'
@EndUserText.label: 'Custom Entity For Header'

define custom entity ZPP_APPS01_HCE
{
  key jcnum     : abap.char(12);
      material  : matnr;
      machine      : arbpl;
      makts      : maktx;
      plant     : werks_d;
      plant_d   : name1_a;
      jcseries  : abap.char(30);
      batch      : abap.char(10);
      GRNNO      : abap.char(15);
      supplier   : lifnr;
      suppliername : abap.char(80);
      length     : abap.dec(20,2);
  @Semantics.quantity.unitOfMeasure: 'uom'
      totqty    : menge_d;
      uom       : meins;
      remark     : abap.char(40);
      UUID      : sysuuid_x16;
      unitwt    : abap.dec(15,3);
      cdate        : abap.datn;
      createdby : abp_creation_user;
      createdon : abp_creation_date;
      

  @ObjectModel.filter.enabled: false
  _item : association [1..*] to ZPP_APPS01_ICE
           on _item.Uuid = $projection.UUID;
  @ObjectModel.filter.enabled: false
  _OP : association [1..*] to ZPP_OPERATION_CE
           on _OP.Uuid = $projection.UUID;         
}
