@EndUserText.label: 'Custom Entity For Raw Material Req.'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_APPS05_PRINTRM'
define custom entity ZPP_APPS05_RM
// with parameters parameter_name : parameter_type
{
   key vrno        : abap.char(12);
     jobst       : abap.char(12);
      werks       : werks_d;
      vbeln       : vbeln_va;
      prod        : aufnr;
      project     : matnr;
      projectname : maktx;
      sectmat     : matnr;
      unitwet     : abap.dec(10,3);
      purno       : abap.char(30);
      delmark     : abap.char(1);
      status      : abap.char(1);
      gengt       : abap.char(1);
      vrcuting    : abap.char(30);
      totlentq    : abap.dec(15,0);
      totwithst   : abap.dec(15,3);
      totwithmk   : abap.dec(15,3);
      requestdt   : abap.dats;
      currdate    : abap.datn;
      currtime    : abap.timn;
      preparedby  : abap.char(80);
      Approvedby  : abap.char(80);
      Matno       : mblnr;
       contract       : abap.char( 81 );
@ObjectModel.filter.enabled  : false
      _item :association [1..*] to ZPP_APPS05_ITEM8 on  _item.Vrno = $projection.vrno;
 @ObjectModel.filter.enabled  : false
      _item2 :association [1..*] to zmm_length_ve on  _item2.Vrno = $projection.vrno; 
}
