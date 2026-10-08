CLASS zbp_pp_apps03_rv DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zpp_apps03_rv.
  CLASS-DATA : gt_hdr   TYPE TABLE OF zpp_apps03_htb,
               gt_item  TYPE TABLE OF zpp_apps03_itb1,
               gt_item2 TYPE TABLE OF zpp_apps03_itb2,
               gt_item3 type table of zpp_apps3_itb3.

   TYPES : get_head TYPE table of zpp_apps03_htb.
    TYPES : get_item type table of zpp_apps03_itb2.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter im_head | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter im_item | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter ex_base_64 | <p class="shorttext synchronized" lang="en"></p>
    CLASS-METHODS Get_pdf_xml
        IMPORTING
            im_head TYPE get_head
            im_item TYPE get_item
        EXPORTING
            ex_base_64 TYPE string.
ENDCLASS.



CLASS ZBP_PP_APPS03_RV IMPLEMENTATION.


METHOD get_pdf_xml.
**********************************************************************
if im_head is not INITIAL.
data(ls_hdr) = im_head[ 1 ].
select single from I_Plant FIELDS PlantName where Plant = @ls_hdr-werks into @data(Wa_plant).
select single from I_BusinessUserBasic fields PersonFullName where UserID = @ls_hdr-createdby into @data(wa_issueby).
endif.
**********************************************************************


**********************************************************************

*loop at Lt_SECTION into data(ls_section).
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
|<Proj>| && ls_hdr-project && |</Proj>| &&
|<Sono>| && 'test' && |</Sono>| &&
|<Sec>| && ls_hdr-sectmat && |</Sec>| &&
|<Indtno>| && ls_hdr-purno && |</Indtno>| &&
|<Remk>| && 'test' && |</Remk>| &&
|<godon>| && 'test' && |</godon>| &&
|</leftsub>| &&
|<rightsub>| &&
|<Planno>| && 'test' && |</Planno>| &&
|<Plandt>| && sy-datum && |</Plandt>| &&
|<Jobno>| && 'test' && |</Jobno>| &&
|<TargetDt>| && 'test' && |</TargetDt>| &&
|<UnitWt>| && ls_hdr-unitwet && |</UnitWt>| &&
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
|<sno>| &&  |{ ls_item-sno ALPHA = OUT }| && |</sno>| &&
|<marno>| && ls_item-matnr && |</marno>| &&
|<jobno>| && 'test' && |</jobno>| &&
|<lenth>| && ls_item-length && |</lenth>| &&
|<width>| && ls_item-width && |</width>| &&
|<wtpc>| && ls_item-wetpc && |</wtpc>| &&
|<plqty>| && ls_item-reqty && |</plqty>| &&
|<plwt>| && ls_item-netwt && |</plwt>| &&
|<process>| && 'gesg' && |</process>| &&
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
*ENDLOOP.

ENDMETHOD .
ENDCLASS.
