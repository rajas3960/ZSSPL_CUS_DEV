CLASS zbp_pp_apps01_re DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zpp_apps01_re.
CLASS-DATA : gt_hdr TYPE TABLE OF zpp_apps01_tb,
             gt_item TYPE TABLE OF zpp_apps01_itb,
             gt_item2 TYPE TABLE OF zpp_apps01_itb01,
             gt_item3 TYPE TABLE OF zpp_operation_db.

CLASS-DATA: gs_xmldata TYPE string,
            up_attach TYPE TABLE of zpp_form_db.
ENDCLASS.



CLASS ZBP_PP_APPS01_RE IMPLEMENTATION.
ENDCLASS.
