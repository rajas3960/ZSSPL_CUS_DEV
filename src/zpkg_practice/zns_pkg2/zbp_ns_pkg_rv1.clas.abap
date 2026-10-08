CLASS zbp_ns_pkg_rv1 DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zns_pkg_rv1.
PUBLIC SECTION.
CLASS-DATA : gt_crtdat type table of zns_pkg_tb1,
             gt_crtidat type table of zns_pkg_tb2.
types :  BEGIN OF gt_gx_ls,
         CLIENT type string,
        UUID type string,
        ITEM type string,
       sonumber  type string,
       PLANT  type string,
       soldtoparty  type string,
      PHONENO   type string,
      EMAIL TYPE STRING,
         end of gt_gx_ls.


ENDCLASS.



CLASS ZBP_NS_PKG_RV1 IMPLEMENTATION.
ENDCLASS.
