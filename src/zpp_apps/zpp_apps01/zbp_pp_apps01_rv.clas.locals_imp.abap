CLASS lhc__Hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _Hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _Hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _Hdr RESULT result.

    METHODS Genjob FOR MODIFY
      IMPORTING keys FOR ACTION _Hdr~Genjob RESULT result.

    METHODS getitems FOR MODIFY
      IMPORTING keys FOR ACTION _Hdr~getitems RESULT result.

    METHODS matval FOR MODIFY
      IMPORTING keys FOR ACTION _Hdr~matval RESULT result.

    METHODS gtdata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Hdr~gtdata1.
    METHODS confimjob FOR MODIFY
      IMPORTING keys FOR ACTION _Hdr~confimjob RESULT result.
    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION _Hdr~getpdf RESULT result.
    METHODS poval FOR MODIFY
      IMPORTING keys FOR ACTION _Hdr~poval RESULT result.

ENDCLASS.

CLASS lhc__Hdr IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_apps01_rv IN LOCAL MODE
    ENTITY _Hdr ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT FINAL(lt_hdr).
**********************************************************************
    result = VALUE #( FOR ls_hdr IN lt_hdr (
    %tky                            = ls_hdr-%tky
     %action-Genjob = COND #( WHEN ls_hdr-Gengt IS INITIAL
                              THEN if_abap_behv=>fc-o-enabled
                              ELSE if_abap_behv=>fc-o-disabled )
     %action-matval =    COND #( WHEN ls_hdr-Gengt IS NOT INITIAL AND ls_hdr-Status = 'O'
                              THEN if_abap_behv=>fc-o-enabled
                              ELSE if_abap_behv=>fc-o-disabled )
    %action-confimjob = COND #( WHEN ls_hdr-Status = 'C'
                              THEN if_abap_behv=>fc-o-disabled
                              ELSE if_abap_behv=>fc-o-enabled )
 %action-Edit = COND #( WHEN ls_hdr-Status = 'C'
                                              THEN
                                              if_abap_behv=>fc-o-disabled
                                              ELSE
                                              if_abap_behv=>fc-o-enabled )
 %assoc-_Item  = COND #( WHEN ls_hdr-Status = 'C' OR ls_hdr-Status = 'O'
                                              THEN
                                              if_abap_behv=>fc-o-disabled
                                              ELSE
                                              if_abap_behv=>fc-o-enabled )
%assoc-_Item2  = COND #( WHEN ls_hdr-Status = 'C' OR ls_hdr-Status = 'O'
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

  METHOD Genjob.
**********************************************************************
    DATA: gs_hdr TYPE zpp_apps01_htb1.
    DATA nr_number      TYPE cl_numberrange_runtime=>nr_number.
    DATA: lv_numb TYPE n LENGTH 10.
**********************************************************************
    READ ENTITIES OF zpp_apps01_rv IN LOCAL MODE
    ENTITY _Hdr ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT FINAL(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    IF ls_hdr-%is_draft IS INITIAL.
      TRY.
          cl_numberrange_runtime=>number_get( " generating number
                                              EXPORTING nr_range_nr = '01'
                                                        object      = 'ZPP_JOBNR'
                                              IMPORTING number      = nr_number ).
          IF nr_number IS NOT INITIAL.
            lv_numb = nr_number+10(10).
            IF ls_hdr-Werks = '1030'.
              MOVE-CORRESPONDING ls_hdr TO gs_hdr.
              gs_hdr-jobsheetno = |JOB30| && lv_numb .
            ELSEIF ls_hdr-Werks = '1020'.
              MOVE-CORRESPONDING ls_hdr TO gs_hdr.
              gs_hdr-jobsheetno = |JOB20| && lv_numb .
            ELSEIF ls_hdr-Werks = '1010'.
              MOVE-CORRESPONDING ls_hdr TO gs_hdr.
              gs_hdr-jobsheetno = |JOB10| && lv_numb .
            ELSEIF ls_hdr-Werks = '1040'.
              MOVE-CORRESPONDING ls_hdr TO gs_hdr.
              gs_hdr-jobsheetno = |JOB10| && lv_numb .
            ENDIF.
          ENDIF.
        CATCH cx_nr_object_not_found cx_number_ranges.
        data(lver) = 1.
      ENDTRY.
**********************************************************************


      MODIFY ENTITIES OF zpp_apps01_rv IN LOCAL MODE
                       ENTITY _Hdr
                       UPDATE
                       FIELDS (  Jobsheetno  )
                       WITH VALUE #( ( %tky = ls_hdr-%tky
                       Jobsheetno = gs_hdr-jobsheetno  ) ).
**********************************************************************

      READ ENTITIES OF zpp_apps01_rv IN LOCAL MODE
              ENTITY  _Hdr
              ALL FIELDS
              WITH CORRESPONDING #( keys )
              RESULT FINAL(header_1).
**********************************************************************
      gs_hdr-status = 'O'.
      gs_hdr-gengt = 'X'.
      APPEND gs_hdr TO zbp_pp_apps01_rv=>gt_hdr.

      result = VALUE #( FOR ls_header IN header_1
                        ( %tky   = ls_header-%tky
                          %param = ls_header ) ).
**********************************************************************
    ELSE.
      DATA(lv_msg2) = |You are in Edit Mode Please Save the Document|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg2 )   )
             TO reported-_hdr.
    ENDIF.

  ENDMETHOD.

  METHOD getitems.
  ENDMETHOD.

  METHOD matval.
**********************************************************************
*    READ ENTITIES OF zpp_apps01_rv IN LOCAL MODE
*    ENTITY _Hdr
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_hdr).
*    DATA : lt_manu TYPE TABLE OF zbp_pp_apps01_rv=>ty_mfg_data.
*    DATA(ls_plant) =  lt_hdr[ 1 ]-Werks.
*    DATA(uuid) =  lt_hdr[ 1 ]-Uuid.
*    DATA(ls_mat) = keys[ 1 ]-%param-matnr.
*    zbp_pp_apps01_rv=>gt_matnr = ls_mat.
*    DATA : gsitm TYPE zpp_apps01_itb3.
*    TYPES : tc3(3) TYPE c.
*    IF lt_hdr[ 1 ]-%is_draft IS INITIAL.
*      IF ls_mat IS NOT INITIAL AND ls_plant IS NOT INITIAL.
***********************************************************************
*        READ ENTITIES OF i_billofmaterialtp_2 PRIVILEGED
*        ENTITY billofmaterial
*        EXECUTE explodebom
*          FROM VALUE #(
*            (
*              plant          = ls_plant
*              material       = ls_mat
*              billofmaterialcategory = 'M'
*              %param-bomexplosionapplication = 'PP01'
*              %param-explodebomlevelvalue = 0
*            %param-requiredquantity = 1
*          %param-bomexplosionismultilevel = 'X'
*            )
*          )
*          RESULT  DATA(lt_result)
*          FAILED DATA(ls_failed)
*          REPORTED DATA(ls_reported).
***********************************************************************
*        IF lt_result IS NOT INITIAL.
*          SELECT Material FROM ZPP_APPS05_
*          FOR ALL ENTRIES IN @lt_result
*          WHERE Material = @lt_result-%param-billofmaterialcomponent AND ProductionPlant = @lt_result-Plant
*          INTO TABLE @DATA(lt_table).
*
*
*          LOOP AT lt_table ASSIGNING FIELD-SYMBOL(<ls_table>).
*
*            WITH +ztb AS (    SELECT rv~ManufacturingOrder ,rv~material,SUM( tb2~reqty ) AS reqty FROM zpp_app03_ord AS rv
*            INNER JOIN zpp_apps01_itb1 AS tb2 ON tb2~orderno = rv~ManufacturingOrder AND tb2~matnr = rv~Material
*             WHERE  rv~ProductionPlant  = @ls_plant
*             AND rv~Material = @<ls_table>-Material
*             AND
*             NOT EXISTS ( SELECT orderno FROM zpp_apps01_itb3 AS tb1
*             INNER JOIN zpp_apps01_htb1 AS tb ON tb~uuid =  tb1~uuid
*              WHERE orderno = rv~ManufacturingOrder AND matnr =  rv~Material  AND tb~status <> 'C'  )
*              GROUP BY rv~ManufacturingOrder ,rv~material  )
*
*             SELECT FROM  zpp_app03_ord AS rv
*             LEFT JOIN +ztb AS ztb ON ztb~ManufacturingOrder = rv~ManufacturingOrder AND ztb~Material = rv~Material
*             FIELDS rv~ManufacturingOrder,
*             rv~ManufacturingOrderItem ,
*             rv~Batch,
*             rv~CompanyCode,
*             rv~Material,
*             rv~ProductionPlant,
*             rv~SalesOrder,
*             rv~SalesOrderItem,
*             rv~MfgOrderItemPlannedTotalQty,
*             rv~ProductionUnit,
*             rv~ProductType,
*             rv~ManufacturingOrderType,
*             rv~ProductName,
*             rv~StorageLocation,
*             rv~Reservation,
*             ztb~reqty
*             WHERE  rv~ProductionPlant  = @ls_plant AND rv~Material = @<ls_table>-Material AND
*             NOT EXISTS ( SELECT orderno FROM zpp_apps01_itb3 AS tb1
*             INNER JOIN zpp_apps01_htb1 AS tb ON tb~uuid =  tb1~uuid
*             WHERE orderno = rv~ManufacturingOrder AND matnr =  rv~Material  AND tb~status <> 'C' )
*             INTO TABLE @DATA(lt_manu1).
*
**          APPEND LINES OF lt_manu1 TO lt_manu.
**MOVE-CORRESPONDING lt_manu1 to lt_manu.
*            lt_manu = VALUE #( BASE lt_manu FOR ls2 IN lt_manu1 ( CORRESPONDING #( ls2 ) ) ).
*
*
*          ENDLOOP.
*        ENDIF.
*        CLEAR lt_manu1.
*
*        LOOP AT lt_manu INTO DATA(ls).
*          gsitm-uuid = uuid.
*          gsitm-plant  = ls-ProductionPlant.
*          gsitm-orderno = ls-ManufacturingOrder.
*          gsitm-orderitem = ls-ManufacturingOrderItem.
*          gsitm-matnr = ls-Material.
*          gsitm-maktx = ls-ProductName.
*          gsitm-plnqty = ls-MfgOrderItemPlannedTotalQty.
*          gsitm-uom = ls-ProductionUnit.
*          gsitm-rsnum = ls-Reservation.
*          gsitm-totreqty = ls-reqty.
*          gsitm-totopnqty =    gsitm-plnqty - ls-reqty.
*          gsitm-vbeln = ls-SalesOrder.
*          gsitm-soitem = ls-SalesOrderItem.
*          IF gsitm-totopnqty > 0 .
*
*            SELECT FROM I_ManufacturingOrderOperation AS moo
*            INNER JOIN I_WorkCenter AS wc ON wc~WorkCenterInternalID = moo~WorkCenterInternalID
*            FIELDS
*             moo~WorkCenterInternalID ,
*             wc~WorkCenter,
*             moo~MfgOrderOperationText
*             WHERE moo~ManufacturingOrder = @gsitm-orderno
*             INTO TABLE @DATA(lt_mop).
*
*            gsitm-operation = REDUCE string(
*        INIT result1 TYPE string
*        FOR ls1 IN lt_mop
*        NEXT result1 = result1 &&
*          COND tc3(
*          WHEN ls1-WorkCenter = 'BENDING'        THEN 'B'
*          WHEN ls1-WorkCenter = 'CUTTING'        THEN 'CU'
*          WHEN ls1-WorkCenter = 'GRINDING'       THEN 'G'
*          WHEN ls1-WorkCenter = 'NOTCHING'       THEN 'N'
*          WHEN ls1-WorkCenter = 'PUNCHING'       THEN 'P'
*          WHEN ls1-WorkCenter = 'STAMPING'       THEN 'S'
*          WHEN ls1-WorkCenter = 'GALVA'          THEN 'G'
*          WHEN ls1-WorkCenter = 'ROLLING'        THEN 'R'
*          WHEN ls1-WorkCenter = 'HEATING'        THEN 'H'
*          WHEN ls1-WorkCenter = 'FORGING'        THEN 'F'
*          WHEN ls1-WorkCenter = 'PADDING'        THEN 'P'
*          WHEN ls1-WorkCenter = 'COOLING'        THEN 'CO'
*          WHEN ls1-WorkCenter = 'BLASTING'       THEN 'B'
*          WHEN ls1-WorkCenter = 'MPI'            THEN 'MPI'
*          WHEN ls1-WorkCenter = 'VISHUAL'        THEN 'V'
*          WHEN ls1-WorkCenter = 'RPO'            THEN 'R'
*          WHEN ls1-WorkCenter = 'HARDNESS'       THEN 'H'
*          WHEN ls1-WorkCenter = 'PDI INSP'       THEN 'PDI'
*          WHEN ls1-WorkCenter = 'PACK&HAR'       THEN 'PA'
*          WHEN ls1-WorkCenter = 'REWORKQA'       THEN 'RW'
*          WHEN ls1-WorkCenter = 'RFI'            THEN 'RFI'
*          WHEN ls1-WorkCenter = 'RFG'            THEN 'RFG'
*          WHEN ls1-WorkCenter = 'RFD'            THEN 'RFD'
*          WHEN ls1-WorkCenter = 'ANEALING'       THEN 'A'
*          WHEN ls1-WorkCenter = 'PHOS'           THEN 'PH'
*          WHEN ls1-WorkCenter = 'H.TREAT'        THEN 'HT'
*          WHEN ls1-WorkCenter = 'RE.TAP'         THEN 'RET'
*          WHEN ls1-WorkCenter = 'ASSEMBLY'       THEN 'AS'
*          WHEN ls1-WorkCenter = 'WIRE DRA'       THEN 'WD'
*          WHEN ls1-WorkCenter = 'RE-ROLL'        THEN 'RR'
*          WHEN ls1-WorkCenter = 'TAPPING'        THEN 'TP'
*          WHEN ls1-WorkCenter = 'DRILLING'       THEN 'DR'
*          ELSE ''
*      )
*
*      ).
***********************************************************************
*            READ ENTITIES OF i_billofmaterialtp_2 PRIVILEGED
*            ENTITY billofmaterial
*            EXECUTE explodebom
*              FROM VALUE #(
*                (
**          billofmaterial = '00057791'
*                  plant          = gsitm-plant
*                  material       = gsitm-matnr
*                  billofmaterialcategory = 'M'
*
*                  %param-bomexplosionapplication = 'PP01'
*                  %param-requiredquantity = 1
*                  %param-explodebomlevelvalue = 0
*                  %param-bomexplosionismultilevel = 'X'
*                )
*              )
*              RESULT DATA(lt_result1)
*              FAILED DATA(ls_failed1)
*              REPORTED DATA(ls_reported1).
***********************************************************************
**READ TABLE lt_result1 INTO DATA(ls_first) INDEX 1.
**IF sy-subrc = 0.
**  gsitm-secon = ls_first-%param-BillOfMaterialComponent.
**ENDIF.
*
*            gsitm-secon = VALUE #( lt_result1[ 1 ]-%param-BillOfMaterialComponent OPTIONAL ).
*
***********************************************************************
*
*
*
*
*
*            APPEND gsitm TO zbp_pp_apps01_rv=>gt_item3.
*          ENDIF.
*          CLEAR : gsitm , ls.
*        ENDLOOP.
*
*
*
*      ENDIF.
*
*      result = VALUE #( FOR ls_ord IN lt_hdr
*                              (  %tky  = ls_ord-%tky
*                               %param = ls_ord ) ).
*
*    ELSE.
*      DATA(lv_msg2) = |You are in Edit Mode Please Save the Document|.
*      APPEND VALUE #( %tky = lt_hdr[ 1 ]-%tky )
*                  TO failed-_hdr.
*
*      APPEND VALUE #( %tky           = lt_hdr[ 1 ]-%tky
*                      %state_area    = 'Validate_Header1'
*                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
*                                                              text     = lv_msg2 )   )
*             TO reported-_hdr.
*    ENDIF.


  ENDMETHOD.

  METHOD gtdata1.
**********************************************************************
    DATA : gs_hdr TYPE zpp_apps01_htb1.

    READ ENTITIES OF zpp_apps01_rv IN LOCAL MODE
    ENTITY _Hdr ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT FINAL(lt_hdr).
**********************************************************************
    DATA(ls_hdr) =  lt_hdr[ 1 ].

    gs_hdr-werks = ls_hdr-Werks.
    gs_hdr-jobdesc = ls_hdr-Jobdesc.
    gs_hdr-status = 'O'.
    gs_hdr-delmark = ' '.
    gs_hdr-uuid = ls_hdr-Uuid.
    gs_hdr-createdby = ls_hdr-Createdby.
    gs_hdr-createdon = ls_hdr-Createdon.
    gs_hdr-lastchangedby = ls_hdr-Lastchangedby.
    gs_hdr-lastchangedon = ls_hdr-Lastchangedon.

    APPEND gs_hdr TO zbp_pp_apps01_rv=>gt_hdr.

**********************************************************************
  ENDMETHOD.

  METHOD confimjob.

    DATA: gshdr1 TYPE zpp_apps01_htb1.
    READ ENTITIES OF zpp_apps01_rv IN LOCAL MODE
  ENTITY _hdr
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_hdr).
    DATA(ls_hdr) = lt_hdr[ 1 ].
    IF ls_hdr-%is_draft IS INITIAL.
**********************************************************************
      MOVE-CORRESPONDING ls_hdr TO gshdr1.
      gshdr1-status = 'C'.

      APPEND gshdr1 TO zbp_pp_apps01_rv=>gt_hdr.

*    zbp_pp_app03_rv1=>gt_hdr = gthdr1.

      result = VALUE #( FOR ls_ord IN lt_hdr
                               (  %tky  = ls_ord-%tky
                                %param = ls_ord ) ).
**********************************************************************
    ELSE.
      DATA(lv_msg2) = |You are in Edit Mode Please Save the Document|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header2'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg2 )   )
             TO reported-_hdr.
    ENDIF.
  ENDMETHOD.

  METHOD getpdf.
**********************************************************************
    READ ENTITIES OF  zpp_apps01_rv IN LOCAL MODE
    ENTITY _Hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    ENTITY _Hdr BY \_Item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
**********************************************************************

    DATA : it_hdr  TYPE TABLE OF zpp_apps01_htb1,
           it_item TYPE TABLE OF zpp_apps01_itb1.

    MOVE-CORRESPONDING lt_hdr TO it_hdr.
    MOVE-CORRESPONDING lt_item TO it_item.
**********************************************************************

    zcl_btp_adobe_form=>get_ouath_token(
              EXPORTING
                im_oauth_url    = 'ADS_OAUTH_URL'
                im_client_id    = 'ADS_CLIENTID'
                im_clientsecret = 'ADS_CLIENTSECRET'
              IMPORTING
                ex_token        = DATA(lv_token)
                ex_message      = DATA(lv_message)
            ).
**********************************************************************

    zbp_pp_apps01_rv=>get_pdf_xml(
      EXPORTING
        im_head    = it_hdr
        im_item    = it_item
      IMPORTING
        ex_base_64 = DATA(lv_base64)
    ).
**********************************************************************

    DATA : lv_form_name TYPE string VALUE 'ZCUTTING/YY1_CUTTING_FRM'.

**********************************************************************

    zcl_btp_adobe_form=>get_pdf_api(
      EXPORTING
        im_url           = 'ADS_URL'
        im_url_path      = '/v1/adsRender/pdf?TraceLevel=2&templateSource=storageName'
        im_client_id     = 'ADS_CLIENTID'
        im_clientsecret  = 'ADS_CLIENTSECRET'
        im_token         = lv_token
        im_base64_encode = lv_base64
        im_xdp_template  = lv_form_name
      IMPORTING
        ex_base64_decode = DATA(lv_base64_decode)
        ex_message       = lv_message
    ).

**********************************************************************
    DATA: gt_formupdate TYPE TABLE OF zpp_apps01_htb1,
          gs_formupdate TYPE zpp_apps01_htb1.
**********************************************************************


    DATA(gs_formout) =  lt_hdr[ 1 ].

    MOVE-CORRESPONDING gs_formout TO gs_formupdate.

    gs_formupdate-attachmentsul = lv_base64_decode.
    gs_formupdate-filenameul = lt_hdr[ 1 ]-Jobsheetno.
    gs_formupdate-mimetypeul = 'application/pdf'.

    APPEND gs_formupdate TO gt_formupdate.
    zbp_pp_apps01_rv=>gt_hdr = gt_formupdate.
**********************************************************************
    result = VALUE #( FOR ls_output IN lt_hdr ( %tky = ls_output-%tky
                                                    %param = ls_output ) ).











  ENDMETHOD.

  METHOD poval.
    READ ENTITIES OF zpp_apps01_rv IN LOCAL MODE
    ENTITY _Hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
*    DATA : lt_manu TYPE TABLE OF zbp_pp_apps01_rv=>ty_mfg_data.
    DATA(ls_plant) =  lt_hdr[ 1 ]-Werks.
    DATA(uuid) =  lt_hdr[ 1 ]-Uuid.
    DATA(ls_po) = keys[ 1 ]-%param-Pono.
    DATA(ls_sec) = keys[ 1 ]-%param-secno.




  ENDMETHOD.

ENDCLASS.

CLASS lhc__Item2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _Item2 RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _Item2 RESULT result.

    METHODS getoprt FOR MODIFY
      IMPORTING keys FOR ACTION _Item2~getoprt RESULT result.

    METHODS grpitm FOR MODIFY
      IMPORTING keys FOR ACTION _Item2~grpitm RESULT result.
    METHODS gtidata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Item2~gtidata1.
    METHODS reqty_val FOR VALIDATE ON SAVE
      IMPORTING keys FOR _Item2~reqty_val.

ENDCLASS.

CLASS lhc__Item2 IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zpp_apps01_rv  IN LOCAL MODE ENTITY _Item2
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT FINAL(lt_item).

    result = VALUE #( FOR ls_item IN lt_item ( %tky = ls_item-%tky
     %action-grpitm = COND #( WHEN ls_item-Reqty <> 0
                                                                THEN if_abap_behv=>fc-o-enabled
                                                                ELSE
                                                                if_abap_behv=>fc-o-disabled
                                                                )
  %features-%field-Reqty =  COND #( WHEN ls_item-Totopnqty = 0

                                                    THEN if_abap_behv=>fc-f-read_only

                                                    ELSE if_abap_behv=>fc-f-unrestricted  )

                                                                ) ).






  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD getoprt.
  ENDMETHOD.

  METHOD grpitm.

    DATA : gtitem  TYPE TABLE OF zpp_apps01_itb3,
           gsitem  TYPE zpp_apps01_itb3,
           gtitem2 TYPE TABLE OF zpp_apps01_itb1,
           gsitem2 TYPE zpp_apps01_itb1.

    READ ENTITIES OF zpp_apps01_rv
   IN LOCAL MODE ENTITY _Item2
     ALL FIELDS WITH CORRESPONDING #( keys )
   RESULT DATA(lt_item1).
    DATA(ls_item1) = lt_item1[ 1 ].
    IF ls_item1-%is_draft IS  INITIAL.
      MOVE-CORRESPONDING ls_item1 TO gsitem.

      SELECT SINGLE SUM( reqty ) AS totqty
      FROM zpp_apps01_itb1 WHERE orderno = @ls_item1-Orderno AND matnr = @ls_item1-Matnr INTO @DATA(wa_ord).

      IF wa_ord IS NOT INITIAL.
        gsitem-totreqty = wa_ord + ls_item1-Reqty.
        gsitem-totopnqty = gsitem-plnqty - gsitem-totreqty.
      ELSE.
        gsitem-totreqty = ls_item1-Reqty .
        gsitem-totopnqty = gsitem-plnqty - gsitem-totreqty.

      ENDIF.

      SELECT SINGLE   FROM I_ManufacturingOrder  AS moh
      INNER JOIN I_BillOfMaterialItemTP_2 AS bom ON bom~BillOfMaterial = moh~BillOfMaterialInternalID
      FIELDS bom~YY1_matwidth_BMI ,bom~YY1_matwidth_BMIU , bom~YY1_matlength_BMI ,bom~YY1_matlength_BMIU , bom~yy1_wgtpc_bmi
      ,bom~yy1_wgtpc_bmiu,bom~yy1_untwgt_bmi,bom~yy1_untwgt_bmiu,bom~yy1_totwgt_bmi,bom~yy1_totwgt_bmiu
      WHERE moh~ManufacturingOrder = @ls_item1-Orderno
      INTO @DATA(ls_bom).

      IF sy-subrc = 0 .

        APPEND gsitem TO gtitem.

        SELECT SINGLE MAX( sno ) AS sno FROM zpp_apps01_itb1  WHERE uuid = @ls_item1-Uuid INTO @DATA(LV_Sno).
        IF gtitem IS NOT INITIAL.
          gtitem2 =  VALUE #( FOR ls IN gtitem INDEX INTO lv  ( uuid = ls-uuid
                                                                sno = lv_sno + lv
                                                                matnr =   ls-matnr
                                                                orderno = ls-orderno
                                                                orderitem = ls-orderitem
                                                                reqty = ls-reqty
                                                                uom = ls-uom
                                                                plant = ls-plant
                                                                vbeln = ls-vbeln
                                                                soitem = ls-soitem
                                                                plnqty = ls-plnqty
                                                                maktx = ls-maktx
                                                                matlent = ls_bom-YY1_matlength_BMI
                                                                matlentuom = ls_bom-YY1_matlength_BMIU
                                                                matwidth = ls_bom-YY1_matwidth_BMI
                                                                matwidthuom = ls_bom-YY1_matlength_BMIU
                                                                totwgh = ls_bom-yy1_wgtpc_bmi * ls-reqty
                                                                totwghuom = ls_bom-yy1_totwgt_bmiu
                                                                wgtpc = ls_bom-yy1_wgtpc_bmi
                                                                wgtpcuom = ls_bom-yy1_wgtpc_bmiu
                                                                untwgh = ls_bom-yy1_untwgt_bmi
                                                                untwghuom = ls_bom-yy1_untwgt_bmiu
                                                                operation = ls-operation


                                                                                        ) ).
        ENDIF.

      ENDIF.



      gsitem-reqty = 0.
      APPEND gsitem TO gtitem.


      zbp_pp_apps01_rv=>gt_item3 = gtitem.
      zbp_pp_apps01_rv=>gt_item1 = gtitem2.
      IF zbp_pp_apps01_rv=>gt_item1 IS NOT INITIAL.
        LOOP AT zbp_pp_apps01_rv=>gt_item1 ASSIGNING FIELD-SYMBOL(<gs_bitem>).
          READ ENTITIES OF i_billofmaterialtp_2 PRIVILEGED
      ENTITY billofmaterial
      EXECUTE explodebom
        FROM VALUE #(
          (
            plant          = <gs_bitem>-plant
            material       = <gs_bitem>-matnr
            billofmaterialcategory = 'M'
            %param-bomexplosionapplication = 'PP01'
            %param-explodebomlevelvalue = 0
          %param-requiredquantity = <gs_bitem>-reqty
        %param-bomexplosionismultilevel = 'X'
          )
        )
        RESULT  DATA(lt_result)
        FAILED DATA(ls_failed)
        REPORTED DATA(ls_reported).

          IF lt_result IS NOT INITIAL.
            zbp_pp_apps01_rv=>gt_citem = VALUE #( FOR ls_result IN lt_result INDEX INTO lv1 ( uuid = <gs_bitem>-uuid
                                                                sno =  <gs_bitem>-sno
                                                                sno1 = lv1
                                                                matnr = ls_result-%param-BillOfMaterialComponent
                                                                maktx = ls_result-%param-MaterialName
                                                                orderno = <gs_bitem>-orderno
                                                                comqty = ls_result-%param-ComponentQuantityInCompUoM
                                                                baseqty = ls_result-%param-ComponentQuantityInBaseUoM
                                                                baseuom = ls_result-%param-BaseUnit
                                                                comuom  = ls_result-%param-UnitOfMeasure

             ) ).
            CLEAR lt_result.

          ENDIF.



        ENDLOOP.
      ENDIF.

    ELSE.
      DATA(lv_msg2) = |You are in Edit Mode Please Save the Document|.
      APPEND VALUE #( %tky = ls_item1-%tky )
                  TO failed-_item2.

      APPEND VALUE #( %tky           = ls_item1-%tky
                      %state_area    = 'Validate_Item'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg2 )   )
             TO reported-_item2.
    ENDIF.
  ENDMETHOD.

  METHOD gtidata1.
    READ ENTITIES OF zpp_apps01_rv IN LOCAL MODE
   ENTITY _Item2
   ALL FIELDS WITH CORRESPONDING #( keys )
   RESULT DATA(lt_item).

    zbp_pp_apps01_rv=>gt_item3 = VALUE #( FOR ls IN lt_item ( uuid = ls-Uuid
                                                             plant = ls-Plant
                                                             orderno = ls-Orderno
                                                             orderitem = ls-Orderitem
                                                             matnr =  ls-Matnr
                                                             maktx = ls-Maktx
                                                             plnqty = ls-Plnqty
                                                             reqty = ls-Reqty
                                                             totreqty = ls-Totreqty
                                                             rsnum = ls-Rsnum
                                                             uom = ls-Uom
                                                             totopnqty = ls-Plnqty - ls-Totreqty
                                                             vbeln = ls-Vbeln
                                                             soitem = ls-Soitem
                                                             operation = ls-Operation
                                                             secon = ls-Secon

                                                              ) ).
  ENDMETHOD.

  METHOD reqty_val.

    READ ENTITIES OF zpp_apps01_rv IN LOCAL MODE
     ENTITY _Item2
    ALL FIELDS WITH CORRESPONDING #( keys  )
    RESULT DATA(lt_item).









    reported-_item2 = VALUE #( FOR ls IN lt_item ( %tky =  ls-%tky
    %msg = COND #( WHEN ls-Reqty > ls-Totopnqty
    THEN

     new_message_with_text( severity = if_abap_behv_message=>severity-error
    text = |Requested Qty { ls-Reqty } exceeds Open Qty { ls-Totopnqty }| )

    ELSE
      new_message_with_text( severity = if_abap_behv_message=>severity-success
    text = |Requested Qty { ls-Reqty } Ok| )
      )
        ) ) .

*                failed-_item2 = VALUE #( lt_item[ billingreference  = <lfs_podet1>-billingreference gateitem = <fs_billref>-billingdocumentitem ]-item OPTIONAL ).

    LOOP AT lt_item INTO DATA(ls1).
      IF ls1-Reqty > ls1-Totopnqty.
        APPEND VALUE #( %tky = ls1-%tky  ) TO failed-_item2.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APPS01_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APPS01_RV IMPLEMENTATION.

  METHOD save_modified.

    IF zbp_pp_apps01_rv=>gt_hdr IS NOT INITIAL.
      MODIFY zpp_apps01_htb1 FROM TABLE @zbp_pp_apps01_rv=>gt_hdr.
    ENDIF.

    IF zbp_pp_apps01_rv=>gt_item3 IS NOT INITIAL.
      MODIFY zpp_apps01_itb3 FROM TABLE @zbp_pp_apps01_rv=>gt_item3.
    ENDIF.
    IF zbp_pp_apps01_rv=>gt_item1 IS NOT INITIAL.
      MODIFY zpp_apps01_itb1 FROM TABLE @zbp_pp_apps01_rv=>gt_item1.
    ENDIF.
    IF zbp_pp_apps01_rv=>gt_citem IS NOT INITIAL.
      MODIFY zpp_apps01_itb2 FROM TABLE @zbp_pp_apps01_rv=>gt_citem.
    ENDIF.

    IF delete-_hdr IS NOT INITIAL.
      LOOP AT delete-_hdr  INTO DATA(ls_del).
        DELETE FROM zpp_apps01_htb1 WHERE uuid = @ls_del-Uuid.
        DELETE FROM zpp_apps01_itb1 WHERE uuid = @ls_del-Uuid.
        DELETE FROM zpp_apps01_itb3 WHERE uuid = @ls_del-Uuid.
        DELETE FROM zpp_apps01_itb2 WHERE uuid = @ls_del-Uuid.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
