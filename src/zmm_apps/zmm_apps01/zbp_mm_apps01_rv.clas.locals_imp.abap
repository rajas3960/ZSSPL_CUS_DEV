CLASS lhc__item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS upexl FOR MODIFY
      IMPORTING keys FOR ACTION _item~upexl RESULT result.
    METHODS gtidata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _item~gtidata1.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _item RESULT result.

ENDCLASS.

CLASS lhc__item IMPLEMENTATION.

  METHOD upexl.

    READ ENTITIES OF zmm_apps01_rv IN LOCAL MODE
  ENTITY _hdr
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_hdr)
  BY \_item ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_item).


  ENDMETHOD.

  METHOD gtidata1.
    DATA : gs_item TYPE zmm_apps01_itb.

    READ ENTITIES OF zmm_apps01_rv IN LOCAL MODE
  ENTITY _hdr
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_hdr).



    READ ENTITIES OF zmm_apps01_rv IN LOCAL MODE
    ENTITY  _item ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

**********************************************************************

    LOOP AT lt_item INTO DATA(ls).

      SELECT SINGLE * FROM zmm_apps01_prodv
      WHERE Product = @ls-Material AND Plant = @ls-Plant
      INTO @DATA(ls_val).

      gs_item-uuid = lt_hdr[ 1 ]-Uuid.
      SELECT SINGLE MAX( purreqitm ) FROM zmm_apps01_itb WHERE uuid = @gs_item-uuid INTO @DATA(ls_sno).
      IF ls_sno IS NOT INITIAL.
        gs_item-purreqitm = ls_sno + 10.
      ELSE.
        gs_item-purreqitm  =  10.
      ENDIF.

      gs_item-currency = ls-Currency.
      gs_item-delvdate = sy-datlo + 45.
      gs_item-length = ls-length.
      gs_item-width = ls-width.
      gs_item-pices = ls-pices.
      gs_item-matdesc = ls_val-ProductDescription .
      gs_item-material = ls-material.
      gs_item-matgrp = ls_val-ProductGroup.
      gs_item-purorg = ls_val-DefaultPurchasingOrganization.
      gs_item-extmatgrp = ls_val-ExternalProductGroup.
      gs_item-purgrp = ls_val-PurchasingGroup.
      gs_item-plant = ls-plant.
      gs_item-plantdesc = ls_val-PlantName.
      IF ls_val-ProductGroup = 'ANGLE' .
        gs_item-reqqty = ls-Length * ls_val-yy1_unit_wgt_prd / 1000 * ls-Pices.
      ELSEIF ls_val-ProductGroup = 'PLATE'  .
        gs_item-reqqty = ls-Reqqty.
      ENDIF.
      gs_item-valprice = ls_val-valuprice.
      gs_item-totvalue = ls-reqqty * ls_val-valuprice.


      APPEND gs_item TO zbp_mm_apps01_rv=>gt_item.
      CLEAR gs_item.

    ENDLOOP.






  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zmm_apps01_rv IN LOCAL MODE
    ENTITY _item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
**********************************************************************

    result = VALUE #( FOR ls_data IN lt_item
    (   %tky =  ls_data-%tky
%features-%field-Length =  COND #( WHEN ls_data-Plant IS NOT INITIAL AND ls_data-Material IS NOT INITIAL

                                                THEN if_abap_behv=>fc-f-mandatory

                                                ELSE if_abap_behv=>fc-f-unrestricted  )
%features-%field-Pices = COND #( WHEN ls_data-Plant IS NOT INITIAL AND ls_data-Material IS NOT INITIAL

                                                THEN if_abap_behv=>fc-f-mandatory

                                                ELSE if_abap_behv=>fc-f-unrestricted  )
%features-%field-Width = COND #( WHEN ls_data-Plant IS NOT INITIAL AND ls_data-Material IS NOT INITIAL

                                                THEN if_abap_behv=>fc-f-mandatory

                                                ELSE if_abap_behv=>fc-f-unrestricted  )

                                                ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.

*    METHODS earlynumbering_cba_Item FOR NUMBERING
*      IMPORTING entities FOR CREATE _hdr\_Item.

    METHODS CrtPr FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~CrtPr RESULT result.

    METHODS GetData1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~GetData1.
    METHODS upexl FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~upexl RESULT result.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zmm_apps01_rv IN LOCAL MODE
 ENTITY _hdr
 ALL FIELDS WITH CORRESPONDING #( keys )
 RESULT FINAL(lt_hdr).

    result = VALUE #( FOR ls_hdr IN lt_hdr (
     %tky                            = ls_hdr-%tky
      %action-CrtPr = COND #( WHEN ls_hdr-Mark IS INITIAL
                               THEN if_abap_behv=>fc-o-enabled
                               ELSE if_abap_behv=>fc-o-disabled )
      %action-upexl =    COND #( WHEN ls_hdr-Mark IS INITIAL
                               THEN if_abap_behv=>fc-o-enabled
                               ELSE if_abap_behv=>fc-o-disabled )
  %action-Edit = COND #( WHEN ls_hdr-Purreqnum IS NOT INITIAL
                                               THEN
                                               if_abap_behv=>fc-o-disabled
                                               ELSE
                                               if_abap_behv=>fc-o-enabled )
    %features-%delete = COND #( WHEN ls_hdr-Purreqnum IS NOT INITIAL
                                               THEN
                                               if_abap_behv=>fc-o-disabled
                                               ELSE
                                               if_abap_behv=>fc-o-enabled )


                                               ) ).






  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

*  METHOD earlynumbering_cba_Item.
*READ ENTITIES OF zmm_apps01_rv IN LOCAL MODE
*ENTITY _hdr
*ALL FIELDS WITH CORRESPONDING #( entities )
*RESULT data(lt_hdr)
*BY \_item ALL FIELDS WITH CORRESPONDING #( entities )
*RESULT data(lt_item).
*
*data(ls_uuid) = lt_hdr[ 1 ]-uuid .
*
*if lt_item is not INITIAL.
*select single max( Purreqitm  )  from @lt_item AS item WHERE Uuid = @ls_uuid into @data(lv_pat_id).
*
*
*lv_pat_id = COND #( WHEN lv_pat_id IS NOT INITIAL THEN lv_pat_id + 10
*                    ELSE 10 ).
*
*DATA(ls_target) = entities[ 1 ]-%target[ 1 ].
*ls_target-Purreqitm = lv_pat_id.
*
*APPEND CORRESPONDING #( ls_target ) TO mapped-_item.
*endif.
*  ENDMETHOD.

  METHOD CrtPr.

    READ ENTITIES OF zmm_apps01_rv IN LOCAL MODE
  ENTITY _hdr
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_hdr)
  BY \_item ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_item).
    DATA(ls_header) = lt_hdr[ 1 ].


    IF ls_header-%is_draft IS INITIAL.

      IF lt_item IS NOT INITIAL.
        MODIFY ENTITIES OF i_purchaserequisitiontp PRIVILEGED
        ENTITY purchaserequisition
                 CREATE FIELDS ( purchaserequisitiontype )
                 WITH VALUE #(  ( %cid                    = 'CID_1'
                                  purchaserequisitiontype = ls_header-Purreqtyp ) )

                CREATE BY \_purchaserequisitionitem
                FIELDS ( plant
*                       purchaserequisitionitemtext
*                       accountassignmentcategory
                         requestedquantity
                         baseunit
                         material
                         DeliveryDate
                         purchaserequisitionprice
                         YY1_Lengths_PRI
                         YY1_Widths_PRI
                         YY1_No_of_Pieces_PRI
                         StorageLocation
*                       purreqnitemcurrency
*                       materialgroup
*                       purchasinggroup
*                       purchasingorganization
*                     multipleacctassgmtdistribution

                            )
                WITH VALUE #( FOR ls_item IN lt_item
                              (    %cid_ref = 'CID_1'
                                   %target = VALUE #(
                                                    (  %cid                        = 'ItmCID_' && ls_item-Purreqitm
                                                       plant                       = ls_item-Plant
*                                                     purchaserequisitionitemtext = ''
*                                                     accountassignmentcategory   = ''
                                                       requestedquantity           = ls_item-Reqqty
                                                       baseunit                    = ls_item-Uom
                                                       material                    = ls_item-Material
                                                       DeliveryDate                = ls_item-Delvdate
                                                       purchaserequisitionprice    = ls_item-Valprice
                                                        YY1_Lengths_PRI            = ls_item-Length
                                                        YY1_Widths_PRI    = ls_item-Width
                                                        YY1_No_of_Pieces_PRI = ls_item-Pices
                                                        StorageLocation = 'RY01'
*                                                     purreqnitemcurrency         = ls_item-Currency
*                                                     materialgroup               = ls_item-Matgrp
*                                                     purchasinggroup             = ls_item-Purgrp
*                                                     purchasingorganization      = ls_item-Purorg
*                                                   multipleacctassgmtdistribution = '1'
                                                       )
                                                    )
                               )
                             )

              REPORTED DATA(ls_reported)
              MAPPED DATA(ls_mapped)
              FAILED DATA(ls_failed).

**********************************************************************
        IF ls_failed IS INITIAL.
          zbp_mm_apps01_rv=>cv_pr_doc-purchaserequisition = ls_mapped-purchaserequisition.
          MOVE-CORRESPONDING ls_header TO zbp_mm_apps01_rv=>gs_hdr.
          APPEND zbp_mm_apps01_rv=>gs_hdr TO zbp_mm_apps01_rv=>gt_hdr.
*        zbp_mm_app02_rv=>gt_hdrupd = lt_hdrupd.
        ENDIF.
        READ ENTITIES OF zmm_apps01_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT FINAL(lt_hdr2).
        result = VALUE #( FOR ls_ord IN lt_hdr2
                       ( %tky   = ls_ord-%tky
                         %param = ls_ord ) ).

      ENDIF.
    ELSE.

      DATA(lv_msg2) = |You are in Edit Mode Please Save the Document|.
      APPEND VALUE #( %tky = ls_header-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_header-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg2 )   )
             TO reported-_hdr.
    ENDIF.


  ENDMETHOD.

  METHOD GetData1.
    DATA : gs_data TYPE zmm_apps01_htb.
    READ ENTITIES OF zmm_apps01_rv IN LOCAL MODE
  ENTITY _hdr
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_hdr).
    DATA(ls_hdr) = lt_hdr[ 1 ].
    MOVE-CORRESPONDING ls_hdr TO gs_data.

    APPEND gs_data TO zbp_mm_apps01_rv=>gt_hdr.





  ENDMETHOD.

  METHOD upexl.
**********************************************************************
    READ ENTITIES OF zmm_apps01_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
    DATA(ls_header) = lt_hdr[ 1 ].

    IF ls_header-%is_draft IS INITIAL.

      DATA(ls_uuid) = lt_hdr[ 1 ]-Uuid.
**********************************************************************
      DATA : lt_excel       TYPE STANDARD TABLE OF zbp_mm_apps01_rv=>gt_gx_ls,
             lt_excel1      TYPE STANDARD TABLE OF zbp_mm_apps01_rv=>gt_gx_ls1,
             lt_itd         TYPE TABLE OF zmm_apps01_itb,
             ls_itd         TYPE  zmm_apps01_itb,
             lo_table_desc  TYPE REF TO cl_abap_tabledescr,
             lo_struc_descr TYPE REF TO cl_abap_structdescr,
             zchar18        TYPE c LENGTH 18,
             attchement     TYPE xstring.



      DATA(lv_attach1) = keys[ 1 ]-%param-_streamproperties-zattachment.
      DATA(lv_attach) = lv_attach1.
      attchement = lv_attach.
      IF lv_attach IS NOT INITIAL.
        DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( iv_file_content = lv_attach )->read_access(  ).
        DATA(lo_worksheet) = lo_xlsx->get_workbook(  )->worksheet->at_position( 1 ).
        DATA(lo_select_patrn) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(  )->from_row( xco_cp_xlsx=>coordinate->for_numeric_value( 2 ) )->get_pattern(   ).
        DATA(lo_execute) = lo_worksheet->select( lo_select_patrn )->row_stream(  )->operation->write_to( REF #( lt_excel1 ) ).
        lo_execute->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value  )->if_xco_xlsx_ra_operation~execute(  ).
      ENDIF.

      TRY .
          lo_table_desc ?= cl_abap_tabledescr=>describe_by_data( p_data = lt_excel1 ).
          lo_struc_descr ?= lo_table_desc->get_table_line_type(  ).
          DATA(lv_no_of_cols) = lines( lo_struc_descr->components ).
        CATCH cx_sy_move_cast_error.

      ENDTRY.

      DATA(ls_excel) = VALUE #( lt_excel1[ 1 ] OPTIONAL ).
*   DELETE lt_excel INDEX 1.
      DELETE lt_excel1 WHERE purreqitm IS INITIAL.

      lt_excel = CORRESPONDING #( lt_excel1 ).



      SELECT FROM @lt_excel AS exc
      LEFT OUTER JOIN zmm_apps01_prodv AS pro ON pro~Product = exc~material AND pro~Plant = exc~plant
      FIELDS
      exc~purreqitm,
      exc~material,
      exc~length,
      exc~pices,
      exc~plant,
      exc~width,
      exc~reqqty,
      pro~BaseUnit,
      pro~valuprice,
      pro~Currency,
      pro~ExternalProductGroup,
      pro~PlantName,
      pro~ProductDescription,
      pro~PriceUnitQty,
      pro~ProductGroup,
      pro~PurchasingGroup,
      pro~DefaultPurchasingOrganization,
      pro~yy1_unit_wgt_prd
      INTO TABLE @DATA(lt_exceldat).

      lt_itd = VALUE #( FOR ls IN lt_exceldat (
      uuid = ls_uuid
      purreqitm = ls-purreqitm
      currency = ls-Currency
      delvdate = sy-datlo + 45
      length = ls-length
      width = ls-width
      pices = ls-pices
      matdesc = ls-ProductDescription
      material = ls-material
      matgrp = ls-ProductGroup
      purorg = ls-DefaultPurchasingOrganization
      extmatgrp = ls-ExternalProductGroup
      purgrp = ls-PurchasingGroup
      plant = ls-plant
      plantdesc = ls-PlantName
*    uom = ls-BaseUnit
      reqqty = COND #( WHEN ls-ProductGroup = 'ANGLE'
      THEN
      ls-length * ls-yy1_unit_wgt_prd / 1000 * ls-pices
      WHEN ls-ProductGroup = 'PLATE'
      THEN
      ls-reqqty

       )
      valprice = ls-valuprice
      totvalue = ls-reqqty * ls-valuprice
      ) ).


      zbp_mm_apps01_rv=>gt_item = lt_itd.

*zbp_ns_pkg_rv=>gtdata = lt_itd.
*  MODIFY ENTITIES OF zns_pkg_rv IN LOCAL MODE ENTITY zns_pkg_rv
*    CREATE FIELDS ( cust ot plant sono createdby createdon )
*    WITH VALUE #( FOR ls1 IN LT_ITD ( CORRESPONDING #( ls1 ) ) ).

      " Report back so the UI refreshes the list page


      result = VALUE #( FOR ls2 IN lt_hdr (  %tky = ls2-%tky
      %param = ls2 ) ).

    ELSE.

      DATA(lv_msg2) = |You are in Edit Mode Please Save the Document|.
      APPEND VALUE #( %tky = ls_header-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_header-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg2 )   )
             TO reported-_hdr.
    ENDIF.


**********************************************************************





  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZMM_APPS01_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZMM_APPS01_RV IMPLEMENTATION.

  METHOD save_modified.

    IF zbp_mm_apps01_rv=>gt_hdr IS NOT INITIAL.
      MODIFY zmm_apps01_htb FROM TABLE @zbp_mm_apps01_rv=>gt_hdr.
    ENDIF.



    IF zbp_mm_apps01_rv=>gt_item IS NOT INITIAL.
      MODIFY zmm_apps01_itb FROM TABLE @zbp_mm_apps01_rv=>gt_item.
    ENDIF.


    IF zbp_mm_apps01_rv=>cv_pr_doc IS NOT INITIAL .
      LOOP AT zbp_mm_apps01_rv=>cv_pr_doc-purchaserequisition ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
        CONVERT KEY OF i_purchaserequisitiontp FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
        <fs_pr_mapped>-purchaserequisition = ls_pr_key-purchaserequisition.
      ENDLOOP.
      IF zbp_mm_apps01_rv=>gt_hdr IS NOT INITIAL.
        DATA(lt_hdrupd) = zbp_mm_apps01_rv=>gt_hdr.
        LOOP AT lt_hdrupd ASSIGNING FIELD-SYMBOL(<fs_upd>).
          <fs_upd>-purreqnum = ls_pr_key-PurchaseRequisition.
          <fs_upd>-mark = 'X'.
        ENDLOOP.
        MODIFY zmm_apps01_htb FROM TABLE @lt_hdrupd.
      ENDIF.
    ENDIF.

    IF delete-_item IS NOT INITIAL.
      LOOP AT delete-_item INTO DATA(ls_delim).
        DELETE FROM zmm_apps01_itb WHERE uuid = @ls_delim-Uuid AND purreqitm = @ls_delim-Purreqitm.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
