CLASS lhc__Hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _Hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _Hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _Hdr RESULT result.

    METHODS Gtdata_1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Hdr~Gtdata_1.

ENDCLASS.

CLASS lhc__Hdr IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zpp_app04_rv IN LOCAL MODE
      ENTITY _Hdr
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_Hdr).

    result = VALUE #( FOR ls_data IN lt_Hdr
    (   %tky =  ls_data-%tky
%features-%field-Plant =  COND #( WHEN ls_data-Plant IS NOT INITIAL

                                                THEN if_abap_behv=>fc-f-read_only

                                                ELSE if_abap_behv=>fc-f-unrestricted  )
%features-%field-Matnr = COND #( WHEN ls_data-Matnr IS NOT INITIAL

                                                THEN if_abap_behv=>fc-f-read_only

                                                ELSE if_abap_behv=>fc-f-unrestricted  )
%features-%field-Vblen = COND #( WHEN ls_data-Vblen IS NOT INITIAL

                                                THEN if_abap_behv=>fc-f-read_only

                                                ELSE if_abap_behv=>fc-f-unrestricted  )
    ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD Gtdata_1.
    DATA : gthdt TYPE TABLE OF zpp_app04_tb1,
           gshdt TYPE zpp_app04_tb1,
           gtidt TYPE TABLE OF zpp_app04_tb2,
           gsidt TYPE zpp_app04_tb2.
**********************************************************************
    READ ENTITIES OF zpp_app04_rv IN LOCAL MODE
    ENTITY _Hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_Hdr).

    DATA(ls_Hdr) = lt_hdr[ 1 ].

    SELECT SINGLE MAX( jobsheet ) AS Jobsheet FROM zpp_app04_tb1 INTO @DATA(wa_jobsheet) .
    IF wa_jobsheet IS NOT INITIAL.
      gshdt-jobsheet = wa_jobsheet + 1.
    ELSE.
      gshdt-jobsheet = 1000000000.
    ENDIF.
    gshdt-plant = ls_hdr-Plant.
    gshdt-matnr = ls_hdr-Matnr.
    gshdt-vblen = ls_hdr-Vblen.
    gshdt-createdby = ls_hdr-Createdby.
    gshdt-createdon = ls_hdr-Createdon.


    APPEND  gshdt TO gthdt .
**********************************************************************
    SELECT * FROM zpp_app04_tb2 INTO TABLE @DATA(it_jobset).

    IF it_jobset IS INITIAL.
      IF gshdt-plant IS NOT INITIAL.
        SELECT *
          FROM ZPP_Orderitem_Rv
          WHERE ProductionPlant = @gshdt-Plant
      AND Material        = @gshdt-Matnr
          INTO TABLE @DATA(lt_morder).
ELSEIF gshdt-vblen IS NOT INITIAL.
  SELECT *
    FROM ZPP_Orderitem_Rv
    WHERE ProductionPlant = @gshdt-Plant
      AND SalesOrder      = @gshdt-Vblen
    INTO TABLE @lt_morder.
      ENDIF.
      gtidt = VALUE #( FOR ls_morder IN lt_morder ( jobsheet = gshdt-jobsheet
                                                    burks = ls_morder-CompanyCode
                                                    sfgordnum = ls_morder-ManufacturingOrder
                                                    sfgordnitm = ls_morder-ManufacturingOrderItem
                                                    sfgsloc = ls_morder-StorageLocation
                                                    sfgordtxt = ''
                                                    sfgmatnr =  ls_morder-Material
                                                    sfgmaktx = ls_morder-ProductName
                                                    sfgbatch = ls_morder-Batch
                                                    sfgordtyp = ls_morder-ManufacturingOrderType
                                                    sfgplndqty = ls_morder-MfgOrderItemPlannedTotalQty
                                                    sfgplndunt = ls_morder-ProductionUnit
                                                    soitem = ls_morder-SalesOrderItem
                                                    salesord = ls_morder-SalesOrder
                                                    createdby = ls_hdr-Createdby
                                                    createdon =  ls_hdr-Createdon
                                                    weakrs   =  ls_morder-ProductionPlant

                                                      ) ).
    ELSE.
      SELECT *
        FROM ZPP_Orderitem_Rv AS rv
        WHERE ProductionPlant = @gshdt-Plant
          AND NOT EXISTS (
               SELECT 1
                 FROM zpp_app04_tb2 AS js
                 WHERE sfgordnum = rv~ManufacturingOrder
                    )
        INTO TABLE @DATA(lt_morder1).

      gtidt = VALUE #( FOR ls_morder IN lt_morder1 ( jobsheet = gshdt-jobsheet
                                                    burks = ls_morder-CompanyCode
                                                    sfgordnum = ls_morder-ManufacturingOrder
                                                    sfgordnitm = ls_morder-ManufacturingOrderItem
                                                    sfgsloc = ls_morder-StorageLocation
                                                    sfgordtxt = ''
                                                    sfgmatnr =  ls_morder-Material
                                                    sfgmaktx = ls_morder-ProductName
                                                    sfgbatch = ls_morder-Batch
                                                    sfgordtyp = ls_morder-ManufacturingOrderType
                                                    sfgplndqty = ls_morder-MfgOrderItemPlannedTotalQty
                                                    sfgplndunt = ls_morder-ProductionUnit
                                                    soitem = ls_morder-SalesOrderItem
                                                    salesord = ls_morder-SalesOrder
                                                    createdby = ls_hdr-Createdby
                                                    createdon =  ls_hdr-Createdon
                                                     weakrs   =  ls_morder-ProductionPlant

                                                      ) ).

    ENDIF.
**********************************************************************




**********************************************************************
    IF gthdt IS NOT INITIAL.
      zbp_pp_app04_rv=>gtdata_1 = gthdt.
    ENDIF.
    IF gtidt IS NOT INITIAL.
      zbp_pp_app04_rv=>gtitmdata_1 = gtidt.
    ENDIF.
*    IF gtritm IS NOT INITIAL.
*      zbp_pp_app04_rv=>gtritmdata_1 = gtritm.
*    ENDIF.




  ENDMETHOD.

ENDCLASS.

CLASS lhc__Itm DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _Itm RESULT result.

    METHODS Gtitmdata_1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Itm~Gtitmdata_1.

ENDCLASS.

CLASS lhc__Itm IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD Gtitmdata_1.
**********************************************************************


    READ ENTITIES OF zpp_app04_rv IN LOCAL MODE
    ENTITY _Hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    ENTITY _Hdr BY \_Item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
**********************************************************************
DATA(ls_item) = lt_item[ 1 ].
**********************************************************************

    zbp_pp_app04_rv=>utitmdata_1 = VALUE #( FOR ls IN lt_item  WHERE ( Reqty IS NOT INITIAL  ) ( CORRESPONDING #( ls ) ) ).

**********************************************************************
    DATA : gtritm TYPE TABLE OF zpp_app04_tb3,
           gsritm TYPE zpp_app04_tb3.

    READ ENTITIES OF i_billofmaterialtp_2 PRIVILEGED
            ENTITY billofmaterial
            EXECUTE explodebom
              FROM VALUE #(  FOR gsitem IN zbp_pp_app04_rv=>utitmdata_1
                (
                  plant          = gsitem-weakrs
                  material       = gsitem-sfgmatnr
                  billofmaterialcategory = 'M'
                  %param-bomexplosionapplication = 'PP01'
                  %param-requiredquantity = gsitem-reqty
*                %param-BOMExplosionIsAlternatePrio = 1
                  %param-explodebomlevelvalue = 0
                  %param-bomexplosionismultilevel = 'X'
                )
              )
              RESULT  DATA(lt_result)
              FAILED DATA(ls_failed)
              REPORTED DATA(ls_reported).
    IF lt_result IS NOT INITIAL.

      gtritm =  VALUE #( FOR ls_result IN lt_result INDEX INTO lv
                                                 ( jobsheet = ls_item-jobsheet
                                                      sno      = lv
                                                      matnr = ls_result-%param-BillOfMaterialComponent
                                                      maktx = ls_result-%param-ComponentDescription
                                                      quantity = ls_result-%param-ComponentQuantityInCompUoM
                                                      uom = ls_result-%param-billofmaterialitemunit
                                                                                 ) ).

    ELSE.

    ENDIF.


  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APP04_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APP04_RV IMPLEMENTATION.

  METHOD save_modified.
    IF create-_hdr IS NOT INITIAL.
      IF zbp_pp_app04_rv=>gtdata_1 IS NOT INITIAL.
        MODIFY zpp_app04_tb1 FROM TABLE @zbp_pp_app04_rv=>gtdata_1.
      ENDIF.
      IF zbp_pp_app04_rv=>gtitmdata_1 IS NOT INITIAL.
        MODIFY zpp_app04_tb2 FROM TABLE @zbp_pp_app04_rv=>gtitmdata_1.
      ENDIF.


    ENDIF.

    IF zbp_pp_app04_rv=>utitmdata_1 IS NOT INITIAL.
      MODIFY zpp_app04_tb2 FROM TABLE @zbp_pp_app04_rv=>utitmdata_1.
      DELETE  FROM zpp_app04_tb2 WHERE reqty IS INITIAL.
       IF zbp_pp_app04_rv=>gtritmdata_1 IS NOT INITIAL.
        MODIFY zpp_app04_tb3 FROM TABLE @zbp_pp_app04_rv=>gtritmdata_1.
      ENDIF.
    ENDIF.


    IF delete-_hdr IS NOT INITIAL.
      LOOP AT delete-_hdr INTO DATA(wa_delted).
        DELETE  FROM zpp_app04_tb1 WHERE jobsheet = @wa_delted-Jobsheet.
        DELETE FROM zpp_app04_tb2 WHERE jobsheet =  @wa_delted-Jobsheet.
        DELETE from zpp_app04_tb3 where jobsheet = @wa_delted-Jobsheet.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
