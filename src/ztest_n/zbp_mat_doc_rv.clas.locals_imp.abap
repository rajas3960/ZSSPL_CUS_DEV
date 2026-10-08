CLASS lhc_items DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Items RESULT result.
    METHODS fillmaterialdescription FOR DETERMINE ON MODIFY
      IMPORTING keys FOR items~fillmaterialdescription.

ENDCLASS.

CLASS lhc_items IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zmat_doc_rv IN LOCAL MODE
      ENTITY Header
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_hdr)
      ENTITY Header BY \_Item
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_status).
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    IF ls_hdr-Docno IS NOT INITIAL.
      result = VALUE #( FOR ls_data IN lt_status
        ( %tky =  ls_data-%tky
            %update =   if_abap_behv=>fc-o-disabled
            %delete =   if_abap_behv=>fc-o-disabled  )  ) .
    ENDIF.


  ENDMETHOD.

  METHOD Fillmaterialdescription.

    READ ENTITIES OF zmat_doc_rv IN LOCAL MODE
    ENTITY Items
    FIELDS ( Material )
    WITH CORRESPONDING #( keys )
    RESULT DATA(it_data).

    LOOP AT it_data INTO DATA(ls_data) WHERE Material IS NOT INITIAL.
      SELECT SINGLE ProductDescription
        FROM I_ProductDescription
        WHERE Product  = @ls_data-Material
          AND Language = @sy-langu
        INTO @DATA(lv_description).

      MODIFY ENTITIES OF zmat_doc_rv IN LOCAL MODE
      ENTITY Items
      UPDATE FIELDS ( Mdesc  )
      WITH VALUE #( (
      %tky = ls_data-%tky
      Mdesc = lv_description
      %control-Mdesc = if_abap_behv=>mk-on ) ) .

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

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
    METHODS Getdata FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~Getdata.
    METHODS CreatePo FOR MODIFY
      IMPORTING keys FOR ACTION Header~CreatePo RESULT result.



ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITIES OF zmat_doc_rv IN LOCAL MODE
      ENTITY Header
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_status).

**********************************************************************
    result = VALUE #( FOR ls_data IN lt_status
      ( %tky =  ls_data-%tky
        %features-%action-PostGI = COND #( WHEN ls_data-Docno IS NOT INITIAL
                                            THEN if_abap_behv=>fc-o-disabled
                                            ELSE if_abap_behv=>fc-o-enabled   )

         %features-%action-CreatePo = COND #( WHEN ls_data-Pono is not initial
                                            THEN if_abap_behv=>fc-o-disabled
                                            ELSE if_abap_behv=>fc-o-enabled )

          ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD PostGI.

    DATA : lt_hdrupd TYPE TABLE OF zmat_doc_grr,
           ls_hdrupd TYPE zmat_doc_grr.
    READ ENTITIES OF zmat_doc_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_header)
    ENTITY Header BY \_Item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_items).
    DATA(ls_header) = lt_header[ 1 ].

    IF lt_items IS NOT INITIAL.

      DATA(lt_podata) = lt_items.

    ENDIF.

    MODIFY ENTITIES OF I_MaterialDocumentTP PRIVILEGED
                   ENTITY MaterialDocument
                   CREATE FROM VALUE #( ( %cid = 'CID_001'
                                          GoodsMovementCode = '03'
                                          PostingDate = ls_header-Postingdate
                                          DocumentDate = ls_header-Documentdate
                                          %control-GoodsMovementCode = cl_abap_behv=>flag_changed
                                          %control-PostingDate = cl_abap_behv=>flag_changed
                                          %control-DocumentDate = cl_abap_behv=>flag_changed ) )
                ENTITY MaterialDocument
                CREATE BY \_MaterialDocumentItem
                FROM VALUE #( FOR ls_poitem IN lt_items (
                                            %cid_ref = 'CID_001'
                                            %target = VALUE #( ( %cid = 'CID_ITM_' && ls_poitem-Itemno
                                                                 Plant = ls_poitem-Plant
                                                                 Material = ls_poitem-Material
                                                                  GoodsMovementType = ls_poitem-Gmtype
                                                                  StorageLocation = ls_poitem-Sloc
                                                                  QuantityInEntryUnit = ls_poitem-Matqty
                                                                  EntryUnit = ls_poitem-Uom
                                                                  MaterialDocumentItemText = ls_poitem-Hdrdesc
                                                                  CostCenter = ls_poitem-Costcenter
                                                                  GLAccount = ls_poitem-Glaccount
                                                                  %control-Plant = cl_abap_behv=>flag_changed
                                                                  %control-Material = cl_abap_behv=>flag_changed
                                                                  %control-GoodsMovementType = cl_abap_behv=>flag_changed
                                                                  %control-StorageLocation = cl_abap_behv=>flag_changed
                                                                  %control-QuantityInEntryUnit = cl_abap_behv=>flag_changed
                                                                  %control-EntryUnit = cl_abap_behv=>flag_changed
                                                                  %control-MaterialDocumentItemText = cl_abap_behv=>flag_changed
                                                                  %control-CostCenter = cl_abap_behv=>flag_changed
                                                                  %control-GLAccount = cl_abap_behv=>flag_changed ) )                ) )
          MAPPED DATA(ls_mapped)
          FAILED DATA(ls_failed)
          REPORTED DATA(ls_reported).
    IF ls_failed IS INITIAL.
      zbp_mat_doc_rv=>cv_mat_doc = ls_mapped.
      MOVE-CORRESPONDING ls_header TO ls_hdrupd.
      APPEND ls_hdrupd TO lt_hdrupd.
      zbp_mat_doc_rv=>gt_hrdupd = lt_hdrupd.
    ELSE.

    ENDIF.

    result = VALUE #( FOR ls_ord IN lt_header
                     ( %tky = ls_ord-%tky
                       %param = ls_ord ) )   .



  ENDMETHOD.

  METHOD Getdata.
    DATA: lt_hdrcrt TYPE TABLE OF zmat_doc_grr,
          ls_hdrcrt TYPE zmat_doc_grr.

    READ ENTITIES OF zmat_doc_rv IN LOCAL MODE
      ENTITY Header
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_hdrdata).

    DATA(ls_hdrdata) = lt_hdrdata[ 1 ].

    ls_hdrcrt-uuid          = ls_hdrdata-Uuid.
    ls_hdrcrt-docno         = ls_hdrdata-Docno.
    ls_hdrcrt-companycode   = ls_hdrdata-CompanyCode.
    ls_hdrcrt-supplier      = ls_hdrdata-Supplier.
    ls_hdrcrt-material      = ls_hdrdata-Material.
    ls_hdrcrt-status        = ls_hdrdata-Status.
    ls_hdrcrt-createdat     = ls_hdrdata-Createdat.
    ls_hdrcrt-createdby     = ls_hdrdata-Createdby.
    ls_hdrcrt-documentdate  = ls_hdrdata-Documentdate.
    ls_hdrcrt-lastchangedat = ls_hdrdata-Lastchangedat.
    ls_hdrcrt-lastchangedby = ls_hdrdata-Lastchangedby.
    ls_hdrcrt-postingdate   = ls_hdrdata-Postingdate.
    ls_hdrcrt-pono          = ls_hdrdata-Pono.
    ls_hdrcrt-mdesc         = ls_hdrdata-Mdesc.

    APPEND ls_hdrcrt TO lt_hdrcrt.
    zbp_mat_doc_rv=>gt_hrdcrt = lt_hdrcrt.


  ENDMETHOD.





  METHOD CreatePo.






  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZMAT_DOC_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZMAT_DOC_RV IMPLEMENTATION.

  METHOD save_modified.

    IF create-header IS NOT INITIAL.
      IF zbp_mat_doc_rv=>gt_hrdcrt IS NOT INITIAL.
        DATA(it_hdrcrt) = zbp_mat_doc_rv=>gt_hrdcrt.
        MODIFY zmat_doc_grr FROM TABLE @it_hdrcrt.
      ENDIF.
    ENDIF.


    IF update-header IS NOT INITIAL.

      LOOP AT update-header ASSIGNING FIELD-SYMBOL(<fs_upd>).
        UPDATE zmat_doc_grr SET
                documentdate = @<fs_upd>-Documentdate,
                postingdate = @<fs_upd>-Postingdate,
                material = @<fs_upd>-Material,
                supplier = @<fs_upd>-Supplier,
                companycode = @<fs_upd>-Companycode,
                mdesc = @<fs_upd>-Mdesc,
                pono = @<fs_upd>-Pono,
                lastchangedat = @<fs_upd>-Lastchangedat,
                lastchangedby = @<fs_upd>-Lastchangedby
               WHERE uuid = @<fs_upd>-Uuid.
      ENDLOOP.

    ENDIF.

    IF zbp_mat_doc_rv=>cv_mat_doc IS NOT INITIAL.

      LOOP AT zbp_mat_doc_rv=>cv_mat_doc-materialdocument ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
        CONVERT KEY OF I_MaterialDocumentTP FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
        <fs_pr_mapped>-MaterialDocument = ls_pr_key-MaterialDocument.
      ENDLOOP.
      IF zbp_mat_doc_rv=>gt_hrdupd IS NOT INITIAL.
        DATA(lt_hdrupd) = zbp_mat_doc_rv=>gt_hrdupd.
        LOOP AT lt_hdrupd ASSIGNING FIELD-SYMBOL(<fs_hdrupd>).
          <fs_hdrupd>-docno = ls_pr_key-MaterialDocument.

        ENDLOOP.
        MODIFY zmat_doc_grr FROM TABLE @lt_hdrupd.
      ENDIF.

    ENDIF.


  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
