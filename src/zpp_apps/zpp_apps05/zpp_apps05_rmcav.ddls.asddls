@EndUserText.label: 'Row Material Req. Cutting Allocation Custom Entity'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_APPS05_PRINTCARM'
define custom entity ZPP_APPS05_RMCAV
// with parameters parameter_name : parameter_type
{
  key vrno        : abap.char(12);
       srcid      :  abap.char(20);
      werks       : abap.char(40);
      vbeln       : vbeln_va;
      prod        : aufnr;
      project     : abap.char( 200 );
      projectname : maktx;
      sectmat     : matnr;
      plndt       : abap.dats;
      unitwet     : abap.dec(10,3);
      purno       : abap.char(30);
      delmark     : abap.char(1);
      status      : abap.char(1);
      gengt       : abap.char(1);
      vrcuting    : abap.char(30);
      totlentq    : abap.dec(15,0);
      totwithst   : abap.dec(15,0);
      currdate    : abap.datn;
      currtime    : abap.timn;
        Preparedby  : abap.char(80);
      Approvedby  : abap.char(80);
       contract       : abap.char( 81 );
@ObjectModel.filter.enabled  : false
   _item :association [1..*] to ZPP_APPS05_RMITEM on  _item.Vrno = $projection.vrno;
   @ObjectModel.filter.enabled  : false
   _item2 : association[1..*] to ZPP_APPS05_ITEM8 on _item2.Vrno = $projection.vrno;
  
  
}
