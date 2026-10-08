@EndUserText.label: 'Custom Entity For Header'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_APPS05_PRINTJS'
define custom entity ZPP_APPS05_CE
  // with parameters parameter_name : parameter_type
{
  key vrno        : abap.char(12);
     jobst       : abap.char(12);
      werks       : abap.char(40);
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
      totwithst   : abap.dec(15,0);
      plndt       : abap.dats;
      curdate        : abap.datn;
      curtime        : abap.timn;
      Preparedby  : abap.char(80);
      Approvedby  : abap.char(80);
      contract       : abap.char( 81 );
      galva         : abap.char(100);
      remark        : abap.char(100);
@ObjectModel.filter.enabled  : false
      _item :association [1..*] to ZPP_APPS05_ITMS on  _item.Vrno = $projection.vrno;
  

}
