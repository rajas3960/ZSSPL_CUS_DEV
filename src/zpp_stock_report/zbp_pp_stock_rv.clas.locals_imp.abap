CLASS lhc_HDR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR hdr RESULT result.

    METHODS Gtlegth FOR MODIFY
      IMPORTING keys FOR ACTION hdr~Gtlegth .

ENDCLASS.

CLASS lhc_HDR IMPLEMENTATION.

  METHOD get_instance_features.
*****************************************
   READ ENTITIES OF zpp_stock_rv IN LOCAL MODE
    ENTITY hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

 result = VALUE #( FOR ls_data IN Lt_hdr
        (   %tky =  ls_data-%tky
         %action-Gtlegth        =            COND #( WHEN ls_data-YY1_Length_No_MMI is not inITIAL
                                                    THEN
                                                     if_abap_behv=>fc-o-disabled
                                                    ELSE
                                                     if_abap_behv=>fc-o-enabled )


      ) ) .





  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD Gtlegth.
**********************************************************************
   data: gt_hdr type table of zpp_stock_ht1,
         gs_hdr type zpp_stock_ht1.

    READ ENTITIES OF zpp_stock_rv IN LOCAL MODE
    ENTITY hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_pcs).

**********************************************************************
    DATA(ls_pcs) = lt_pcs[ 1 ].
**********************************************************************

    MOVE-CORRESPONDING ls_pcs TO gs_hdr.
    gs_hdr-length = keys[ 1 ]-%param-Length.
    gs_hdr-width  =  keys[ 1 ]-%param-Width.
    gs_hdr-pcs    = keys[ 1 ]-%param-Pcs.

   APPEND gs_hdr to zbp_pp_stock_rv=>gt_hdr.


  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_STOCK_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_STOCK_RV IMPLEMENTATION.

  METHOD save_modified.
  if zbp_pp_stock_rv=>gt_hdr is not inITIAL.
  modify zpp_stock_ht1 from table @zbp_pp_stock_rv=>gt_hdr.
  endif.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
