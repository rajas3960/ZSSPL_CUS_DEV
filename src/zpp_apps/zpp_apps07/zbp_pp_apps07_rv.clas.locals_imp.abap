CLASS lhc_ZPP_APPS07_RV DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zpp_apps07_rv RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zpp_apps07_rv RESULT result.

    METHODS GImat FOR MODIFY
      IMPORTING keys FOR ACTION zpp_apps07_rv~GImat RESULT result.

    METHODS GRmat FOR MODIFY
      IMPORTING keys FOR ACTION zpp_apps07_rv~GRmat RESULT result.

ENDCLASS.

CLASS lhc_ZPP_APPS07_RV IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_apps07_rv IN LOCAL MODE
    ENTITY zpp_apps07_rv
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

   result =  VALUE #( FOR ls_data IN Lt_hdr
          (   %tky =  ls_data-%tky
          %action-GImat = COND #( WHEN  ls_data-Statusr IS not INITIAL AND ls_data-Statusgi IS INITIAL

                                                      THEN if_abap_behv=>fc-o-enabled

                                                      ELSE if_abap_behv=>fc-o-disabled )
          %action-GRmat =    if_abap_behv=>fc-o-disabled


                                                      ) ).




  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD GImat.
  tYPES:  BEGIN OF TY_ITM,
  Orderno  type aufnr,
  rsrno   type rsnum,
  rsitm type rspos,
  quanty type menge_d,
  batch  type charg_d,
  plant type werks_d,
  storloc type c length 4 ,
  salesorder type vbeln_va,
  matnr type matnr,

  END OF TY_ITM.



data : lt_git type table of ty_itm,
       ls_git type ty_itm.


   DATA : gs_hdr TYPE zpp_apps05_htb.
**********************************************************************
    READ ENTITIES OF zpp_apps07_rv IN LOCAL MODE
    ENTITY zpp_apps07_rv
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item)
    BY \_Rawitm
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(Lt_rawitm).
**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].
    select single from zpp_apps05_htb FIELDS vrcuting where uuid = @ls_hdr-Uuid into @data(ls_vr).
**********************************************************************

if lt_rawitm is not inITIAL.






endif.





    IF lt_item IS NOT INITIAL AND lt_rawitm IS NOT INITIAL.







    data(lt_rwitm) = lt_rawitm.
    data(lt_mkitm) = LT_ITEM.
if ls_vr = 'CI'.
    LOOP AT lt_rwitm INTO DATA(ls_rawitm).

    LOOP AT lt_mkitm INTO DATA(ls_item)
         WHERE srclent = ls_rawitm-Length
           AND Netwt   > 0.

      " Exit if raw qty finished
      IF ls_rawitm-Uqty <= 0.
        EXIT.
      ENDIF.

      DATA(lv_qty) = COND #(
        WHEN ls_item-Netwt <= ls_rawitm-Uqty
        THEN ls_item-Netwt
        ELSE ls_rawitm-Uqty ).

      CLEAR ls_git.

      ls_git-orderno   = ls_item-Orderno.
      ls_git-rsrno     = ls_item-Resv.
      ls_git-rsitm     = ls_item-ReservationItem.
      ls_git-batch     = ls_rawitm-Batch.
      ls_git-plant     = ls_rawitm-Plant.
      ls_git-salesorder = ls_item-Vbeln.
      ls_git-matnr = ls_item-Maktx.
      ls_git-quanty    = lv_qty.

      " Reduce quantities
      ls_item-Netwt  = ls_item-Netwt  - lv_qty.
      ls_rawitm-Uqty = ls_rawitm-Uqty - lv_qty.

      MODIFY lt_mkitm FROM ls_item.
      APPEND ls_git TO lt_git.

    ENDLOOP.

    " Update raw table
    MODIFY lt_rwitm FROM ls_rawitm.

  ENDLOOP.
  ELSE.
 LOOP AT lt_rwitm INTO DATA(ls_rawitm1).

    LOOP AT lt_mkitm INTO DATA(ls_item1)
         WHERE Netwt   > 0.

      " Exit if raw qty finished
      IF ls_rawitm1-Uqty <= 0.
        EXIT.
      ENDIF.

      DATA(lv_qty1) = COND #(
        WHEN ls_item1-Netwt <= ls_rawitm1-Uqty
        THEN ls_item1-Netwt
        ELSE ls_rawitm1-Uqty ).

      CLEAR ls_git.

      ls_git-orderno   = ls_item1-Orderno.
      ls_git-rsrno     = ls_item1-Resv.
      ls_git-rsitm     = ls_item1-ReservationItem.
      ls_git-batch     = ls_rawitm1-Batch.
      ls_git-plant     = ls_rawitm1-Plant.
      ls_git-salesorder = ls_item1-Vbeln.
      ls_git-matnr = ls_item1-Maktx.
      ls_git-quanty    = lv_qty1.

      " Reduce quantities
      ls_item1-Netwt  = ls_item1-Netwt  - lv_qty1.
      ls_rawitm1-Uqty = ls_rawitm1-Uqty - lv_qty1.

      MODIFY lt_mkitm FROM ls_item.
      APPEND ls_git TO lt_git.

    ENDLOOP.

    " Update raw table
    MODIFY lt_rwitm FROM ls_rawitm1.

  ENDLOOP.
    ENDIF.

ENDIF.
**********************************************************************
if lt_git is not inITIAL.
     MODIFY ENTITIES OF i_materialdocumenttp PRIVILEGED
      ENTITY MaterialDocument
      CREATE FROM VALUE #( ( %cid                          = 'CID_001'
                             goodsmovementcode             = '03'
                             postingdate                   = cl_abap_context_info=>get_system_date( )
                             documentdate                  = cl_abap_context_info=>get_system_date( )
                             %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                             %control-postingdate                          = cl_abap_behv=>flag_changed
                             %control-documentdate                         = cl_abap_behv=>flag_changed
                         ) )
      ENTITY MaterialDocument
      CREATE BY \_MaterialDocumentItem
      FROM VALUE #( FOR ls1 IN lt_git INDEX INTO idx (
                      %cid_ref = 'CID_001'
                      %target = VALUE #( ( %cid                           = 'CID_ITM_' && idx
                                           plant                          = ls1-plant
                                           material                       = ls1-matnr
                                           GoodsMovementType              = '261'
                                           storagelocation                = 'SF01'
                                           QuantityInEntryUnit            = ls1-quanty
                                           entryunit                      = 'KG'
                                           ManufacturingOrder             =  ls1-orderno
                                           Reservation                    =  ls1-rsrno
                                           ReservationItem =  ls1-rsitm
                                           Batch = ls1-batch




                                           %control-plant                 = cl_abap_behv=>flag_changed
                                           %control-material              = cl_abap_behv=>flag_changed
                                           %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                           %control-storagelocation       = cl_abap_behv=>flag_changed
                                           %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                           %control-entryunit             = cl_abap_behv=>flag_changed
                                           %control-ManufacturingOrder   =  cl_abap_behv=>flag_changed
                                           %control-Reservation =  cl_abap_behv=>flag_changed
                                           %control-ReservationItem =  cl_abap_behv=>flag_changed
                                           %control-Batch = cl_abap_behv=>flag_changed


                                       ) )


                  ) )
      MAPPED   DATA(ls_create_mapped)
      FAILED   DATA(ls_create_failed)
      REPORTED DATA(ls_create_reported).

endif.

if ls_create_failed is inITIAL.
select SINGLE * from zpp_apps05_htb where uuid = @ls_hdr-Uuid into @data(ls_hdr2).

TRY.
    DATA(ls_user) =  cl_abap_context_info=>get_user_description(  ).
    CATCH   cx_abap_context_info_error .
    DATA(lv) = 1.
ENDTRY.



move-CORRESPONDING ls_hdr2 to gs_hdr.

gs_hdr-statusgi = 'GI'.
gs_hdr-pgiusr = ls_user.

append gs_hdr to zbp_pp_apps07_rv=>gt_hdr.

endif.










**********************************************************************

    result = VALUE #(
         FOR ls2 IN lt_hdr (
           %tky   = ls2-%tky
           %param = ls2
         )
       ).
  ENDMETHOD.

  METHOD GRmat.
   DATA : gs_hdr TYPE zpp_apps05_htb.
**********************************************************************
    READ ENTITIES OF zpp_apps07_rv IN LOCAL MODE
    ENTITY zpp_apps07_rv
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item)
    BY \_Rawitm
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(Lt_rawitm).
data(ls_hdr) = lt_hdr[ 1 ].

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
                                                      entryunit                      =  'EA'
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
   select SINGLE * from zpp_apps05_htb where uuid = @ls_hdr-Uuid into @data(ls_hdr2).

TRY.
    DATA(ls_user) =  cl_abap_context_info=>get_user_description(  ).
    CATCH   cx_abap_context_info_error .
    DATA(lv) = 1.
ENDTRY.



move-CORRESPONDING ls_hdr2 to gs_hdr.

gs_hdr-statusgr = 'GR'.
gs_hdr-pgrusr = ls_user.

append gs_hdr to zbp_pp_apps07_rv=>gt_hdr.
      ELSE.
      ENDIF.

    ENDIF.


    result = VALUE #( FOR ls_ord IN lt_hdr
                          (  %tky  = ls_ord-%tky
                           %param = ls_ord ) ).






  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APPS07_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APPS07_RV IMPLEMENTATION.

  METHOD save_modified.
  IF zbp_pp_apps07_rv=>gt_hdr IS NOT INITIAL.
      MODIFY zpp_apps05_htb FROM TABLE @zbp_pp_apps07_rv=>gt_hdr.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
