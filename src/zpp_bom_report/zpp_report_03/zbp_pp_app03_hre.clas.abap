CLASS zbp_pp_app03_hre DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zpp_app03_hre.
        CLASS-DATA : gt_hdr   TYPE TABLE OF zpp_app03_db,
               gt_item  TYPE TABLE OF zpp_app03_idb,
               gt_item2 TYPE TABLE OF zpp_app03_idb02.


CLASS-DATA: gs_xmldata TYPE string,
            up_attach TYPE TABLE of ZPP_REL_DB.
ENDCLASS.



CLASS ZBP_PP_APP03_HRE IMPLEMENTATION.
ENDCLASS.
