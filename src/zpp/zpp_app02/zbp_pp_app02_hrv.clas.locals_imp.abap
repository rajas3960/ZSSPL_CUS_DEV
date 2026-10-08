CLASS lhc__MHdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _MHdr RESULT result.

    METHODS GetData FOR DETERMINE ON SAVE
      IMPORTING keys FOR _MHdr~GetData.

ENDCLASS.

CLASS lhc__MHdr IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD GetData.
  READ ENTITIES OF zpp_app02_hrv IN LOCAL MODE ENTITY _MHdr
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT data(lt_hdr).
  data(ls_hdr) = lt_hdr[ 1 ].

  DATA: LT_HCRT TYPE TABLE OF zpp_app02_htb,
        LS_HCRT TYPE zpp_app02_htb,
        LT_ICRT TYPE TABLE OF zpp_app02_itb1,
        LS_ICRT TYPE zpp_app02_itb1,
        LT_IICRT TYPE TABLE OF zpp_app02_itb2,
        LS_IICRT TYPE zpp_app02_itb2,
        lt_mat TYPE TABLE OF zpp_produ_item_rv.

move-CORRESPONDING ls_hdr to ls_hcrt.
APPEND ls_hcrt to lt_hcrt.
zbp_pp_app02_hrv=>gt_hcrt = lt_hcrt.
**********************************************************************
if ls_hdr-Mat  is not INITIAL and ls_hdr-Plant is not INITIAL.

select * from  zpp_produ_item_rv where Material = @ls_hdr-Mat and ProductionPlant = @ls_hdr-Plant into table @lt_Mat .


ENDIF.
if ls_hdr-Salesno  is not INITIAL and ls_hdr-Plant is not INITIAL.
select * from  zpp_produ_item_rv where SalesOrder = @ls_hdr-Salesno and ProductionPlant = @ls_hdr-Plant into table @lt_Mat .
endif.
**********************************************************************
if lt_mat is not INITIAL.

loop AT lt_mat  ASSIGNING FIELD-SYMBOL(<ls_mat>).
       ls_icrt-uuid = ls_hdr-Uuid.
       ls_icrt-item = ls_icrt-item + 1.
       ls_icrt-material = <ls_mat>-Material.
       ls_icrt-orderno = <ls_mat>-ManufacturingOrder.
       ls_icrt-plant = <ls_mat>-ProductionPlant.
       ls_icrt-sono  = <ls_mat>-SalesOrder.
       ls_icrt-soitm = <ls_mat>-SalesOrderItem.
       ls_icrt-quant = <ls_mat>-MfgOrderItemPlannedTotalQty.
       ls_iicrt-unit = <ls_mat>-ProductionUnit.




       READ ENTITIES OF i_billofmaterialtp_2 PRIVILEGED
        ENTITY billofmaterial
        EXECUTE explodebom
          FROM VALUE #(  "FOR wa_hbom IN lt_bomhdr
            (
*              billofmaterial = <wa_hbom>-bomid
              plant          = <ls_mat>-ProductionPlant
              material       = <ls_mat>-Material
              billofmaterialcategory = 'M'
              %param-bomexplosionapplication = 'PP01'
              %param-requiredquantity = <ls_mat>-MfgOrderItemPlannedTotalQty
*                %param-BOMExplosionIsAlternatePrio = 1
              %param-explodebomlevelvalue = 0
*              %param-bomexplosionismultilevel = 'X'
            )
          )
          RESULT  DATA(lt_result)
          FAILED DATA(ls_failed)
          REPORTED DATA(ls_reported).

if lt_result is not INITIAL.
loop at lt_result ASSIGNING FIELD-SYMBOL(<ls_result>).
ls_iicrt-uuid = ls_icrt-uuid.
ls_iicrt-item = ls_icrt-item.
ls_iicrt-citem = ls_iicrt-citem + 1.
ls_iicrt-material = <ls_result>-%param-billofmaterialcomponent.
ls_iicrt-materialdec = <ls_result>-%param-componentdescription.
ls_iicrt-qunt = <ls_result>-%param-ComponentQuantityInCompUoM.
ls_iicrt-unit =  <ls_result>-%param-billofmaterialitemunit.
ls_iicrt-orderno = ls_icrt-orderno.
APPEND ls_iicrt TO lt_iicrt.
*CLEAR ls_iicrt.


ENDLOOP.
CLEAR ls_iicrt.
ENDIF.
APPEND ls_icrt to lt_icrt.
*CLEAR ls_icrt.

ENDLOOP.
sort lt_icrt by item ASCENDING.
sort lt_iicrt by citem ASCENDING.
*append ls_icrt to lt_icrt.

zbp_pp_app02_hrv=>gt_icrt = lt_icrt.
zbp_pp_app02_hrv=>gt_cicrt = lt_iicrt.


ENDIF.




  ENDMETHOD.

ENDCLASS.

CLASS lhc__Mitem DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _Mitem RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _Mitem RESULT result.

    METHODS grn FOR MODIFY
      IMPORTING keys FOR ACTION _Mitem~grn RESULT result.

    METHODS pgi FOR MODIFY
      IMPORTING keys FOR ACTION _Mitem~pgi RESULT result.

    METHODS Relase FOR MODIFY
      IMPORTING keys FOR ACTION _Mitem~Relase RESULT result.

ENDCLASS.

CLASS lhc__Mitem IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD grn.
  ENDMETHOD.

  METHOD pgi.
  ENDMETHOD.

  METHOD Relase.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APP02_HRV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APP02_HRV IMPLEMENTATION.

  METHOD save_modified.
  IF create-_mhdr IS NOT INITIAL.
 IF zbp_pp_app02_hrv=>gt_hcrt IS NOT INITIAL.
  MODIFY zpp_app02_htb FROM TABLE @zbp_pp_app02_hrv=>gt_hcrt.
  ENDIF.
   IF zbp_pp_app02_hrv=>gt_icrt IS NOT INITIAL.
  MODIFY zpp_app02_itb1 FROM TABLE @zbp_pp_app02_hrv=>gt_icrt.
  ENDIF.
   IF zbp_pp_app02_hrv=>gt_cicrt IS NOT INITIAL.
  MODIFY zpp_app02_itb2 FROM TABLE @zbp_pp_app02_hrv=>gt_cicrt.
  ENDIF.
  ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
