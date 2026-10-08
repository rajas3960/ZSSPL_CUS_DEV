CLASS zbp_mm_uapps01_rv DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zmm_uapps01_rv.
  PUBLIC SECTION.
    CLASS-DATA : gt_hrdcrt  TYPE TABLE OF zmm_uapps01_tb1,
                 gt_hrdupd  TYPE TABLE OF zmm_uapps01_tb1,
                 gt_itmcrt type table of zmm_uapps01_tb2,
                 gt_itm     TYPE TABLE OF zmm_uapps01_tb2,
                 cv_mat_doc TYPE RESPONSE FOR MAPPED I_MaterialDocumentTP.

    TYPES : BEGIN OF gt_excel,
              Material  TYPE string,
              Imaterial TYPE string,
              plant     TYPE string,
              stor      TYPE string,
              istor     TYPE string,
              batch     TYPE string,
              ibatch    TYPE string,
              qty       TYPE string,
              uom       TYPE string,
              vblen     type string,
              posnr     type string,
              vbelnt     type string,
              posnrt     type string,
              intc       type string,
              splc       type string,
              spls       type string,
            END OF gt_excel.
ENDCLASS.



CLASS ZBP_MM_UAPPS01_RV IMPLEMENTATION.
ENDCLASS.
