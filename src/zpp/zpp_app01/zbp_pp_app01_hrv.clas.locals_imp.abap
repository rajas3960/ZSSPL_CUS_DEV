CLASS lhc__Mhdrp DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _Mhdrp RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _Mhdrp RESULT result.

    METHODS grn FOR MODIFY
      IMPORTING keys FOR ACTION _Mhdrp~grn RESULT result.

    METHODS pgi FOR MODIFY
      IMPORTING keys FOR ACTION _Mhdrp~pgi RESULT result.

    METHODS Relase FOR MODIFY
      IMPORTING keys FOR ACTION _Mhdrp~Relase RESULT result.

    METHODS GetData FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Mhdrp~GetData.

ENDCLASS.

CLASS lhc__Mhdrp IMPLEMENTATION.

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

  METHOD GetData.
**********************************************************************

  READ ENTITIES OF zpp_app01_hrv IN LOCAL MODE ENTITY _Mhdrp
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(LT_HDR).

  DATA(LS_HDR) = lt_hdr[ 1 ].

  DATA : lt_crtd type table of zpp_app01_htb1,
         ls_crtd type zpp_app01_htb1,
         lt_icrtd type table of zpp_app01_itb1,
         ls_icrtd type zpp_app01_itb1.
         data(lv_sno) = 1.

  ls_crtd-uuid = ls_hdr-Uuid.
  ls_crtd-plant = ls_hdr-Plant.
  ls_crtd-mat = ls_hdr-Mat.
  ls_crtd-salesno = ls_hdr-Salesno.
  ls_crtd-createdby = ls_hdr-Createdby.
  ls_crtd-createdon = ls_hdr-Createdon.

  append ls_crtd to lt_crtd.
  zbp_pp_app01_hrv=>gt_hdata = lt_crtd.

**********************************************************************
if ls_hdr-Mat is not INITIAL.
select * from  zpp_produ_item_rv where Material = @ls_hdr-Mat and ProductionPlant = @ls_hdr-Plant into table @data(lt_Mat) .
endif.
if lt_mat is not INITIAL.
loop AT lt_mat  ASSIGNING FIELD-SYMBOL(<ls_mat>).

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

ls_icrtd-uuid = ls_hdr-Uuid.
ls_icrtd-sno = lv_sno.
ls_icrtd-plant = <ls_result>-Plant.
ls_icrtd-bomid = <ls_result>-%param-BillOfMaterial.
ls_icrtd-fgproduct = <ls_result>-Material.
ls_icrtd-component = <ls_result>-%param-billofmaterialcomponent.
ls_icrtd-componentdescription = <ls_result>-%param-componentdescription.
ls_icrtd-componentquantity  = <ls_result>-%param-ComponentQuantityInCompUoM.
ls_icrtd-componentuom = <ls_result>-%param-billofmaterialitemunit.
ls_icrtd-manuford   = <ls_mat>-ManufacturingOrder.
lv_sno = lv_sno + 1.
APPEND ls_icrtd to lt_icrtd.
clear ls_icrtd.


ENDLOOP.
endif.
ENDLOOP.
sort lt_icrtd BY manuford sno ASCENDING.
zbp_pp_app01_hrv=>gt_idata = lt_icrtd.

endif.




  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APP01_HRV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APP01_HRV IMPLEMENTATION.

  METHOD save_modified.
**********************************************************************
  if create-_mhdrp is NOT INITIAL.
**********************************************************************
  if zbp_pp_app01_hrv=>gt_hdata is not INITIAL.
  MODIFY zpp_app01_htb1 from TABLE @zbp_pp_app01_hrv=>gt_hdata.
  endif.
**********************************************************************
if zbp_pp_app01_hrv=>gt_idata is not INITIAL.
MODIFY zpp_app01_itb1 from table @zbp_pp_app01_hrv=>gt_idata.
endif.

  endif.
**********************************************************************

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
