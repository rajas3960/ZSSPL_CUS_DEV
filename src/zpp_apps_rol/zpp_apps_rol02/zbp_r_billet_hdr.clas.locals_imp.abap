CLASS lhc_zr_billet_hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_billet_hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_billet_hdr RESULT result.

    METHODS headerdetails FOR DETERMINE ON SAVE
      IMPORTING keys FOR zr_billet_hdr~headerdetails.

    METHODS headerdetails1 FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zr_billet_hdr~headerdetails1.

    METHODS post101 FOR MODIFY
      IMPORTING keys FOR ACTION zr_billet_hdr~post101 RESULT result.

    METHODS post261 FOR MODIFY
      IMPORTING keys FOR ACTION zr_billet_hdr~post261 RESULT result.

    METHODS post531 FOR MODIFY
      IMPORTING keys FOR ACTION zr_billet_hdr~post531 RESULT result.

    METHODS postcheck FOR MODIFY
      IMPORTING keys FOR ACTION zr_billet_hdr~postcheck RESULT result.

    METHODS postcnf FOR MODIFY
      IMPORTING keys FOR ACTION zr_billet_hdr~postcnf RESULT result.

    METHODS getcons FOR MODIFY
      IMPORTING keys FOR ACTION zr_billet_hdr~getcons RESULT result.

    METHODS dummyupdate FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zr_billet_hdr~dummyupdate.
    METHODS extend FOR MODIFY
      IMPORTING keys FOR ACTION zr_billet_hdr~extend RESULT result.

ENDCLASS.


CLASS lhc_zr_billet_hdr IMPLEMENTATION.
  METHOD get_instance_features.
    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS  WITH CORRESPONDING #( keys )
         RESULT FINAL(gt_header)
         " TODO: variable is assigned but never used (ABAP cleaner)
         FAILED FINAL(gt_failed).
    DATA: lvcrt TYPE string VALUE 'Created'.

    result = VALUE #( FOR gs_header IN gt_header
                      ( %tky              = gs_header-%tky

                        %update           = COND #( WHEN gs_header-status = lvcrt
                                                      OR gs_header-status = ''
                                                    THEN if_abap_behv=>fc-o-enabled
                                                    ELSE if_abap_behv=>fc-o-disabled )

                        %assoc-_101       = if_abap_behv=>fc-o-disabled
                        %assoc-_261       = if_abap_behv=>fc-o-disabled
                        %assoc-_531       = if_abap_behv=>fc-o-disabled
                        %assoc-_htb       = if_abap_behv=>fc-o-disabled

                        %action-getcons   = COND #( WHEN gs_header-status = 'Created'
                                                    THEN if_abap_behv=>fc-o-enabled
                                                    ELSE if_abap_behv=>fc-o-disabled )

                        %action-postcheck = COND #( WHEN gs_header-status = 'Cons. Fetched'
                                                    THEN if_abap_behv=>fc-o-enabled
                                                    ELSE if_abap_behv=>fc-o-disabled )

                        %action-postcnf   = COND #( WHEN gs_header-status = 'Checked'
                                                    THEN if_abap_behv=>fc-o-enabled
                                                    ELSE if_abap_behv=>fc-o-disabled )

                        %action-post101   = COND #( WHEN gs_header-status = 'GI Posted' "Confirmed
                                                    THEN if_abap_behv=>fc-o-enabled
                                                    ELSE if_abap_behv=>fc-o-disabled )

                        %action-post261   = COND #( WHEN gs_header-status = 'Checked'
                                                    THEN if_abap_behv=>fc-o-enabled
                                                    ELSE if_abap_behv=>fc-o-disabled )

                        %action-extend    = COND #( WHEN gs_header-getcons = 'X'
                                                    THEN if_abap_behv=>fc-o-disabled
                                                    ELSE if_abap_behv=>fc-o-enabled )

                        %action-post531   = COND #( WHEN gs_header-status = 'GR Posted'
                                                    THEN if_abap_behv=>fc-o-enabled
                                                    ELSE if_abap_behv=>fc-o-disabled ) ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD headerdetails.
    DATA lv_referencelike TYPE zr_billet_hdr-referenceid.
    DATA lv_no            TYPE zde_no                    VALUE 1.
    DATA lv_reference     TYPE zr_billet_hdr-referenceid.
    DATA lv_item          TYPE zr_billet_531-item.
    DATA lv_count         TYPE zde_no                    VALUE 1.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS  WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT DATA(gt_header) FAILED FINAL(failed).

    TRY.
        GET TIME STAMP FIELD FINAL(lv_utctimestamp).
        " TODO: variable is assigned but never used (ABAP cleaner)
        CONVERT TIME STAMP lv_utctimestamp TIME ZONE 'INDIA' INTO DATE FINAL(lv_date) TIME FINAL(lv_time).
      CATCH cx_abap_context_info_error.
        DATA(lv_er) = 1.
    ENDTRY.

    LOOP AT gt_header ASSIGNING FIELD-SYMBOL(<fs_head>).
      IF <fs_head> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.

      <fs_head>-status = 'Created'.
      lv_referencelike = |%{ lv_date+2(2) }{ lv_date+4(2) }%|.

      SELECT  FROM zr_billet_hdr FIELDS
      referenceid, productionorder
        WHERE referenceid LIKE @lv_referencelike
        INTO TABLE @DATA(lt_zr_billet_hdr).
      IF sy-subrc = 0.
        SORT lt_zr_billet_hdr BY referenceid DESCENDING.
        FINAL(ls_zr_billet_hdr) = VALUE #( lt_zr_billet_hdr[ 1 ] OPTIONAL ).
        lv_no = ls_zr_billet_hdr-referenceid+4(6) + 1.
      ENDIF.
      lv_reference = lv_date+2(2) && lv_date+4(2) && lv_no.

      " Header
      MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
             ENTITY zr_billet_hdr
             UPDATE
             FIELDS ( status referenceid )
             WITH VALUE #( FOR key IN keys
                           ( %tky                 = <fs_head>-%tky
                             status               = <fs_head>-status
                             referenceid          = lv_reference

                             %control-status      = if_abap_behv=>mk-on
                             %control-referenceid = if_abap_behv=>mk-on ) ).
    ENDLOOP.

    LOOP AT gt_header ASSIGNING FIELD-SYMBOL(<fs_head01>).
      IF <fs_head01> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.

      SELECT SINGLE  FROM i_manufacturingorder WITH PRIVILEGED ACCESS
      FIELDS
      BillOfMaterialInternalID,
      StorageLocation
        WHERE manufacturingorder = @<fs_head01>-productionorder
        INTO @FINAL(ls_mnford).

      SELECT  FROM i_billofmaterialitemtp_3 WITH PRIVILEGED ACCESS
      FIELDS
      billofmaterialvariant ,
      billofmaterialitemquantity,
      componentdescription,
      billofmaterialcomponent
        WHERE billofmaterial = @ls_mnford-billofmaterialinternalid
          AND billofmaterialvariant = '01'
        INTO TABLE @FINAL(lt_bom).

      DATA(lt_531) = lt_bom.
      DATA(lt_261) = lt_bom.
      DELETE lt_261 WHERE billofmaterialvariant <> '01'.
      DELETE lt_531 WHERE billofmaterialitemquantity > 0.
      DELETE lt_261 WHERE billofmaterialitemquantity < 0.

      " Billet
      TRY.
          lv_item = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
        CATCH cx_uuid_error.
          DATA(lv_er3) = 1.
      ENDTRY.
      SELECT  FROM zpp_apps_plnvh  AS hdr
      LEFT JOIN ZPP_APPS_ROL02cv AS bal ON bal~PurchaseOrder = hdr~PurchaseOrder AND bal~PurchaseOrderItem =  hdr~PurchaseOrderItem
      FIELDS
         hdr~YY1_Length_PDI,
      hdr~YY1_Width_PDI,
      hdr~YY1_Pieces_PDI,
      hdr~PurchaseOrderItem,
      hdr~PurchaseOrder,
      hdr~YY1_PriorityPONO_PDH,
      bal~bal

      WHERE manufat = @<fs_head01>-productionorder INTO TABLE @DATA(lt_item).
*      DO <fs_head01>-noofbatches TIMES.
      IF lt_item IS NOT INITIAL.
        LOOP AT lt_item INTO DATA(ls_item).
          lv_count += 1.
          MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
                 ENTITY zr_billet_hdr
                 CREATE BY \_101
                 FROM VALUE #( ( id      = <fs_head01>-id
                                 %target = VALUE #( ( %cid                 = <fs_head01>-referenceid && lv_count
                                                      item                 = <fs_head01>-referenceid && lv_count
                                                      referenceid          = <fs_head01>-referenceid
                                                      material             = <fs_head01>-material
                                                      uom                  = <fs_head01>-uom
                                                      plant                = <fs_head01>-plant
                                                      storagelocation      = ls_mnford-storagelocation

*                                                     batch                = 'BILLET'
                                                      length = ls_item-YY1_Length_PDI
                                                      width = ls_item-YY1_Width_PDI
                                                      pcs = ls_item-YY1_Pieces_PDI
                                                      purchaseitm = ls_item-PurchaseOrderItem
                                                      purchaseorder = ls_item-PurchaseOrder
                                                      prioritypo = ls_item-YY1_PriorityPONO_PDH
                                                      lengthmtr = ls_item-YY1_Length_PDI
                                                      piece = 0
                                                      balance1 = ls_item-bal



                                                      %control-item        = if_abap_behv=>mk-on
                                                      %control-referenceid = if_abap_behv=>mk-on
                                                      %control-material    = if_abap_behv=>mk-on
                                                      %control-plant       = if_abap_behv=>mk-on
                                                      %control-storagelocation = if_abap_behv=>mk-on
*                                                    %control-batch       = if_abap_behv=>mk-on
                                                      %control-uom         = if_abap_behv=>mk-on
                                                      %control-length = if_abap_behv=>mk-on
                                                      %control-width = if_abap_behv=>mk-on
                                                      %control-pcs = if_abap_behv=>mk-on
                                                      %control-purchaseitm = if_abap_behv=>mk-on
                                                      %control-purchaseorder = if_abap_behv=>mk-on
                                                      %control-prioritypo = if_abap_behv=>mk-on
                                                      %control-lengthmtr = if_abap_behv=>mk-on
                                                      %control-piece = if_abap_behv=>mk-on
                                                        %control-balance1 = if_abap_behv=>mk-on

                                                      ) ) ) )
                 " TODO: variable is assigned but never used (ABAP cleaner)
                 MAPPED FINAL(ls_mapped_101)
                 " TODO: variable is assigned but never used (ABAP cleaner)
                 FAILED FINAL(ls_failed_101)
                 " TODO: variable is assigned but never used (ABAP cleaner)
                 REPORTED FINAL(ls_reported_101).
*      ENDDO.
        ENDLOOP.
      ELSE .
        lv_count = 1.
        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
                    ENTITY zr_billet_hdr
                    CREATE BY \_101
                    FROM VALUE #( ( id      = <fs_head01>-id
                                    %target = VALUE #( ( %cid                 = <fs_head01>-referenceid && lv_count
                                                         item                 = <fs_head01>-referenceid && lv_count
                                                         referenceid          = <fs_head01>-referenceid
                                                         material             = <fs_head01>-material
                                                         uom                  = <fs_head01>-uom
                                                         plant                = <fs_head01>-plant
                                                         storagelocation      = ls_mnford-storagelocation

*                                                    batch                = 'BILLET'

                                                         %control-item        = if_abap_behv=>mk-on
                                                         %control-referenceid = if_abap_behv=>mk-on
                                                         %control-material    = if_abap_behv=>mk-on
                                                         %control-plant       = if_abap_behv=>mk-on
                                                         %control-storagelocation = if_abap_behv=>mk-on
*                                                    %control-batch       = if_abap_behv=>mk-on
                                                         %control-uom         = if_abap_behv=>mk-on


                                                         ) ) ) )
                    " TODO: variable is assigned but never used (ABAP cleaner)
                    MAPPED FINAL(ls_mapped_1011)
                    " TODO: variable is assigned but never used (ABAP cleaner)
                    FAILED FINAL(ls_failed_1011)
                    " TODO: variable is assigned but never used (ABAP cleaner)
                    REPORTED FINAL(ls_reported_1011).



      ENDIF.

      " By-Product
      TRY.
          lv_item = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
        CATCH cx_uuid_error.
          DATA(lv_er04) = 1.
      ENDTRY.

      LOOP AT lt_531 INTO DATA(ls_531).
        lv_count += 1.
        SELECT SINGLE  FROM i_product WITH PRIVILEGED ACCESS FIELDS BaseUnit ,Product WHERE product = @ls_531-billofmaterialcomponent INTO @FINAL(ls_prod_531).
        IF sy-subrc = 0.
        ENDIF.
        SELECT SINGLE FROM I_ProductionOrderComponent WITH PRIVILEGED ACCESS FIELDS StorageLocation ,
        Reservation ,ReservationItem WHERE ProductionOrder = @<fs_head01>-productionorder AND Material = @ls_531-BillOfMaterialComponent
        AND Plant = @<fs_head01>-plant INTO @DATA(ls_stor).
        IF sy-subrc = 0.
        ENDIF.
        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
               ENTITY zr_billet_hdr
               CREATE BY \_531
               FROM VALUE #( ( id      = <fs_head01>-id
                               %target = VALUE #( ( %cid                         = <fs_head01>-referenceid && lv_count
                                                    item                         = <fs_head01>-referenceid && lv_count
                                                    referenceid                  = <fs_head01>-referenceid
                                                    material                     = ls_531-billofmaterialcomponent
                                                    materialdescription          = ls_531-componentdescription
                                                    uom                          = ls_prod_531-baseunit
                                                    plant                        = <fs_head01>-plant
                                                    storagelocation              = ls_stor-StorageLocation
                                                    rsnum                        = ls_stor-Reservation
                                                    rspos                        = ls_stor-ReservationItem
                                                    %control-item                = if_abap_behv=>mk-on
                                                    %control-referenceid         = if_abap_behv=>mk-on
                                                    %control-material            = if_abap_behv=>mk-on
                                                    %control-plant               = if_abap_behv=>mk-on
                                                    %control-materialdescription = if_abap_behv=>mk-on
                                                    %control-storagelocation     = if_abap_behv=>mk-on
                                                    %control-uom                 = if_abap_behv=>mk-on
                                                      %control-rsnum                        = if_abap_behv=>mk-on
                                                      %control-rspos                        = if_abap_behv=>mk-on

                                                    ) ) ) )
               " TODO: variable is assigned but never used (ABAP cleaner)
               MAPPED FINAL(ls_mapped_531)
               " TODO: variable is assigned but never used (ABAP cleaner)
               FAILED FINAL(ls_failed_531)
               " TODO: variable is assigned but never used (ABAP cleaner)
               REPORTED FINAL(ls_reported_531).
      ENDLOOP.

    ENDLOOP.
  ENDMETHOD.

  METHOD headerdetails1.
    DATA lv_clfnobjectid TYPE c LENGTH 90.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS  WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT DATA(gt_header) FAILED FINAL(failed).

    LOOP AT gt_header ASSIGNING FIELD-SYMBOL(<fs_head>).
      IF <fs_head> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.

      <fs_head>-status = 'Draft'.

      SELECT SINGLE Product, ProductionPlant,openyieldquantity  FROM   i_productionorderitemtp  WITH PRIVILEGED ACCESS
        WHERE productionorder = @<fs_head>-productionorder
        INTO @FINAL(ls_prdord)  .

      SELECT SINGLE  FROM i_producttext WITH PRIVILEGED ACCESS
      FIELDS
      Product,
      ProductName
        WHERE product  = @ls_prdord-product
          AND language = 'E'
        INTO @FINAL(ls_prodtext).

      SELECT SINGLE  FROM i_product WITH PRIVILEGED ACCESS
      FIELDS
      Product,
      BaseUnit,
      yy1_unit_wgt_prd

        WHERE product = @ls_prdord-product
        INTO @FINAL(ls_prod).
****************************NO USE OF THIS ONE******************************************

      lv_clfnobjectid = |{ ls_prdord-productionplant }{ <fs_head>-caster }|.

      " Density
*      SELECT SINGLE * FROM i_clfncharacteristic
*        WHERE characteristic = 'DENSITY'
*        INTO @FINAL(ls_clfndensity).
*
*      SELECT SINGLE * FROM i_clfnobjectcharcvalue
*        WHERE charcinternalid = @ls_clfndensity-charcinternalid
*          AND clfnobjectid    = @lv_clfnobjectid
*        INTO @FINAL(ls_valdensity).
*
*      " Height
*      SELECT SINGLE * FROM i_clfncharacteristic
*        WHERE characteristic = 'HEIGHT'
*        INTO @FINAL(ls_clfnheight).
*
*      SELECT SINGLE * FROM i_clfnobjectcharcvalue
*        WHERE charcinternalid = @ls_clfnheight-charcinternalid
*          AND clfnobjectid    = @lv_clfnobjectid
*        INTO @FINAL(ls_valheight).
*
*      " Weight
*      SELECT SINGLE * FROM i_clfncharacteristic
*        WHERE characteristic = 'WIDTH'
*        INTO @FINAL(ls_clfnwidth).
*
*      SELECT SINGLE * FROM i_clfnobjectcharcvalue
*        WHERE charcinternalid = @ls_clfnwidth-charcinternalid
*          AND clfnobjectid    = @lv_clfnobjectid
*        INTO @FINAL(ls_valwidth).
**********************************************************************

      MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
             ENTITY zr_billet_hdr
             UPDATE
             FIELDS ( status material materialdesc orderquantity uom density width height plant )
             WITH VALUE #( FOR key IN keys
                           ( %tky                   = <fs_head>-%tky
                             status                 = <fs_head>-status
                             material               = ls_prdord-product
                             materialdesc           = ls_prodtext-productname
                             orderquantity          = ls_prdord-openyieldquantity
                             uom                    = ls_prod-baseunit
                             density                = |{ ls_prod-yy1_unit_wgt_prd }|
                             plant                  = ls_prdord-productionplant
                             %control-status        = if_abap_behv=>mk-on
                             %control-material      = if_abap_behv=>mk-on
                             %control-materialdesc  = if_abap_behv=>mk-on
                             %control-orderquantity = if_abap_behv=>mk-on
                             %control-uom           = if_abap_behv=>mk-on
                             %control-density       = if_abap_behv=>mk-on

                             %control-plant         = if_abap_behv=>mk-on
                             ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD post101.
    DATA lv_item TYPE zr_billet_101-item.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS  WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_header) FAILED FINAL(ft_header)
         RESULT DATA(gt_header)
         BY \_101
         ALL FIELDS  WITH CORRESPONDING #( keys )
          RESULT FINAL(gt_101).

    IF gt_header[ 1 ]-%is_draft = 01.
      APPEND VALUE #( %tky             = gt_header[ 1 ]-%tky
                %state_area      = 'Validate_Head'
                %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                          text     = 'Disable the Draft Mode' )
                %element-post101 = if_abap_behv=>mk-on )
       TO reported-zr_billet_hdr.

      APPEND VALUE #( %tky = gt_header[ 1 ]-%tky )
             TO failed-zr_billet_hdr.
      RETURN.
    ENDIF.

*    READ ENTITY zr_billet_hdr
*         BY \_101
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_101) FAILED FINAL(ft_101).

    TRY.
        lv_item = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
      CATCH cx_uuid_error.
        DATA(lv_er05) = 1.
    ENDTRY.

    LOOP AT gt_header ASSIGNING FIELD-SYMBOL(<fs_head>).
      IF <fs_head> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.
**********************************************************************
* Batch Auto Generation Logic
*--------------------------------------------------------------------*

      DATA: lv_date      TYPE sy-datum,
            lv_prefix    TYPE string,
            lv_like      TYPE string,
            lv_lastbatch TYPE zdt_billet_101-batch,
            lv_lastnum   TYPE i.

      lv_date = cl_abap_context_info=>get_system_date( ).

* MMDDYY Format
      lv_prefix = |{ lv_date+4(2) }{ lv_date+6(2) }{ lv_date+2(2) }|.

* LIKE Pattern
      lv_like = |{ lv_prefix }-%|.

* Read Last Batch Number
      SELECT batch
        FROM zdt_billet_101
        WHERE batch LIKE @lv_like
        ORDER BY batch DESCENDING
        INTO @lv_lastbatch
        UP TO 1 ROWS.
      ENDSELECT.

      IF sy-subrc = 0.

* Get Last Running Number
        lv_lastnum = lv_lastbatch+7(3).

      ELSE.

        lv_lastnum = 0.

      ENDIF.
**********************************************************************

      " ==101 Movement
      MODIFY ENTITIES OF I_MaterialDocumentTP PRIVILEGED
             ENTITY materialdocument
             CREATE FROM VALUE #( ( %cid                                = lv_item
                                    goodsmovementcode                   = '02'
                                    postingdate                         = <fs_head>-postingdate
                                    documentdate                        = cl_abap_context_info=>get_system_date( )
                                    materialdocumentheadertext          = <fs_head>-referenceid
                                    %control-goodsmovementcode          = cl_abap_behv=>flag_changed
                                    %control-postingdate                = cl_abap_behv=>flag_changed
                                    %control-documentdate               = cl_abap_behv=>flag_changed
                                    %control-materialdocumentheadertext = cl_abap_behv=>flag_changed ) )
             ENTITY materialdocument
             CREATE BY \_materialdocumentitem
             FROM VALUE #( ( %cid_ref = lv_item
                             %target  = VALUE #( FOR gs_101 IN gt_101  WHERE ( quantity <> 0 AND checkbox = abap_true )

                                                 ( %cid                              = gs_101-item
                                                   plant                             = gs_101-plant
                                                   material                          = gs_101-material
                                                   goodsmovementtype                 = '101'
                                                   storagelocation                   = gs_101-storagelocation
                                                   quantityinentryunit               = gs_101-quantity
                                                   entryunit                         = gs_101-uom
                                                   manufacturingorder                = <fs_head>-productionorder
                                                   manufacturedate                   = <fs_head>-postingdate
                                                   batch                             = |{ lv_prefix }-{ lv_lastnum + sy-tabix WIDTH = 3 PAD = '0' }|
                                                   goodsmovementrefdoctype           = 'F'
                                                   materialdocumentitemtext          = |{ gs_101-piece } PC|
                                                   YY1_Length_No_MMI                 = gs_101-lengthmtr
                                                   YY1_Pieces_No_MMI                 = gs_101-piece
*                                                   PurchaseOrder                     = gs_101-purchaseorder
*                                                   PurchaseOrderItem                 = gs_101-purchaseitm


                                                   %control-plant                    = cl_abap_behv=>flag_changed
                                                   %control-material                 = cl_abap_behv=>flag_changed
                                                   %control-goodsmovementtype        = cl_abap_behv=>flag_changed
                                                   %control-storagelocation          = cl_abap_behv=>flag_changed
                                                   %control-quantityinentryunit      = cl_abap_behv=>flag_changed
                                                   %control-entryunit                = cl_abap_behv=>flag_changed
                                                   %control-manufacturingorder       = cl_abap_behv=>flag_changed
                                                   %control-batch                    = cl_abap_behv=>flag_changed
                                                   %control-goodsmovementrefdoctype  = cl_abap_behv=>flag_changed
                                                   %control-materialdocumentitemtext = cl_abap_behv=>flag_changed
                                                   %control-manufacturedate          = cl_abap_behv=>flag_changed
                                                   %control-YY1_Length_No_MMI        = cl_abap_behv=>flag_changed
                                                   %control-YY1_Pieces_No_MMI        = cl_abap_behv=>flag_changed
*                                                   %control-PurchaseOrder            = cl_abap_behv=>flag_changed
*                                                   %control-PurchaseOrderItem        = cl_abap_behv=>flag_changed

                                                    ) ) ) )

             " TODO: variable is assigned but never used (ABAP cleaner)
             MAPPED FINAL(mapped_101)
             " TODO: variable is assigned but never used (ABAP cleaner)
             FAILED FINAL(failed_101)
             REPORTED FINAL(reported_101).

      IF reported_101-materialdocument IS NOT INITIAL.
        APPEND VALUE #( %tky             = <fs_head>-%tky
                        %state_area      = 'Validate_Head'
                        %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = |Error in Billet Production| )
                        %element-post101 = if_abap_behv=>mk-on )
               TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = <fs_head>-%tky )
               TO failed-zr_billet_hdr.

      ELSE.

        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
               ENTITY zr_billet_hdr
               UPDATE
               FIELDS ( post101 status progress )
               WITH VALUE #( ( %tky     = <fs_head>-%tky
                               status   = 'GR Posted'
                               progress = 60
                               post101  = 'X' ) ).

      ENDIF.
    ENDLOOP.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT FINAL(header_result).

    result = VALUE #( FOR ls_header_result IN header_result
                      ( %tky   = ls_header_result-%tky
                        %param = ls_header_result ) ).
  ENDMETHOD.

  METHOD post261.
    DATA lv_item     TYPE zr_billet_261-item.
    DATA lv_status   TYPE zr_billet_hdr-status.
    DATA lv_progress TYPE zr_billet_hdr-progress.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_header) FAILED FINAL(ft_header).
         RESULT DATA(gt_header)
          BY \_101
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_101)
          BY \_261
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_261)
          BY \_531
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_531).

    IF gt_header[ 1 ]-%is_draft = 01.
      APPEND VALUE #( %tky             = gt_header[ 1 ]-%tky
                %state_area      = 'Validate_Head'
                %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                          text     = 'Disable the Draft Mode' )
                %element-post101 = if_abap_behv=>mk-on )
       TO reported-zr_billet_hdr.

      APPEND VALUE #( %tky = gt_header[ 1 ]-%tky )
             TO failed-zr_billet_hdr.
      RETURN.
    ENDIF.

    IF gt_261 IS NOT INITIAL.
      DATA(gs_261) = gt_261[ 1 ].
      SELECT SINGLE FROM I_ReservationDocumentItem  FIELDS ReservationItemIsFinallyIssued
      WHERE Reservation = @gs_261-rsnum AND ReservationItem = @gs_261-rspos
      INTO @DATA(ls_mark).

      IF ls_mark = 'X'.
        APPEND VALUE #( %tky             = gt_header[ 1 ]-%tky
                         %state_area      = 'Validate_Head'
                         %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                   text     = 'Goods Issue Already Posted This Production Order' )
                         %element-post101 = if_abap_behv=>mk-on )
                TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = gt_header[ 1 ]-%tky )
               TO failed-zr_billet_hdr.
        RETURN.

      ENDIF.


    ENDIF.

*    READ ENTITY zr_billet_hdr
*         BY \_101
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_101) FAILED FINAL(ft_101).

*    READ ENTITY zr_billet_hdr
*         BY \_261
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_261) FAILED FINAL(ft_261).

*    READ ENTITY zr_billet_hdr
*         BY \_531
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_531) FAILED FINAL(ft_531).

    TRY.
        lv_item = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
      CATCH cx_uuid_error.
        DATA(lv_er06) = 1.
    ENDTRY.

    DATA(lt_531) = gt_531.
    DELETE lt_531 WHERE quantity = 0.
    FINAL(lv_lines531) = lines( lt_531 ).

    LOOP AT gt_header ASSIGNING FIELD-SYMBOL(<fs_head>).
      IF <fs_head> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.

      MODIFY ENTITIES OF I_MaterialDocumentTP PRIVILEGED
             ENTITY materialdocument
             CREATE FROM VALUE #( ( %cid                                = lv_item
                                    goodsmovementcode                   = '03'
                                    postingdate                         = <fs_head>-postingdate
                                    documentdate                        = cl_abap_context_info=>get_system_date( )
                                    materialdocumentheadertext          = <fs_head>-referenceid
                                    %control-goodsmovementcode          = cl_abap_behv=>flag_changed
                                    %control-postingdate                = cl_abap_behv=>flag_changed
                                    %control-documentdate               = cl_abap_behv=>flag_changed
                                    %control-materialdocumentheadertext = cl_abap_behv=>flag_changed ) )
             ENTITY materialdocument
             CREATE BY \_materialdocumentitem
             FROM VALUE #( ( %cid_ref = lv_item
                             %target  = VALUE #( FOR gs_261_t IN gt_261
                                                 ( %cid                         = gs_261_t-heatnumber
                                                   plant                        = <fs_head>-plant
                                                   material                     = gs_261_t-material
                                                   goodsmovementtype            = '261'
                                                   storagelocation              = gs_261_t-storagelocation
                                                   quantityinentryunit          = gs_261_t-quantitys
                                                   entryunit                    = gs_261_t-uom
                                                   batch                        = gs_261_t-heatnumber
                                                   manufacturingorder           = <fs_head>-productionorder
                                                   Reservation                  = gs_261_t-rsnum
                                                   ReservationItem              = gs_261_t-rspos

                                                   %control-plant               = cl_abap_behv=>flag_changed
                                                   %control-material            = cl_abap_behv=>flag_changed
                                                   %control-goodsmovementtype   = cl_abap_behv=>flag_changed
                                                   %control-storagelocation     = cl_abap_behv=>flag_changed
                                                   %control-quantityinentryunit = cl_abap_behv=>flag_changed
                                                   %control-entryunit           = cl_abap_behv=>flag_changed
                                                   %control-batch               = cl_abap_behv=>flag_changed
                                                   %control-manufacturingorder  = cl_abap_behv=>flag_changed
                                                    %control-Reservation                  = cl_abap_behv=>flag_changed
                                                      %control-ReservationItem              = cl_abap_behv=>flag_changed

                                                   ) ) ) )

             " TODO: variable is assigned but never used (ABAP cleaner)
             MAPPED FINAL(mapped_261)
             " TODO: variable is assigned but never used (ABAP cleaner)
             FAILED FINAL(failed_261)
             REPORTED FINAL(reported_261).

      IF reported_261-materialdocument IS NOT INITIAL.
        APPEND VALUE #( %tky             = <fs_head>-%tky
                        %state_area      = 'Validate_Head'
                        %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = 'Error in Consumption' )
                        %element-post261 = if_abap_behv=>mk-on )
               TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = <fs_head>-%tky )
               TO failed-zr_billet_hdr.

      ELSE.

        IF lv_lines531 > 0.
          lv_status   = 'GI Posted'.
          lv_progress = 80.
        ELSE.
          lv_progress = 100.
          lv_status   = 'Completed'.
        ENDIF.

        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
               ENTITY zr_billet_hdr
               UPDATE
               FIELDS ( post261 status progress )
               WITH VALUE #( ( %tky     = <fs_head>-%tky
                               status   = lv_status
                               progress = lv_progress
                               post261  = 'X' ) ).

      ENDIF.
    ENDLOOP.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT FINAL(header_result).

    result = VALUE #( FOR ls_header_result IN header_result
                      ( %tky   = ls_header_result-%tky
                        %param = ls_header_result ) ).
  ENDMETHOD.

  METHOD post531.
    DATA lv_item TYPE zr_billet_261-item.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS  WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_header) FAILED FINAL(ft_header)
            RESULT FINAL(gt_header)
          BY \_101
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_101)
         BY \_531
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_531).


*    READ ENTITY zr_billet_hdr
*         BY \_101
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_101) FAILED FINAL(ft_101).

*    READ ENTITY zr_billet_hdr
*         BY \_531
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_531) FAILED FINAL(ft_531).
    IF gt_header[ 1 ]-%is_draft = 01.
      APPEND VALUE #( %tky             = gt_header[ 1 ]-%tky
                %state_area      = 'Validate_Head'
                %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                          text     = 'Disable the Draft Mode' )
                %element-post101 = if_abap_behv=>mk-on )
       TO reported-zr_billet_hdr.

      APPEND VALUE #( %tky = gt_header[ 1 ]-%tky )
             TO failed-zr_billet_hdr.
      RETURN.
    ENDIF.

    TRY.
        lv_item = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
      CATCH cx_uuid_error.
        DATA(lv_er07) = 1.
    ENDTRY.

    LOOP AT gt_header ASSIGNING FIELD-SYMBOL(<fs_head>).
      IF <fs_head> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.

      TRY.
          GET TIME STAMP FIELD FINAL(lv_utctimestamp).
          " TODO: variable is assigned but never used (ABAP cleaner)
          CONVERT TIME STAMP lv_utctimestamp TIME ZONE 'INDIA' INTO DATE FINAL(lv_date) TIME FINAL(lv_time).
        CATCH cx_abap_context_info_error.
          DATA(lv_er08) = 1.
      ENDTRY.

      MODIFY ENTITIES OF I_MaterialDocumentTP PRIVILEGED
             ENTITY materialdocument
             CREATE FROM VALUE #( ( %cid                                = lv_item
                                    goodsmovementcode                   = '05'
                                    postingdate                         = <fs_head>-postingdate
                                    documentdate                        = cl_abap_context_info=>get_system_date( )
                                    materialdocumentheadertext          = <fs_head>-referenceid
                                    %control-goodsmovementcode          = cl_abap_behv=>flag_changed
                                    %control-postingdate                = cl_abap_behv=>flag_changed
                                    %control-documentdate               = cl_abap_behv=>flag_changed
                                    %control-materialdocumentheadertext = cl_abap_behv=>flag_changed ) )
             ENTITY materialdocument
             CREATE BY \_materialdocumentitem
             FROM VALUE #( ( %cid_ref = lv_item
                             %target  = VALUE #( FOR ls_531 IN gt_531 WHERE ( quantity > 0 )
                                                 ( %cid                         = ls_531-material && ls_531-quantity
                                                   plant                        = ls_531-plant
                                                   material                     = ls_531-material
                                                   goodsmovementtype            = '531'
                                                   storagelocation              = ls_531-storagelocation
                                                   quantityinentryunit          = ls_531-quantity
                                                   entryunit                    = ls_531-uom
                                                   manufacturingorder           = <fs_head>-productionorder
                                                   Reservation                 = ls_531-rsnum
                                                     ReservationItem                 = ls_531-rspos

                                                   %control-plant               = cl_abap_behv=>flag_changed
                                                   %control-material            = cl_abap_behv=>flag_changed
                                                   %control-goodsmovementtype   = cl_abap_behv=>flag_changed
                                                   %control-storagelocation     = cl_abap_behv=>flag_changed
                                                   %control-quantityinentryunit = cl_abap_behv=>flag_changed
                                                   %control-entryunit           = cl_abap_behv=>flag_changed
                                                   %control-manufacturingorder  = cl_abap_behv=>flag_changed
                                                     %control-Reservation                 = cl_abap_behv=>flag_changed
                                                       %control-ReservationItem           = cl_abap_behv=>flag_changed


                                                    ) ) ) )

             " TODO: variable is assigned but never used (ABAP cleaner)
             MAPPED FINAL(mapped_531)
             " TODO: variable is assigned but never used (ABAP cleaner)
             FAILED FINAL(failed_531)
             REPORTED FINAL(reported_531).
      IF reported_531-materialdocument IS NOT INITIAL.
        APPEND VALUE #( %tky             = <fs_head>-%tky
                        %state_area      = 'Validate_Head'
                        %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = 'Error in By-Product' )
                        %element-post261 = if_abap_behv=>mk-on )
               TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = <fs_head>-%tky )
               TO failed-zr_billet_hdr.

      ELSE.

        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
               ENTITY zr_billet_hdr
               UPDATE
               FIELDS ( post531 status progress )
               WITH VALUE #( ( %tky     = <fs_head>-%tky
                               status   = 'Completed'
                               progress = 100
                               post531  = 'X' ) ).

      ENDIF.
    ENDLOOP.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT FINAL(header_result).

    result = VALUE #( FOR ls_header_result IN header_result
                      ( %tky   = ls_header_result-%tky
                        %param = ls_header_result ) ).
  ENDMETHOD.


  METHOD postcheck.
    DATA lv_billet_quantity  TYPE zr_billet_hdr-billetquantity.
    DATA lv_heat_quantity    TYPE zr_billet_hdr-heatquantity.
    DATA lv_raw_quantity     TYPE zr_billet_hdr-heatquantity.
    DATA lv_byp_quantity     TYPE zr_billet_hdr-byproductquantity.
    DATA lv_balance_quantity TYPE zr_billet_hdr-balancequantity.
    DATA lv_yield            TYPE zr_billet_hdr-yieldpercentage.
    DATA lv_count            TYPE zde_no.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS  WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_header) " FAILED FINAL(ft_header).
            BY \_101
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_101)
         BY \_261
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_261)
           BY \_531
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_531)
          BY \_htb
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_htb).


*    READ ENTITY zr_billet_hdr
*         BY \_101
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_101) FAILED FINAL(ft_101).
*
*    READ ENTITY zr_billet_hdr
*         BY \_261
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_261) FAILED FINAL(ft_261).
*
*    READ ENTITY zr_billet_hdr
*         BY \_531
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_531) FAILED FINAL(ft_531).
*
*    READ ENTITY zr_billet_hdr
*         BY \_htb
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_htb) FAILED FINAL(ft_htb).



    LOOP AT gt_header ASSIGNING FIELD-SYMBOL(<fs_head>).
      IF <fs_head> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.
      DATA(ls_hdr) = <fs_head>.

      TRY.
          GET TIME STAMP FIELD FINAL(lv_utctimestamp).
          " TODO: variable is assigned but never used (ABAP cleaner)
          CONVERT TIME STAMP lv_utctimestamp TIME ZONE 'INDIA' INTO DATE FINAL(lv_date) TIME FINAL(lv_time).
        CATCH cx_abap_context_info_error.
          DATA(lv_er09) = 1.
      ENDTRY.

      " Header checks
      IF <fs_head>-postingdate > lv_date.
        APPEND VALUE #(
            %tky               = <fs_head>-%tky
            %state_area        = 'Validate_Header'
            %msg               = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                        text     = 'Posting Date greater than current Date' )
            %element-postcheck = if_abap_behv=>mk-on )
               TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = <fs_head>-%tky )
               TO failed-zr_billet_hdr.
      ENDIF.

      " 101 checks
      IF lines( gt_101 ) = 0.
        APPEND VALUE #( %tky             = <fs_head>-%tky
                        %state_area      = 'Validate_Header'
                        %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = 'No GR Angles Lines present' )
                        %element-post101 = if_abap_behv=>mk-on )
               TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = <fs_head>-%tky )
               TO failed-zr_billet_hdr.
      ELSE.

        LOOP AT gt_101 INTO FINAL(gs_101).
          IF gs_101-piece IS INITIAL AND gs_101-checkbox = abap_true.
            APPEND VALUE #( %tky             = <fs_head>-%tky
                            %state_area      = 'Validate_Header'
                            %msg             = new_message_with_text(
                                                   severity = if_abap_behv_message=>severity-error
                                                   text     = |No Piece provided in Line { sy-tabix }| )
                            %element-post101 = if_abap_behv=>mk-on )
                   TO reported-zr_billet_hdr.

            APPEND VALUE #( %tky = <fs_head>-%tky )
                   TO failed-zr_billet_hdr.
          ENDIF.

          IF gs_101-storagelocation IS INITIAL AND gs_101-checkbox = abap_true.

            APPEND VALUE #(
                %tky             = <fs_head>-%tky
                %state_area      = 'Validate_Header'
                %msg             = new_message_with_text(
                                       severity = if_abap_behv_message=>severity-error
                                       text     = |Provide a valid storage location in Angle Line { sy-tabix }| )
                %element-post101 = if_abap_behv=>mk-on )
                   TO reported-zr_billet_hdr.

            APPEND VALUE #( %tky = <fs_head>-%tky )
                   TO failed-zr_billet_hdr.
          ENDIF.

          IF gs_101-quantity IS INITIAL AND gs_101-checkbox = abap_true.

            APPEND VALUE #( %tky             = <fs_head>-%tky
                            %state_area      = 'Validate_Header'
                            %msg             = new_message_with_text(
                                                   severity = if_abap_behv_message=>severity-error
                                                   text     = |No Quantity details in Section(Angle) Line { sy-tabix }| )
                            %element-post101 = if_abap_behv=>mk-on )
                   TO reported-zr_billet_hdr.

            APPEND VALUE #( %tky = <fs_head>-%tky )
                   TO failed-zr_billet_hdr.
          ENDIF.

        ENDLOOP.
      ENDIF.

      " 261 checks
      IF lines( gt_261 ) = 0.
        APPEND VALUE #( %tky             = <fs_head>-%tky
                        %state_area      = 'Validate_Header'
                        %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = 'No Consumption Lines present, check BOM' )
                        %element-post261 = if_abap_behv=>mk-on )
               TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = <fs_head>-%tky )
               TO failed-zr_billet_hdr.
      ELSE.

        LOOP AT gt_261 INTO DATA(gs_261).
          IF gs_261-storagelocation IS INITIAL.

            APPEND VALUE #(
                %tky             = <fs_head>-%tky
                %state_area      = 'Validate_Header'
                %msg             = new_message_with_text(
                                       severity = if_abap_behv_message=>severity-error
                                       text     = |Provide a valid storage location in Cons. Line { sy-tabix }| )
                %element-post101 = if_abap_behv=>mk-on )
                   TO reported-zr_billet_hdr.

            APPEND VALUE #( %tky = <fs_head>-%tky )
                   TO failed-zr_billet_hdr.
          ENDIF.

          IF gs_261-quantity IS INITIAL.
            APPEND VALUE #( %tky             = <fs_head>-%tky
                            %state_area      = 'Validate_Header'
                            %msg             = new_message_with_text(
                                                   severity = if_abap_behv_message=>severity-error
                                                   text     = |Provide a quantity in Cons. Line { sy-tabix }| )
                            %element-post101 = if_abap_behv=>mk-on )
                   TO reported-zr_billet_hdr.

            APPEND VALUE #( %tky = <fs_head>-%tky )
                   TO failed-zr_billet_hdr.
          ENDIF.
        ENDLOOP.
      ENDIF.

      " 531 checks
      DATA(lt_531) = gt_531.
      DELETE lt_531 WHERE quantity = 0.

      IF lines( lt_531 ) = 0.
        " do nothing
      ELSE.

        LOOP AT gt_531 INTO FINAL(gs_531).
          IF gs_531-storagelocation IS NOT INITIAL.
            CONTINUE.
          ENDIF.

          APPEND VALUE #(
              %tky             = <fs_head>-%tky
              %state_area      = 'Validate_Header'
              %msg             = new_message_with_text(
                                     severity = if_abap_behv_message=>severity-error
                                     text     = |Provide a valid storage location in By-Product Line { sy-tabix }| )
              %element-post531 = if_abap_behv=>mk-on )
                 TO reported-zr_billet_hdr.

          APPEND VALUE #( %tky = <fs_head>-%tky )
                 TO failed-zr_billet_hdr.
        ENDLOOP.
      ENDIF.

      DATA(lt_101_heat) = gt_101.
      SORT lt_101_heat BY heatnumber.
      DELETE ADJACENT DUPLICATES FROM lt_101_heat COMPARING heatnumber.
      FINAL(lv_heat101) = lines( lt_101_heat ).

      DATA(lt_261_heat) = gt_261.
      SORT lt_261_heat BY heatnumber.
      DELETE ADJACENT DUPLICATES FROM lt_261_heat COMPARING heatnumber.
      FINAL(lv_heat261) = lines( lt_261_heat ).

      DATA(lt_531_heat) = gt_531.
      DELETE lt_531_heat WHERE quantity = 0.
      SORT lt_531_heat BY heatnumber.
      DELETE ADJACENT DUPLICATES FROM lt_531_heat COMPARING heatnumber.
      FINAL(lv_heat531) = lines( lt_531_heat ).

      " Heat Balancing
      lv_billet_quantity = REDUCE menge_d( INIT lv_quantity TYPE menge_d
                                                    FOR gs_101_t IN gt_101
                                                    NEXT lv_quantity = lv_quantity + gs_101_t-quantity ).

      lv_heat_quantity = REDUCE menge_d( INIT lv_quantity TYPE menge_d
                                                    FOR gs_261_t IN gt_261
                                                    NEXT lv_quantity = lv_quantity + gs_261_t-Qtybur ).
      lv_raw_quantity = REDUCE menge_d( INIT lv_quantity TYPE menge_d
                                                    FOR gs_261_t IN gt_261
                                                    NEXT lv_quantity = lv_quantity + gs_261_t-quantitys ).

      lv_byp_quantity = REDUCE menge_d( INIT lv_quantity TYPE menge_d
                                                    FOR gs_531_t IN gt_531
                                                    NEXT lv_quantity = lv_quantity + gs_531_t-quantity ).

      lv_heat_quantity = lv_heat_quantity * 1000.

      lv_balance_quantity = lv_heat_quantity - ( lv_billet_quantity + lv_byp_quantity ).

      lv_yield = ( lv_billet_quantity * 100 ) / lv_heat_quantity.


      IF lv_balance_quantity <> 0.
        APPEND VALUE #(
            %tky             = <fs_head>-%tky
            %state_area      = 'Validate_Header'
            %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text     = |Balance Quantity { lv_balance_quantity } must be 0| )
            %element-post531 = if_abap_behv=>mk-on )
               TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = <fs_head>-%tky )
               TO failed-zr_billet_hdr.
      ENDIF.

      IF lv_raw_quantity > lv_billet_quantity   .
        APPEND VALUE #(
            %tky             = <fs_head>-%tky
            %state_area      = 'Validate_Header'
            %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text     = |Section Quantity more than Raw Material Quanity| ) "Billet Quantity more than Open Order Quantity
            %element-post531 = if_abap_behv=>mk-on )
               TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = <fs_head>-%tky )
               TO failed-zr_billet_hdr.
      ENDIF.

      LOOP AT gt_261 INTO gs_261.

        lv_count += 1.
        FINAL(lv_gr_quantity) = REDUCE menge_d( INIT lv_quantity TYPE menge_d
                                                      FOR gs_101_t IN gt_101
                                                      WHERE ( heatnumber = gs_261-heatnumber )
                                                      NEXT lv_quantity = lv_quantity + gs_101_t-quantity ).

        FINAL(ls_htb) = VALUE #( gt_htb[ lv_count ] OPTIONAL ).

        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
               ENTITY zr_billet_htb
               UPDATE
               FIELDS ( heatnumber heatquantity billetquantity uom )
               WITH VALUE #( FOR key IN keys
                             ( %tky                    = ls_htb-%tky
                               heatnumber              = gs_261-heatnumber
                               heatquantity            = gs_261-quantitys
                               billetquantity          = lv_gr_quantity
                               uom                     = gs_261-uom

                               %control-heatnumber     = if_abap_behv=>mk-on
                               %control-heatquantity   = if_abap_behv=>mk-on
                               %control-billetquantity = if_abap_behv=>mk-on
                               %control-uom            = if_abap_behv=>mk-on ) ).

      ENDLOOP.

      IF failed-zr_billet_hdr IS INITIAL.

        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
               ENTITY zr_billet_hdr
               UPDATE
               FIELDS ( status postcheck progress totalpostquantity heatquantity billetquantity balancequantity byproductquantity  shortqty yieldpercentage )
               WITH VALUE #( FOR key IN keys
                             ( %tky                       = <fs_head>-%tky
                               status                     = 'Checked'
                               progress                   = 40
                               postcheck                  = 'X'
                               totalpostquantity          = lv_billet_quantity
                               heatquantity               = lv_heat_quantity
                               billetquantity             = lv_billet_quantity
                               balancequantity            = lv_balance_quantity
                               byproductquantity          = lv_byp_quantity
                               shortqty                   =  lv_billet_quantity - <fs_head>-orderquantity
                               yieldpercentage            = lv_yield

                               %control-status            = if_abap_behv=>mk-on
                               %control-postcheck         = if_abap_behv=>mk-on
                               %control-totalpostquantity = if_abap_behv=>mk-on
                               %control-progress          = if_abap_behv=>mk-on
                               %control-heatquantity      = if_abap_behv=>mk-on
                               %control-billetquantity    = if_abap_behv=>mk-on
                               %control-balancequantity   = if_abap_behv=>mk-on
                               %control-byproductquantity = if_abap_behv=>mk-on
                                  %control-shortqty       = if_abap_behv=>mk-on
                               %control-yieldpercentage   = if_abap_behv=>mk-on ) ).

      ELSE.
        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
               ENTITY zr_billet_hdr
               UPDATE
               FIELDS ( totalpostquantity heatquantity billetquantity balancequantity byproductquantity yieldpercentage )
               WITH VALUE #( FOR key IN keys
                             ( %tky                       = <fs_head>-%tky
                               totalpostquantity          = lv_billet_quantity
                               heatquantity               = lv_heat_quantity
                               billetquantity             = lv_billet_quantity
                               balancequantity            = lv_balance_quantity
                               byproductquantity          = lv_byp_quantity
                               yieldpercentage            = lv_yield

                               %control-totalpostquantity = if_abap_behv=>mk-on
                               %control-heatquantity      = if_abap_behv=>mk-on
                               %control-billetquantity    = if_abap_behv=>mk-on
                               %control-balancequantity   = if_abap_behv=>mk-on
                               %control-byproductquantity = if_abap_behv=>mk-on
                               %control-yieldpercentage   = if_abap_behv=>mk-on ) ).
      ENDIF.

    ENDLOOP.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT FINAL(header_result).

    result = VALUE #( FOR ls_header_result IN header_result
                      ( %tky   = ls_header_result-%tky
                        %param = ls_header_result ) ).
  ENDMETHOD.

  METHOD postcnf.
    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_header) " FAILED FINAL(ft_header).
              BY \_101
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_101).

*    READ ENTITY zr_billet_hdr
*         BY \_101
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT FINAL(gt_101) FAILED FINAL(ft_101).

    LOOP AT gt_header ASSIGNING FIELD-SYMBOL(<fs_head>).
      IF <fs_head> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.

      TRY.
          GET TIME STAMP FIELD FINAL(lv_utctimestamp).
          " TODO: variable is assigned but never used (ABAP cleaner)
          CONVERT TIME STAMP lv_utctimestamp TIME ZONE 'INDIA' INTO DATE FINAL(lv_date) TIME FINAL(lv_time).
        CATCH cx_abap_context_info_error.
          DATA(lv_er10) = 1.
      ENDTRY.

      SELECT SINGLE manufacturingorder,
                    manufacturingorderoperation_2
        FROM i_manufacturingorderoperation WITH PRIVILEGED ACCESS
        WHERE manufacturingorder = @<fs_head>-productionorder
        INTO @FINAL(ls_i_manufacturingorderop).

      FINAL(lv_gr_quantity) = REDUCE menge_d( INIT lv_quantity TYPE menge_d
                                                          FOR gs_101 IN gt_101
                                                          NEXT lv_quantity = lv_quantity + gs_101-quantity ).

      FINAL(lv_unit) = VALUE #( gt_101[ 1 ]-uom OPTIONAL ).

      SELECT a~manufacturingorder,
             b~workcenterstandardworkqty1,
             b~workcenterstandardworkqty2,
             b~workcenterstandardworkqty3,
             b~workcenterstandardworkqty4,
             b~workcenterstandardworkqty5,
             b~operationreferencequantity
        FROM i_manufacturingorder WITH PRIVILEGED ACCESS AS a
        INNER JOIN i_manufacturingorderoperation WITH PRIVILEGED ACCESS AS b ON b~billofoperationsgroup = a~billofoperationsgroup
                                 AND b~billofoperationsvariant = a~billofoperationsvariant
                                 AND b~manufacturingorder = a~manufacturingorder
        WHERE a~manufacturingorder = @<fs_head>-productionorder
        INTO TABLE @DATA(lt_routing).
      IF sy-subrc = 0.
        SORT lt_routing BY manufacturingorder.
      ENDIF.

      MODIFY ENTITIES OF i_productionordconfirmationtp
             ENTITY productionorderconfirmation
             CREATE FROM VALUE #( ( %cid                        = <fs_head>-productionorder
                                    orderid                     = <fs_head>-productionorder
                                    orderoperation              = ls_i_manufacturingorderop-manufacturingorderoperation_2
                                    sequence                    = '000000'
                                    confirmationyieldquantity   = lv_gr_quantity
                                    confirmationunitsapcode     = lv_unit
                                    confirmationtext            = <fs_head>-referenceid
                                    postingdate                 = <fs_head>-postingdate
                                    confirmedexecutionstartdate = <fs_head>-postingdate
                                    confirmedsetupenddate       = <fs_head>-postingdate

                                    opconfirmedworkquantity1    = ( <fs_head>-totalpostquantity *
                                    lt_routing[ manufacturingorder = <fs_head>-productionorder ]-workcenterstandardworkqty1 /
                                    lt_routing[ manufacturingorder = <fs_head>-productionorder ]-operationreferencequantity )

                                    opconfirmedworkquantity2    = <fs_head>-activity

                                    opconfirmedworkquantity3    = ( <fs_head>-totalpostquantity *
                                    lt_routing[ manufacturingorder = <fs_head>-productionorder ]-workcenterstandardworkqty3 /
                                    lt_routing[ manufacturingorder = <fs_head>-productionorder ]-operationreferencequantity )

                                    opconfirmedworkquantity4    = ( <fs_head>-totalpostquantity *
                                    lt_routing[ manufacturingorder = <fs_head>-productionorder ]-workcenterstandardworkqty4 /
                                    lt_routing[ manufacturingorder = <fs_head>-productionorder ]-operationreferencequantity )

                                    opconfirmedworkquantity5    = ( <fs_head>-totalpostquantity *
                                    lt_routing[ manufacturingorder = <fs_head>-productionorder ]-workcenterstandardworkqty5 /
                                    lt_routing[ manufacturingorder = <fs_head>-productionorder ]-operationreferencequantity )
                                    ) )
             " TODO: variable is assigned but never used (ABAP cleaner)
             MAPPED FINAL(mapped_conf)
             " TODO: variable is assigned but never used (ABAP cleaner)
             FAILED FINAL(failed_conf)
             REPORTED FINAL(reported_conf).
      IF reported_conf-productionorderconfirmation IS NOT INITIAL.
        APPEND VALUE #( %tky             = <fs_head>-%tky
                        %state_area      = 'Validate_Head'
                        %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = 'Error in Billet Confirmation' )
                        %element-post101 = if_abap_behv=>mk-on )
               TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = <fs_head>-%tky )
               TO failed-zr_billet_hdr.
      ELSE.

        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
               ENTITY zr_billet_hdr
               UPDATE
               FIELDS ( status postcnf progress )
               WITH VALUE #( FOR key IN keys
                             ( %tky               = <fs_head>-%tky
                               status             = 'Confirmed'
                               progress           = 50
                               postcnf            = 'X'
                               %control-status    = if_abap_behv=>mk-on
                               %control-postcheck = if_abap_behv=>mk-on
                               %control-progress  = if_abap_behv=>mk-on ) ).
      ENDIF.
    ENDLOOP.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT FINAL(header_result).

    result = VALUE #( FOR ls_header_result IN header_result
                      ( %tky   = ls_header_result-%tky
                        %param = ls_header_result ) ).
  ENDMETHOD.

  METHOD getcons.

    DATA lv_referencelike TYPE zr_billet_hdr-referenceid.
    DATA lv_no            TYPE zde_no                    VALUE 1.
    DATA lv_reference     TYPE zr_billet_hdr-referenceid.
    DATA lv_item          TYPE zr_billet_531-item.
    DATA lv_count         TYPE zde_no                    VALUE 1.
    DATA lv_remaining  TYPE menge_d.
    DATA qtybur TYPE menge_d.
    TYPES: BEGIN OF ty_gtdata,
             heatno TYPE charg_d,
             qty    TYPE menge_d,
             qtybur TYPE menge_d,
           END OF ty_gtdata.
    DATA: gt_allocation TYPE STANDARD TABLE OF ty_gtdata.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS  WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT DATA(gt_header)
         "FAILED FINAL(ls_failed).
          BY \_101
         ALL FIELDS WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT DATA(gt_101).

*    READ ENTITY zr_billet_hdr
*         BY \_101
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         " TODO: variable is assigned but never used (ABAP cleaner)
*         RESULT DATA(gt_101) FAILED FINAL(ft_101).

    TRY.
        GET TIME STAMP FIELD FINAL(lv_utctimestamp).
        " TODO: variable is assigned but never used (ABAP cleaner)
        CONVERT TIME STAMP lv_utctimestamp TIME ZONE 'INDIA' INTO DATE FINAL(lv_date) TIME FINAL(lv_time).
      CATCH cx_abap_context_info_error.
        DATA(lv_er11) = 1.
    ENDTRY.

    LOOP AT gt_header ASSIGNING FIELD-SYMBOL(<fs_head01>).
      IF <fs_head01> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.

      IF <fs_head01>-%is_draft = 01.
        APPEND VALUE #( %tky             = <fs_head01>-%tky
                  %state_area      = 'Validate_Head'
                  %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                            text     = 'Disable the Draft Mode' )
                  %element-post101 = if_abap_behv=>mk-on )
         TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = <fs_head01>-%tky )
               TO failed-zr_billet_hdr.

      ELSE.
        SELECT SINGLE  FROM i_manufacturingorder WITH PRIVILEGED ACCESS FIELDS
        BillOfMaterialInternalID,StorageLocation
          WHERE manufacturingorder = @<fs_head01>-productionorder
          INTO @FINAL(ls_mnford).
************************insted of this code im using different way**********************************************
*        SELECT * FROM i_billofmaterialitemtp_3
*          WHERE billofmaterial = @ls_mnford-billofmaterial
*            AND billofmaterialvariant = '01'
*          INTO TABLE @FINAL(lt_bom).
**********************************************************************
        SELECT  FROM zpp_appsr_prodcom
        FIELDS
        ProductionOrder,
        billofmaterialvariant,
        GoodsMovementType,
        RequiredQuantity,
        Bourningloss,
        Reservation,
        ReservationItem,
        Material

*         left join zpp_mat_tb as mt on mt~matnr = mt~matnr
        WHERE ProductionOrder = @<fs_head01>-productionorder
        INTO TABLE @FINAL(lt_bom).
**********************************************************************

        DATA(lt_531) = lt_bom.
        DATA(lt_261) = lt_bom.
*        DELETE lt_261 WHERE billofmaterialvariant <> '01'.
        DELETE lt_531 WHERE GoodsMovementType = '261'.
        DELETE lt_261 WHERE GoodsMovementType = '531'.

        " Consumption
        TRY.
            lv_item = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
          CATCH cx_uuid_error.
            DATA(lv_er2) = 1.
        ENDTRY.

        DATA(gt_101_t) = gt_101.
        SORT gt_101_t BY heatnumber.
        DELETE ADJACENT DUPLICATES FROM gt_101_t COMPARING heatnumber.
        IF gt_101_t IS NOT INITIAL.
          SELECT *
          FROM zvbilletheatf4_1
          FOR ALL ENTRIES IN @gt_101_t
          WHERE heatnumber = @gt_101_t-heatnumber
          AND ProductionOrder = @<fs_head01>-productionorder
          INTO TABLE @DATA(lt_zvbilletheatf4_1).

        ENDIF.
        FINAL(ls_261) = VALUE #( lt_261[ 1 ] OPTIONAL ).
        lv_remaining = ls_261-RequiredQuantity.
        DATA: qty TYPE menge_d.




        DATA(lv_line) = lines( lt_zvbilletheatf4_1 ).
        DATA : lv_mark TYPE c LENGTH 1.

        IF gt_101 IS NOT INITIAL. " Extra Validation 5.6.2026

          LOOP AT gt_101 INTO DATA(lvsde).

            IF lvsde-heatnumber IS NOT INITIAL AND lvsde-checkbox = abap_false.

              APPEND VALUE #( %tky             = <fs_head01>-%tky
                                      %state_area      = 'Validate_Head'
                                      %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                                text     = 'Please Click On Check Box ' )
                                      %element-post101 = if_abap_behv=>mk-on )
                             TO reported-zr_billet_hdr.

              APPEND VALUE #( %tky = <fs_head01>-%tky )
                     TO failed-zr_billet_hdr.

            ENDIF.

          ENDLOOP.


        ENDIF.


        DATA(ls_101) = VALUE #( gt_101[ heatnumber = '' checkbox = abap_true  ] OPTIONAL ). "New Added 5.6.2026
*       data(ls_101) = VALUE #(FOR ls2 in gt_101(  ) ).


        IF ls_101 IS INITIAL .
**********************************************************************
          DATA(lv_total_stock) =
    REDUCE menge_d( INIT x = 0
              FOR ls IN lt_zvbilletheatf4_1
              NEXT x = x + ls-stock ).
**********************************************************************
          IF lv_total_stock < ls_261-RequiredQuantity.
            APPEND VALUE #( %tky             = <fs_head01>-%tky
                                 %state_area      = 'Validate_Head'
                                 %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                           text     = 'Stock Quantity < Consumend Quantity ' )
                                 %element-post101 = if_abap_behv=>mk-on )
                        TO reported-zr_billet_hdr.

            APPEND VALUE #( %tky = <fs_head01>-%tky )
                   TO failed-zr_billet_hdr.
          ENDIF.


          LOOP AT lt_zvbilletheatf4_1 INTO DATA(ls_data).

            DATA(lv_alloc) = COND #(
                                  WHEN ls_data-stock >= lv_remaining
                                  THEN lv_remaining
                                  ELSE ls_data-stock ).

            lv_remaining -= lv_alloc.

            qty = lv_alloc * ( ls_261-Bourningloss / 100 ).

            APPEND VALUE ty_gtdata(
                     heatno      = ls_data-heatnumber
                     qty       = lv_alloc
                     qtybur    = lv_alloc - qty

                     )
                   TO gt_allocation.
            CLEAR qty.



          ENDLOOP.


**********************************************************************

          LOOP AT gt_101_t INTO DATA(gs_101) WHERE checkbox = abap_true .
            lv_count += 1.

**********************************************************************
            ""New Logic added by SAR Tech Team 28-01-2026
            SELECT SINGLE * FROM zvbilletheatf4_1 WITH PRIVILEGED ACCESS
            WHERE HeatNumber = @gs_101-heatnumber
            AND Material = @ls_261-Material
            INTO @DATA(wa_261).

            SELECT SINGLE * FROM @gt_allocation AS _hdr
            WHERE heatno = @gs_101-heatnumber
*            and ProductionOrder = @ls_261-productionorder
            INTO @DATA(ls_qty).





            FINAL(ls_zvbilletheatf4_1) = VALUE #( lt_zvbilletheatf4_1[ heatnumber = gs_101-heatnumber ] OPTIONAL ).
*            SELECT SINGLE * FROM i_product WHERE product = @ls_261-Material INTO @FINAL(ls_prod_261).
            MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
                   ENTITY zr_billet_hdr
                   CREATE BY \_261
                   FROM VALUE #( ( id      = <fs_head01>-id
                                   %target = VALUE #( ( %cid                         = <fs_head01>-referenceid && lv_count
                                                        item                         = <fs_head01>-referenceid && lv_count
                                                        referenceid                  = <fs_head01>-referenceid
                                                        heatnumber                   = gs_101-heatnumber
                "Old Logic 28.01-2026
*                                                        material                     = ls_261-billofmaterialcomponent
*                                                        materialdescription          = ls_261-componentdescription
*                                                        uom                          = ls_prod_261-baseunit
                "New logic added by SAR Tech Team 28.01.2026
                                                        material                     = wa_261-Material
                                                        materialdescription          = wa_261-ProductName
                                                        uom                          = wa_261-MaterialBaseUnit
                                                        plant                        = <fs_head01>-plant
                                                        quantity                     = ls_zvbilletheatf4_1-stock
                                                        quantitys                    = ls_qty-qty
                                                        Qtybur                       = ls_qty-qtybur
                                                        storagelocation              = ls_zvbilletheatf4_1-StorageLocation
                                                        rsnum                        = ls_261-Reservation
                                                        rspos                        = ls_261-ReservationItem

                                                        %control-item                = if_abap_behv=>mk-on
                                                        %control-referenceid         = if_abap_behv=>mk-on
                                                        %control-material            = if_abap_behv=>mk-on
                                                        %control-plant               = if_abap_behv=>mk-on
                                                        %control-heatnumber          = if_abap_behv=>mk-on
                                                        %control-materialdescription = if_abap_behv=>mk-on
                                                        %control-uom                 = if_abap_behv=>mk-on
                                                        %control-quantity            = if_abap_behv=>mk-on
                                                        %control-quantitys           = if_abap_behv=>mk-on
                                                        %control-Qtybur              = if_abap_behv=>mk-on
                                                        %control-storagelocation     = if_abap_behv=>mk-on
                                                         %control-rsnum                        = if_abap_behv=>mk-on
                                                         %control-rspos                        = if_abap_behv=>mk-on

                                                        ) ) ) )
                   " TODO: variable is assigned but never used (ABAP cleaner)
                   MAPPED FINAL(ls_mapped_261)
                   " TODO: variable is assigned but never used (ABAP cleaner)
                   FAILED FINAL(ls_failed_261)
                   " TODO: variable is assigned but never used (ABAP cleaner)
                   REPORTED FINAL(ls_reported_261).
          ENDLOOP.

          " By-Product
          TRY.
              lv_item = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
            CATCH cx_uuid_error.
              DATA(lv_er12) = 1.
          ENDTRY.

          DO lv_line TIMES.
            lv_count += 1.
            MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
                   ENTITY zr_billet_hdr
                   CREATE BY \_htb
                   FROM VALUE #( ( id      = <fs_head01>-id
                                   %target = VALUE #( ( %cid                 = <fs_head01>-referenceid && lv_count
                                                        item                 = <fs_head01>-referenceid && lv_count
                                                        referenceid          = <fs_head01>-referenceid

                                                        %control-item        = if_abap_behv=>mk-on
                                                        %control-referenceid = if_abap_behv=>mk-on ) ) ) )
                   " TODO: variable is assigned but never used (ABAP cleaner)
                   MAPPED FINAL(ls_mapped_htb)
                   " TODO: variable is assigned but never used (ABAP cleaner)
                   FAILED FINAL(ls_failed_htb)
                   " TODO: variable is assigned but never used (ABAP cleaner)
                   REPORTED FINAL(ls_reported_htb).
          ENDDO.
          lv_count = lines( gt_101 ).

          MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
           ENTITY zr_billet_hdr
           UPDATE
           FIELDS ( getcons status progress noofheats noofbatches )
           WITH VALUE #( ( %tky     = <fs_head01>-%tky
                           status   = 'Cons. Fetched'
                           progress = 45
                           noofheats = lv_line
                           noofbatches = lv_count
                           getcons  = 'X' ) ).
        ELSE.

          APPEND VALUE #( %tky             = <fs_head01>-%tky
                          %state_area      = 'Validate_Head'
                          %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                    text     = 'Consumed Batched cannot be determined' )
                          %element-post101 = if_abap_behv=>mk-on )
                 TO reported-zr_billet_hdr.

          APPEND VALUE #( %tky = <fs_head01>-%tky )
                 TO failed-zr_billet_hdr.

        ENDIF.
      ENDIF.
    ENDLOOP.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT FINAL(header_result).

    result = VALUE #( FOR ls_header_result IN header_result
                      ( %tky   = ls_header_result-%tky
                        %param = ls_header_result ) ).

  ENDMETHOD.

  METHOD dummyupdate.

*    DATA : lv_item TYPE zr_billetre_hdr-id.
*    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
*       ENTITY zr_billet_hdr
*       ALL FIELDS
*       WITH CORRESPONDING #( keys )
*       RESULT FINAL(header_result).
*
*    LOOP AT header_result ASSIGNING FIELD-SYMBOL(<fs_head>).
*      IF <fs_head> IS NOT ASSIGNED.
*        CONTINUE.
*      ENDIF.
*      TRY.
*          lv_item = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
*        CATCH cx_uuid_error.
*      ENDTRY.
*
*      MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
*          ENTITY zr_billet_hdr
*          UPDATE
*          FIELDS ( dummy  )
*          WITH VALUE #( FOR key IN keys
*                        ( %tky                 = <fs_head>-%tky
*                          dummy               = lv_item
*                          %control-dummy = if_abap_behv=>mk-on ) ).
*    ENDLOOP.

  ENDMETHOD.

  METHOD extend.
**********************************************************************
    DATA : lv_count TYPE n LENGTH 6.
    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
    ENTITY zr_billet_hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
     BY \_101
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).


**********************************************************************
    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
    ENTITY zr_billet_101
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
**********************************************************************
*    READ ENTITY zr_billet_hdr
*    BY \_101
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_result).
**********************************************************************
    lv_count = lines( lt_result ).
    lv_count = lv_count + 1.
**********************************************************************
    IF lt_hdr IS NOT INITIAL.
      DATA(ls_hdr)  =  lt_hdr[ 1 ].
      IF ls_hdr-%is_draft = 01.
        APPEND VALUE #( %tky             = ls_hdr-%tky
                      %state_area      = 'Validate_Head'
                      %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                text     = 'Disable the Draft Mode' )
                       )
             TO reported-zr_billet_hdr.

        APPEND VALUE #( %tky = ls_hdr-%tky )
               TO failed-zr_billet_hdr.

      ELSE.
        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
                  ENTITY zr_billet_hdr
                  CREATE BY \_101
                  FROM VALUE #( ( id      = ls_hdr-id
                                  %target = VALUE #( ( %cid                 = ls_hdr-referenceid && lv_count
                                                       item                 = ls_hdr-referenceid && lv_count
                                                       referenceid          = ls_hdr-referenceid
                                                       checkbox             = abap_true   "New Added 5.6.2026
                                                       material             = ls_hdr-material
                                                       uom                  = ls_hdr-uom
                                                       plant                = ls_hdr-plant
*                                                    batch                = 'BILLET'
                                                       %control-item        = if_abap_behv=>mk-on
                                                       %control-referenceid = if_abap_behv=>mk-on
                                                       %control-material    = if_abap_behv=>mk-on
                                                       %control-plant       = if_abap_behv=>mk-on
*                                                    %control-batch       = if_abap_behv=>mk-on
                                                       %control-uom         = if_abap_behv=>mk-on
                                                        %control-checkbox        = if_abap_behv=>mk-on


                                                       ) ) ) )
                  " TODO: variable is assigned but never used (ABAP cleaner)
                  MAPPED FINAL(ls_mapped_101)
                  " TODO: variable is assigned but never used (ABAP cleaner)
                  FAILED FINAL(ls_failed_101)
                  " TODO: variable is assigned but never used (ABAP cleaner)
                  REPORTED FINAL(ls_reported_101).


      ENDIF.




    ENDIF.
**********************************************************************
    result = VALUE #( FOR ls_header_result IN lt_hdr
                         ( %tky   = ls_header_result-%tky
                           %param = ls_header_result ) ).



  ENDMETHOD.

ENDCLASS.


CLASS lhc_zr_billet_101 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_billet_101 RESULT result.

    METHODS billetdetails FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zr_billet_101~billetdetails.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_billet_101 RESULT result.

    METHODS btchsplt FOR MODIFY
      IMPORTING keys FOR ACTION zr_billet_101~btchsplt RESULT result.
*    METHODS stock FOR DETERMINE ON SAVE
*      IMPORTING keys FOR zr_billet_101~stock.

ENDCLASS.


CLASS lhc_zr_billet_101 IMPLEMENTATION.
  METHOD get_instance_features.
    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT FINAL(gt_header)
         " TODO: variable is assigned but never used (ABAP cleaner)
         FAILED FINAL(gt_failed).

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_101
         ALL FIELDS  WITH CORRESPONDING #( keys )
         RESULT FINAL(gt_101)
         " TODO: variable is assigned but never used (ABAP cleaner)
         FAILED FINAL(gt_101failed).

    FINAL(gs_header) = VALUE #( gt_header[ 1 ] OPTIONAL ).

    result = VALUE #( FOR gs_101 IN gt_101
                      ( %tky    = gs_101-%tky

                        %update = COND #( WHEN gs_header-postcheck = ''
                                          THEN if_abap_behv=>fc-o-enabled
                                          ELSE if_abap_behv=>fc-o-disabled )
                        %action-btchsplt =  COND #( WHEN gs_header-getcons = ''
                                          THEN if_abap_behv=>fc-o-enabled
                                          ELSE if_abap_behv=>fc-o-disabled )
                        %features-%field-checkbox =  COND #( WHEN gs_101-balance1 <= 0 OR gs_header-getcons <> ''
                                          THEN if_abap_behv=>fc-f-read_only
                                          ELSE if_abap_behv=>fc-f-unrestricted )
                        %features-%field-lengthmtr =  COND #( WHEN gs_101-balance1 <= 0 OR gs_101-checkbox = abap_true
                                          THEN if_abap_behv=>fc-f-unrestricted
                                          ELSE if_abap_behv=>fc-f-read_only )
                          %features-%field-piece =  COND #( WHEN gs_101-balance1 <= 0 OR gs_101-checkbox = abap_true
                                          THEN if_abap_behv=>fc-f-unrestricted
                                          ELSE if_abap_behv=>fc-f-read_only )
                         %features-%field-heatnumber =  COND #( WHEN gs_101-balance1 <= 0 OR gs_101-checkbox = abap_true
                                          THEN if_abap_behv=>fc-f-unrestricted
                                          ELSE if_abap_behv=>fc-f-read_only )


                                           ) ).

  ENDMETHOD.

  METHOD billetdetails.
    DATA lv_string          TYPE string.
    DATA lv_string1         TYPE string.
    DATA lv_string2         TYPE string.
    DATA lv_last_two_digits TYPE string.
    DATA lv_batch           TYPE c LENGTH 10.
    DATA lv_qty             TYPE menge_d.

    " Find the position of the decimal point
    DATA(lv_dot_position) = sy-fdpos.

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS  WITH CORRESPONDING #( keys )
         " TODO: variable is assigned but never used (ABAP cleaner)
         RESULT FINAL(gt_header) FAILED FINAL(failed).

    FINAL(ls_hdr) = VALUE #( gt_header[ 1 ] OPTIONAL ).

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_101
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT FINAL(lt_101)
         " TODO: variable is assigned but never used (ABAP cleaner)
         FAILED FINAL(revfailed).

    LOOP AT lt_101 ASSIGNING FIELD-SYMBOL(<lfs_101>).

      lv_string = <lfs_101>-lengthmtr.
*      FIND '.' IN lv_string MATCH OFFSET lv_dot_position.
*      lv_dot_position -= 1.
*      SPLIT lv_string AT '.' INTO lv_string1 lv_string2.
*      CLEAR lv_string.
*      lv_string = lv_string1 && lv_string2.
*      lv_last_two_digits = lv_string+lv_dot_position(2).
*      lv_batch = <lfs_101>-heatnumber && lv_last_two_digits.

      IF <lfs_101>-lengthmtr IS NOT INITIAL.
        lv_qty = <lfs_101>-lengthmtr * ls_hdr-density  * <lfs_101>-piece   .
        lv_qty = lv_qty / 1000.
      ENDIF.

      SELECT SINGLE FROM i_product WITH PRIVILEGED ACCESS
      FIELDS
      Product,
      BaseUnit
        WHERE product = @ls_hdr-material
        INTO @FINAL(ls_prod).

      SELECT SINGLE  FROM i_productstoragelocationbasic WITH PRIVILEGED ACCESS
      FIELDS
      Product,
      StorageLocation
        WHERE product = @ls_hdr-material
          AND plant   = @ls_hdr-plant
        INTO @FINAL(ls_prodsl).

      MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
             ENTITY zr_billet_101
             UPDATE
             FIELDS ( batch quantity uom storagelocation material plant remark )
             WITH VALUE #( FOR key IN keys
                           ( %tky                     = <lfs_101>-%tky
                             batch                    =  <lfs_101>-batch    "'BILLET' "lv_batch
                             quantity                 = lv_qty
                             uom                      = ls_prod-baseunit
                             storagelocation          = <lfs_101>-storagelocation
                             material                 = ls_hdr-material
                             plant                    = ls_hdr-plant
                             remark                   = <lfs_101>-remark
                             %control-batch           = if_abap_behv=>mk-on
                             %control-quantity        = if_abap_behv=>mk-on
                             %control-uom             = if_abap_behv=>mk-on
                             %control-material        = if_abap_behv=>mk-on
                             %control-plant           = if_abap_behv=>mk-on
                             %control-storagelocation = if_abap_behv=>mk-on
                              %control-remark         = if_abap_behv=>mk-on
                              ) ).

    ENDLOOP.
  ENDMETHOD.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD btchsplt.
**********************************************************************
    DATA : lv_count TYPE n LENGTH 6.
    READ ENTITY IN LOCAL MODE zr_billet_hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

**********************************************************************
    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
    ENTITY zr_billet_101
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
**********************************************************************
    READ ENTITY IN LOCAL MODE zr_billet_hdr
    BY \_101
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).
**********************************************************************
    lv_count = lines( lt_result ).
    lv_count = lv_count + 1.
**********************************************************************
    IF lt_item IS NOT INITIAL.

      DATA(ls_item) = lt_item[ 1 ].
      DATA(ls_hdr)  =  lt_hdr[ 1 ].
*  if ls_item-%is_draft is not inITIAL.

      IF ls_item-%is_draft = 01.
        APPEND VALUE #( %tky             = ls_item-%tky
                  %state_area      = 'Validate_Head'
                  %msg             = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                            text     = 'Disable the Draft Mode' )
                   )
         TO reported-zr_billet_101.

        APPEND VALUE #( %tky = ls_item-%tky )
               TO failed-zr_billet_101.

      ELSE.
**********************************************************************
        MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
                    ENTITY zr_billet_hdr
                    CREATE BY \_101
                    FROM VALUE #( ( id      = ls_hdr-id
                                    %target = VALUE #( ( %cid                 = ls_hdr-referenceid && lv_count
                                                         item                 = ls_hdr-referenceid && lv_count
                                                         referenceid          = ls_hdr-referenceid
                                                         material             = ls_hdr-material
                                                         uom                  = ls_hdr-uom
                                                         plant                = ls_hdr-plant
                                                         storagelocation      = ls_item-storagelocation
                                                         checkbox             = abap_true

*                                                    batch                = 'BILLET'
                                                         length = ls_item-length
                                                         width = ls_item-width
                                                         pcs = ls_item-pcs
                                                         purchaseitm = ls_item-purchaseitm
                                                         purchaseorder = ls_item-purchaseorder
                                                         prioritypo = ls_item-prioritypo
   %control-checkbox             = if_abap_behv=>mk-on
                                                         %control-item        = if_abap_behv=>mk-on
                                                         %control-referenceid = if_abap_behv=>mk-on
                                                         %control-material    = if_abap_behv=>mk-on
                                                         %control-plant       = if_abap_behv=>mk-on
                                                         %control-storagelocation = if_abap_behv=>mk-on
*                                                    %control-batch       = if_abap_behv=>mk-on
                                                         %control-uom         = if_abap_behv=>mk-on
                                                          %control-length = if_abap_behv=>mk-on
                                                          %control-width = if_abap_behv=>mk-on
                                                          %control-pcs = if_abap_behv=>mk-on
                                                          %control-purchaseitm = if_abap_behv=>mk-on
                                                          %control-purchaseorder = if_abap_behv=>mk-on
                                                          %control-prioritypo = if_abap_behv=>mk-on

                                                         ) ) ) )
                    " TODO: variable is assigned but never used (ABAP cleaner)
                    MAPPED FINAL(ls_mapped_101)
                    " TODO: variable is assigned but never used (ABAP cleaner)
                    FAILED FINAL(ls_failed_101)
                    " TODO: variable is assigned but never used (ABAP cleaner)
                    REPORTED FINAL(ls_reported_101).
**********************************************************************
      ENDIF.
    ENDIF.
**********************************************************************


  ENDMETHOD.

*  METHOD stock.
***********************************************************************
*    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
*            ENTITY zr_billet_101
*            ALL FIELDS
*            WITH CORRESPONDING #( keys )
*            RESULT FINAL(lt_101)
*            " TODO: variable is assigned but never used (ABAP cleaner)
*            FAILED FINAL(revfailed).
*
*    LOOP AT lt_101 ASSIGNING FIELD-SYMBOL(<lfs_101>).
*
*     MODIFY ENTITIES OF zr_billet_hdr IN LOCAL MODE
*             ENTITY zr_billet_101
*             UPDATE
*             FIELDS ( storagelocation  )
*             WITH VALUE #( FOR key IN keys
*                           ( %tky                     = <lfs_101>-%tky
*
*                             storagelocation          = <lfs_101>-storagelocation
*
*                             %control-storagelocation = if_abap_behv=>mk-on
*                              ) ).
*
*    ENDLOOP.
*
*
*    ENDMETHOD.

ENDCLASS.


CLASS lhc_zr_billet_261 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_billet_261 RESULT result.

ENDCLASS.


CLASS lhc_zr_billet_261 IMPLEMENTATION.
  METHOD get_instance_features.
    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS  WITH CORRESPONDING #( keys )
         RESULT FINAL(gt_header)
         " TODO: variable is assigned but never used (ABAP cleaner)
         FAILED FINAL(gt_failed).

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_261
         ALL FIELDS  WITH CORRESPONDING #( keys )
         RESULT FINAL(gt_261)
         " TODO: variable is assigned but never used (ABAP cleaner)
         FAILED FINAL(gt_261failed).

    FINAL(gs_header) = VALUE #( gt_header[ 1 ] OPTIONAL ).

    result = VALUE #( FOR gs_261 IN gt_261
                      ( %tky    = gs_261-%tky

                        %update = COND #( WHEN gs_header-postcheck = ''
                                          THEN if_abap_behv=>fc-o-enabled
                                          ELSE if_abap_behv=>fc-o-disabled ) ) ).
  ENDMETHOD.

ENDCLASS.


CLASS lhc_zr_billet_531 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_billet_531 RESULT result.

ENDCLASS.


CLASS lhc_zr_billet_531 IMPLEMENTATION.
  METHOD get_instance_features.
    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_hdr
         ALL FIELDS  WITH CORRESPONDING #( keys )
         RESULT FINAL(gt_header)
         " TODO: variable is assigned but never used (ABAP cleaner)
         FAILED FINAL(gt_failed).

    READ ENTITIES OF zr_billet_hdr IN LOCAL MODE
         ENTITY zr_billet_531
         ALL FIELDS  WITH CORRESPONDING #( keys )
         RESULT FINAL(gt_531)
         " TODO: variable is assigned but never used (ABAP cleaner)
         FAILED FINAL(gt_531failed).

    FINAL(gs_header) = VALUE #( gt_header[ 1 ] OPTIONAL ).

    result = VALUE #( FOR gs_531 IN gt_531
                      ( %tky    = gs_531-%tky

                        %update = COND #( WHEN gs_header-postcheck = ''
                                          THEN if_abap_behv=>fc-o-enabled
                                          ELSE if_abap_behv=>fc-o-disabled ) ) ).
  ENDMETHOD.
ENDCLASS.


CLASS lhc_zr_billet_htb DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_billet_htb RESULT result.

ENDCLASS.


CLASS lhc_zr_billet_htb IMPLEMENTATION.
  METHOD get_instance_features.
  ENDMETHOD.
ENDCLASS.
