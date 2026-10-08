CLASS zbp_pp_apps05_rv DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zpp_apps05_rv.
  CLASS-DATA : gt_hdr        TYPE TABLE OF zpp_apps05_htb,
               gt_item       TYPE TABLE OF zpp_apps05_itb,
               gt_item2      TYPE TABLE OF zpp_apps05_itb2,
               gt_item3      TYPE TABLE OF zpp_apps05_itb3,
               gt_item5      TYPE TABLE OF zpp_apps05_itb5,
               gt_item4      TYPE TABLE OF zpp_apps05_itb4,
               gt_att type table of ZPP_APPS05_ATT,
               gt_totswt type p LENGTH 15 DECIMALS 3,
               lt_components TYPE RANGE OF matnr,
               gt_item6 type table of zpp_apps05_itb6,
               gt_iteb7 type table of zpp_apps05_itb7,
               gt_iteb7A type table of zpp_apps05_itb7,
               gt_item8 type table of zpp_apps05_itb8,
               gt_del  type table of ZPP_APPS05_DELIM,
               cv_mat_doc  TYPE RESPONSE FOR MAPPED I_MaterialDocumentTP.
 types : BEGIN OF gt_excel,
         clum1 type string,
         clum2 type string,
         clum3 type string,
         clum4 type string,
         clum5 type string,
         END OF gt_excel.


ENDCLASS.



CLASS ZBP_PP_APPS05_RV IMPLEMENTATION.
ENDCLASS.
