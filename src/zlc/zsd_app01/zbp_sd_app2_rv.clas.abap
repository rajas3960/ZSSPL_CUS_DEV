CLASS zbp_sd_app2_rv DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zsd_app2_rv.
PUBLIC SECTION.
CLASS-DATA : gt_update type table of zsd_app2_tb,
             gt_salestb type table of zsd_app2_tb,
             cv_sal_doc TYPE RESPONSE FOR MAPPED I_SalesOrderTP,
             GT_LCTB TYPE TABLE OF zlc_app_tb,
             gt_lc_1 type zsd_app2_rv-Mark.
ENDCLASS.



CLASS ZBP_SD_APP2_RV IMPLEMENTATION.
ENDCLASS.
