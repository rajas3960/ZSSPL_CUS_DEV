CLASS zbp_pp_apps01_rv DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zpp_apps01_rv.
CLASS-DATA : gt_hdr type table of zpp_apps01_htb1,
             gt_item3 type table of zpp_apps01_itb3,
             gt_item1 type table of zpp_apps01_itb1,
             gt_citem type table of zpp_apps01_itb2,
             gt_matnr type zpp_apps01_idtb1-matnr.

*TYPES: BEGIN OF ty_mfg_data,
*         ManufacturingOrder             TYPE zpp_app03_ord-ManufacturingOrder,
*         ManufacturingOrderItem         TYPE zpp_app03_ord-ManufacturingOrderItem,
*         Batch                          TYPE zpp_app03_ord-Batch,
*         CompanyCode                    TYPE zpp_app03_ord-CompanyCode,
*         Material                       TYPE zpp_app03_ord-Material,
*         ProductionPlant                TYPE zpp_app03_ord-ProductionPlant,
*         SalesOrder                     TYPE zpp_app03_ord-SalesOrder,
*         SalesOrderItem                 TYPE zpp_app03_ord-SalesOrderItem,
*         MfgOrderItemPlannedTotalQty    TYPE zpp_app03_ord-MfgOrderItemPlannedTotalQty,
*         ProductionUnit                 TYPE zpp_app03_ord-ProductionUnit,
*         ProductType                    TYPE zpp_app03_ord-ProductType,
*         ManufacturingOrderType         TYPE zpp_app03_ord-ManufacturingOrderType,
*         ProductName                    TYPE zpp_app03_ord-ProductName,
*         StorageLocation                TYPE zpp_app03_ord-StorageLocation,
*         Reservation                    TYPE zpp_app03_ord-Reservation,
*         reqty                          TYPE zpp_app03_itb2-reqty,
*       END OF ty_mfg_data.
**********************************************************************

    TYPES : get_head TYPE table of zpp_apps01_htb1.
    TYPES : get_item type table of zpp_apps01_itb1.

    CLASS-METHODS Get_pdf_xml
        IMPORTING
            im_head TYPE get_head
            im_item TYPE get_item
        EXPORTING
            ex_base_64 TYPE string.

ENDCLASS.



CLASS ZBP_PP_APPS01_RV IMPLEMENTATION.


METHOD get_pdf_xml.
**********************************************************************
if im_head is not INITIAL.
data(ls_hdr) = im_head[ 1 ].
select single from I_Plant WITH PRIVILEGED ACCESS FIELDS PlantName  where Plant = @ls_hdr-werks into @data(Wa_plant).
select single from I_BusinessUserBasic fields PersonFullName where UserID = @ls_hdr-createdby into @data(wa_issueby).
endif.
**********************************************************************
if zbp_pp_apps01_rv=>gt_matnr is not INITIAL.
select single from I_ProductText fields ProductName where Product = @zbp_pp_apps01_rv=>gt_matnr and Language = 'E' into @data(Wa_material).
endif.
**********************************************************************
IF im_item IS NOT INITIAL.
DATA(LW_ITEM) = im_item[ 1 ].
SELECT  FROM zpp_apps01_itb2 FIELDS matnr WHERE orderno = @lw_item-orderno  GROUP BY matnr
INTO  table @DATA(Lt_SECTION)  .

ENDIF.

**********************************************************************

loop at Lt_SECTION into data(ls_section).
data(lv_xml) =
|<?xml version="1.0" encoding="UTF-8"?>| &&
|<form1>| &&
|<Mainpage>| &&

    "---------------------- HEADER ----------------------"
|<Header>| &&
|<Her>| &&
|<Pcde>| && Wa_plant && |</Pcde>| &&
|</Her>| &&
|<Herw/>| &&
|</Header>| &&

    "-------------------- SUBHEADER ---------------------"
|<Subheader>| &&
|<leftsub>| &&
|<Proj>| && Wa_material && |</Proj>| &&
|<Sono>| && 'test' && |</Sono>| &&
|<Sec>| && LS_SECTION-matnr && |</Sec>| &&
|<Indtno>| && 'test' && |</Indtno>| &&
|<Remk>| && ls_hdr-jobdesc && |</Remk>| &&
|<godon>| && 'test' && |</godon>| &&
|</leftsub>| &&
|<rightsub>| &&
|<Planno>| && 'test' && |</Planno>| &&
|<Plandt>| && sy-datum && |</Plandt>| &&
|<Jobno>| && ls_hdr-jobsheetno && |</Jobno>| &&
|<TargetDt>| && 'test' && |</TargetDt>| &&
|<UnitWt>| && lw_item-untwgh && |</UnitWt>| &&
|<Plnt>| && 'test' && |</Plnt>| &&
|<Embossing>| && 'test' && |</Embossing>| &&
|<batch>| && 'test' && |</batch>| &&
|<pri>| && 'test' && |</pri>| &&
|</rightsub>| &&
|</Subheader>|  .

    "----------------------- ITEM LOOP -----------------------"
    "" Loop for items: im_item


LOOP AT im_item INTO DATA(ls_item).

  lv_xml = lv_xml &&
|<Item>| &&
|<Table>| &&
|<HeaderRow/>| &&
|<Body>| &&
|<sno>| &&  |{  ls_item-sno ALPHA = OUT }| && |</sno>| &&
|<marno>| && ls_item-matnr && |</marno>| &&
|<jobno>| && ls_hdr-jobsheetno && |</jobno>| &&
|<lenth>| && ls_item-matlent && |</lenth>| &&
|<width>| && ls_item-matwidth && |</width>| &&
|<wtpc>| && ls_item-wgtpc && |</wtpc>| &&
|<plqty>| && ls_item-reqty && |</plqty>| &&
|<plwt>| && ls_item-totwgh && |</plwt>| &&
|<process>| && ls_item-operation && |</process>| &&
|<ordno>| && |{ ls_item-orderno  ALPHA = OUT }|  && |</ordno>| &&
|</Body>| &&
|<FooterRow>| &&
|<plqty>| && 'test' && |</plqty>| &&
|<planwt>| && 'test' && |</planwt>| &&
|</FooterRow>| &&
|</Table>| &&
|</Item>|.
ENDLOOP.
lv_xml = lv_xml &&
    "---------------------- FOOTER / APP ----------------------"
|<App>| &&
|<preds>| && wa_issueby && |</preds>| &&
|<issue>| && 'test' && |</issue>| &&
|</App>| &&
|</Mainpage>| &&
|</form1>|.


ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).
ENDLOOP.

ENDMETHOD.
ENDCLASS.
