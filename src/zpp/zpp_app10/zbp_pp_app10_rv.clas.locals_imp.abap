CLASS lhc_ZPP_APP10_RV DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zpp_app10_rv RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zpp_app10_rv RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zpp_app10_rv RESULT result.

    METHODS goodrecipts FOR MODIFY
      IMPORTING keys FOR ACTION zpp_app10_rv~goodrecipts RESULT result.

ENDCLASS.

CLASS lhc_ZPP_APP10_RV IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD goodrecipts.
    READ ENTITIES OF zpp_app10_rv IN LOCAL MODE ENTITY zpp_app10_rv ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_hdr).
    DATA(ls_jobsheet) = lt_hdr[ 1 ]-jobshtnum.

    SELECT * FROM zpp_app10_ipv1 WHERE Jobshtnum = @ls_jobsheet INTO TABLE @DATA(lt_item).
    IF lt_item IS NOT INITIAL.
      MODIFY ENTITIES OF i_materialdocumenttp PRIVILEGED
                 ENTITY MaterialDocument
                 CREATE FROM VALUE #( ( %cid                          = 'CID_001'
                                        goodsmovementcode             = '02'
                                        postingdate                   = cl_abap_context_info=>get_system_date( )
                                        documentdate                  = cl_abap_context_info=>get_system_date( )
                                        %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                        %control-postingdate                          = cl_abap_behv=>flag_changed
                                        %control-documentdate                         = cl_abap_behv=>flag_changed
                                    ) )
                 ENTITY MaterialDocument
                 CREATE BY \_MaterialDocumentItem
                 FROM VALUE #( FOR ls1 IN lt_item INDEX INTO idx (
                                 %cid_ref = 'CID_001'
                                 %target = VALUE #( ( %cid                           = 'CID_ITM_' && idx
                                                      plant                          = ls1-plant
                                                      material                       = ls1-matnr
                                                      GoodsMovementType              = '101'
                                                      storagelocation                = 'FY01'
                                                      QuantityInEntryUnit            = ls1-Reqty
                                                      entryunit                      = ls1-uom
                                                      ManufacturingOrder             =  ls1-orderno
*                                                  SalesOrder                     = ls1-Vbeln
*                                                  SalesOrderItem                 = ls1-Soitem
*                                                  InventorySpecialStockType      = 'E'
*                                                  InventoryStockType = '01'
                                                      GoodsMovementRefDocType = 'F'
*                                                      SpecialStockIdfgSalesOrder      = ls1-Vbeln
*                                                      SpecialStockIdfgSalesOrderItem  = ls1-Soitem

                                                      %control-plant                 = cl_abap_behv=>flag_changed
                                                      %control-material              = cl_abap_behv=>flag_changed
                                                      %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                                      %control-storagelocation       = cl_abap_behv=>flag_changed
                                                      %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                                      %control-entryunit             = cl_abap_behv=>flag_changed
                                                      %control-ManufacturingOrder   =  cl_abap_behv=>flag_changed
*                                                  %control-SalesOrder =  cl_abap_behv=>flag_changed
*                                                  %control-SalesOrderItem =  cl_abap_behv=>flag_changed
*                                                  %control-InventorySpecialStockType = cl_abap_behv=>flag_changed
*                                                  %control-InventoryStockType = cl_abap_behv=>flag_changed
*                                                        %control-SpecialStockIdfgSalesOrder =  cl_abap_behv=>flag_changed
*                                                      %control-SpecialStockIdfgSalesOrderItem =  cl_abap_behv=>flag_changed
                                                  ) )


                             ) )
                 MAPPED   DATA(ls_create_mapped)
                 FAILED   DATA(ls_create_failed)
                 REPORTED DATA(ls_create_reported).
      IF ls_create_failed IS INITIAL.
        zbp_pp_app10_rv=>cv_mat_doc = ls_create_mapped.
      ELSE.
      ENDIF.

    ENDIF.


    result = VALUE #( FOR ls_ord IN lt_hdr
                          (  %tky  = ls_ord-%tky
                           %param = ls_ord ) ).


  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APP10_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APP10_RV IMPLEMENTATION.

  METHOD save_modified.
    IF zbp_pp_app10_rv=>cv_mat_doc IS NOT INITIAL .
      LOOP AT zbp_pp_app10_rv=>cv_mat_doc-MaterialDocument ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
        CONVERT KEY OF i_materialdocumenttp FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
        <fs_pr_mapped>-MaterialDocument = ls_pr_key-MaterialDocument .
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
