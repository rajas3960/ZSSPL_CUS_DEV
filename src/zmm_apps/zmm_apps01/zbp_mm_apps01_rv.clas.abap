CLASS zbp_mm_apps01_rv DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zmm_apps01_rv.
  TYPES : BEGIN OF gt_gx_ls,

         purreqitm  TYPE numc5,          " abap.numc(5)
         material   TYPE matnr,
         matdesc    TYPE maktx,
         length     TYPE p LENGTH 10 DECIMALS 2,
         width      TYPE p LENGTH 10 DECIMALS 2,
         pices      TYPE p LENGTH 10 DECIMALS 2,
          reqqty     TYPE p LENGTH 10 DECIMALS 3,
         plant      TYPE werks_d,
*         plantdesc  TYPE string,
*         purgrp     TYPE ekgrp,
*         purgrpdesc TYPE string,
*         delvdate   TYPE dats,
*         purorg     TYPE ekorg,
*
*         uom        TYPE meins,
*         valprice   TYPE p LENGTH 13 DECIMALS 2,
*         totvalue   TYPE p LENGTH 13 DECIMALS 2,
*         currency   TYPE waers,



          END OF gt_gx_ls.
TYPES : BEGIN OF gt_gx_ls1,

         purreqitm  TYPE STRING,          " abap.numc(5)
         material   TYPE STRING,
         matdesc    TYPE STRING,
         length     TYPE STRING,
         width      TYPE STRING,
         pices      TYPE STRING,
          reqqty     TYPE STRING,
         plant      TYPE STRING,
*         plantdesc  TYPE string,
*         purgrp     TYPE ekgrp,
*         purgrpdesc TYPE string,
*         delvdate   TYPE dats,
*         purorg     TYPE ekorg,
*
*         uom        TYPE meins,
*         valprice   TYPE p LENGTH 13 DECIMALS 2,
*         totvalue   TYPE p LENGTH 13 DECIMALS 2,
*         currency   TYPE waers,



          END OF gt_gx_ls1.

CLASS-DATA : gt_item type table of zmm_apps01_itb,
             gt_hdr type table of zmm_apps01_htb,
             gs_hdr type zmm_apps01_htb.
CLASS-DATA: cv_pr_doc  TYPE RESPONSE FOR MAPPED  i_purchaserequisitiontp.
ENDCLASS.



CLASS ZBP_MM_APPS01_RV IMPLEMENTATION.
ENDCLASS.
