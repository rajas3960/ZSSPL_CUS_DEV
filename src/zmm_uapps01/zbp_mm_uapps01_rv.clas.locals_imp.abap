CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS PostGI FOR MODIFY
      IMPORTING keys FOR ACTION Header~PostGI RESULT result.

    METHODS GetData1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~GetData1.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zmm_uapps01_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_status).

**********************************************************************
    result = VALUE #( FOR ls_data IN lt_status
      ( %tky =  ls_data-%tky
        %features-%action-PostGI = COND #( WHEN ls_data-Docno IS NOT INITIAL
                                            THEN if_abap_behv=>fc-o-disabled
                                            ELSE if_abap_behv=>fc-o-enabled   )

          ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD PostGI.
**********************************************************************
    DATA: lt_hrdupd TYPE TABLE OF zmm_uapps01_tb1,
          ls_hrdupd TYPE zmm_uapps01_tb1.
********************************************************************
    READ ENTITIES OF zmm_uapps01_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_header)
    ENTITY Header BY \_Item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_items).
***********************************************************************
    DATA(ls_header) = lt_header[ 1 ].
    IF lt_items IS NOT INITIAL.
      DATA(lt_Podata) = lt_items.
    ENDIF.

**********************************************************************
    MODIFY ENTITIES OF i_materialdocumenttp PRIVILEGED
               ENTITY MaterialDocument
               CREATE FROM VALUE #( ( %cid                          = 'CID_001'
                                      goodsmovementcode             = '04'
                                      postingdate                   = ls_header-Postingdate
                                      documentdate                  = ls_header-Documentdate
                                      %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                      %control-postingdate                          = cl_abap_behv=>flag_changed
                                      %control-documentdate                         = cl_abap_behv=>flag_changed

                                  ) )
               ENTITY MaterialDocument
               CREATE BY \_MaterialDocumentItem
               FROM VALUE #( FOR ls_poitem IN lt_items (
                               %cid_ref = 'CID_001'
                               %target = VALUE #( ( %cid                           = 'CID_ITM_' && ls_poitem-Itemno
                                                    plant                          = ls_poitem-Plant
                                                    material                       = ls_poitem-Material
*                                                    Batch                          = ls_hdr-Batch
                                                    GoodsMovementType              = '309'
                                                    storagelocation                = ls_poitem-Sloc
                                                    QuantityInEntryUnit            = ls_poitem-Matqty
                                                    entryunit                      = ls_poitem-Uom
                                                    MaterialDocumentItemText       = ls_poitem-Hdrdesc
                                                    Batch                          = ls_poitem-Batch
                                                    IssgOrRcvgMaterial             = ls_poitem-Imaterial
                                                    IssgOrRcvgBatch                = ls_poitem-Ibatch
                                                    IssuingOrReceivingPlant        = ls_poitem-Plant
                                                    IssuingOrReceivingStorageLoc   = ls_poitem-Sloc
                                                    SalesOrder                     =  ls_poitem-Vbeln
                                                    SalesOrderItem                 = ls_poitem-Posnr
                                                    SpecialStockIdfgSalesOrder     = ls_poitem-Vbelnt
                                                    SpecialStockIdfgSalesOrderItem = ls_poitem-Posnrt
                                                    InventorySpecialStockType      = ls_poitem-Spls

*                                                    IssgOrRcvgSpclStockInd         = ls_poitem-Splc
*                                                    InventoryStockType             = 1




*                                                    CostCenter                     = ls_poitem-Costcenter
*                                                    GLAccount                      = ls_poitem-Glaccount
                                                    %control-plant                 = cl_abap_behv=>flag_changed

                                                    %control-material              = cl_abap_behv=>flag_changed
                                                    %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                                    %control-storagelocation       = cl_abap_behv=>flag_changed
                                                    %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                                    %control-entryunit             = cl_abap_behv=>flag_changed
                                                         %control-Batch                          = cl_abap_behv=>flag_changed
                                                     %control-IssgOrRcvgMaterial             = cl_abap_behv=>flag_changed
                                                     %control-IssgOrRcvgBatch                = cl_abap_behv=>flag_changed
                                                     %control-IssuingOrReceivingPlant        = cl_abap_behv=>flag_changed
                                                     %control-IssuingOrReceivingStorageLoc   = cl_abap_behv=>flag_changed
                                                      %control-SalesOrder                     = cl_abap_behv=>flag_changed
                                                    %control-SalesOrderItem                 = cl_abap_behv=>flag_changed
                                                    %control-SpecialStockIdfgSalesOrder     = cl_abap_behv=>flag_changed
                                                    %control-SpecialStockIdfgSalesOrderItem = cl_abap_behv=>flag_changed
                                                    %control-InventorySpecialStockType      = cl_abap_behv=>flag_changed
*                                                    %control-IssgOrRcvgSpclStockInd         = cl_abap_behv=>flag_changed
*                                                    %control-InventoryStockType             = cl_abap_behv=>flag_changed
*                                                    %control-CostCenter            = cl_abap_behv=>flag_changed
*                                                    %control-GLAccount             = cl_abap_behv=>flag_changed
                                                ) )                         ) )
               MAPPED   DATA(ls_mapped)
               FAILED   DATA(ls_failed)
               REPORTED DATA(ls_reported).
    IF ls_failed IS INITIAL.
      zbp_mm_uapps01_rv=>cv_mat_doc = ls_mapped.
      MOVE-CORRESPONDING ls_header TO ls_hrdupd.
      APPEND ls_hrdupd TO lt_hrdupd.
      zbp_mm_uapps01_rv=>gt_hrdupd = lt_hrdupd.
    ELSE.


    ENDIF.
**********************************************************************
    result = VALUE #( FOR ls_ord IN lt_header
                     ( %tky   = ls_ord-%tky
                       %param = ls_ord  ) ).
  ENDMETHOD.

  METHOD GetData1.
**********************************************************************
    DATA: lt_hrdcrt TYPE TABLE OF zmm_uapps01_tb1,
          ls_hrdcrt TYPE zmm_uapps01_tb1.
    DATA : lt_excel       TYPE TABLE OF zbp_mm_uapps01_rv=>gt_excel,
           lo_table_desc  TYPE REF TO cl_abap_tabledescr,
           lo_struc_descr TYPE REF TO cl_abap_structdescr.
**********************************************************************
    READ ENTITIES OF zmm_uapps01_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdrdata)
    BY \_Item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_Item).

**********************************************************************
    DATA(ls_hdrdata) = lt_hdrdata[ 1 ].
**********************************************************************

    ls_hrdcrt-uuid = ls_hdrdata-Uuid.
    ls_hrdcrt-createdat = ls_hdrdata-Createdat.
    ls_hrdcrt-createdby = ls_hdrdata-Createdby.
    ls_hrdcrt-documentdate = ls_hdrdata-Documentdate.
    ls_hrdcrt-lastchangedat = ls_hdrdata-Lastchangedat.
    ls_hrdcrt-lastchangedby = ls_hdrdata-Lastchangedby.
    ls_hrdcrt-postingdate = ls_hdrdata-Postingdate.
    ls_hrdcrt-attachment = ls_hdrdata-Attachment.
    ls_hrdcrt-mimetype  = ls_hdrdata-Mimetype.
    ls_hrdcrt-filename  = ls_hdrdata-Filename.

**********************************************************************
    APPEND ls_hrdcrt TO lt_hrdcrt.
    zbp_mm_uapps01_rv=>gt_hrdcrt = lt_hrdcrt.

    DATA: ATTCHEMENT TYPE xstring.
    ATTCHEMENT = ls_hdrdata-Attachment.

**********************************************************************

    IF  ls_hrdcrt-attachment IS NOT INITIAL.


      DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( iv_file_content =  ATTCHEMENT )->read_access(  ).
      DATA(lo_worksheet) = lo_xlsx->get_workbook(  )->worksheet->at_position( 1 ).
      DATA(lo_select_patrn) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(  )->from_row( xco_cp_xlsx=>coordinate->for_numeric_value( 2 ) )->get_pattern(   ).
      DATA(lo_execute) = lo_worksheet->select( lo_select_patrn )->row_stream(  )->operation->write_to( REF #( lt_excel ) ).
      lo_execute->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value  )->if_xco_xlsx_ra_operation~execute(  ).


      TRY .
          lo_table_desc ?= cl_abap_tabledescr=>describe_by_data( p_data = lt_excel ).
          lo_struc_descr ?= lo_table_desc->get_table_line_type(  ).
          DATA(lv_no_of_cols) = lines( lo_struc_descr->components ).
        CATCH cx_sy_move_cast_error.

      ENDTRY.

    ENDIF.

**********************************************************************

    DATA(ls_c) = lines( lt_Item ).

    zbp_mm_uapps01_rv=>gt_itm = VALUE #( FOR ls IN lt_excel      INDEX INTO lv WHERE ( material IS NOT INITIAL )  (
    uuid = ls_hrdcrt-uuid
    itemno = lv + ls_c
    material = ls-material
    imaterial = ls-imaterial
    plant     = ls-plant
    batch    =  ls-batch
    ibatch   = ls-ibatch
    sloc     = ls-stor
    isloc    = ls-istor
    matqty   = ls-qty
    uom      = ls-uom
    vbeln    = condense( | { condense( LS-vblen ) ALPHA = IN } | )
    posnr    = LS-posnr
    vbelnt   = condense( | { condense( LS-vbelnt ) ALPHA = IN } | )
    posnrt   = LS-posnrt
    inst     = LS-intc
    spls     = LS-spls
    splc     = ls-splc

     )   ).








  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZMM_UAPPS01_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZMM_UAPPS01_RV IMPLEMENTATION.

  METHOD save_modified.
    IF create-header IS NOT INITIAL.
      IF zbp_mm_uapps01_rv=>gt_hrdcrt IS NOT INITIAL.
        DATA(lt_hdrcrt) = zbp_mm_uapps01_rv=>gt_hrdcrt.
        MODIFY zmm_uapps01_tb1 FROM TABLE @lt_hdrcrt.
      ENDIF.
      IF zbp_mm_uapps01_rv=>gt_itm IS NOT INITIAL.
        MODIFY zmm_uapps01_tb2 FROM TABLE @zbp_mm_uapps01_rv=>gt_itm.
      ENDIF.
    ENDIF.
**********************************************************************

    IF zbp_mm_uapps01_rv=>cv_mat_doc IS NOT INITIAL .
      LOOP AT zbp_mm_uapps01_rv=>cv_mat_doc-MaterialDocument ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
        CONVERT KEY OF i_materialdocumenttp FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
        <fs_pr_mapped>-MaterialDocument = ls_pr_key-MaterialDocument .
      ENDLOOP.
      IF zbp_mm_uapps01_rv=>gt_hrdupd IS NOT INITIAL.
        DATA(lt_hdrupd) = zbp_mm_uapps01_rv=>gt_hrdupd.
        LOOP AT lt_hdrupd ASSIGNING FIELD-SYMBOL(<fs_hdrupd>).
          <fs_hdrupd>-docno = ls_pr_key-MaterialDocument.
        ENDLOOP.
        MODIFY zmm_uapps01_tb1 FROM TABLE @lt_hdrupd.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
