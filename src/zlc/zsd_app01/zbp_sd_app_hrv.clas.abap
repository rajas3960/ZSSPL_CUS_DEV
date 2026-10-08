CLASS zbp_sd_app_hrv DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zsd_app_hrv.
PUBLIC SECTION.
CLASS-DATA : gt_saleshdr  TYPE TABLE OF zsd_app_h,
             gt_salesudp  TYPE TABLE OF zsd_app_h,
             gt_salesitm  TYPE TABLE OF zsd_app_itb,
             cv_sal_doc TYPE RESPONSE FOR MAPPED I_SalesOrderTP,
             GT_LCDATA TYPE TABLE OF zlc_app_tb.
             CLASS-DATA fech_lcdata.
ENDCLASS.



CLASS ZBP_SD_APP_HRV IMPLEMENTATION.
ENDCLASS.
