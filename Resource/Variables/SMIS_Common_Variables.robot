*** Variables ***

${path_download}        ${CURDIR}//..//Keywords//Download
${path_editFile}        ${CURDIR}//..//Keywords//EditFile
# ${path_editExcelFile}        ..\Keywords\EditFile
${path_logdownload}     ${CURDIR}//..//Test_Data//Download_log
${loc_user}  id:txtuid
${loc_password}  id:txtpass
${btn_submitLogin}  //input[contains(@name,'btnSubmit')]
${alert_close}  id:alert_close
${Menu_Sale_Order}  //span[@class='folder'][contains(.,'Sale Order')]
${subMenu_SaleOrderList}   //a[contains(.,'Sale Order List')]
${input_orderNo}   id:cpListEntry_txtSaleOrderNo
${Search_btn}  id:cpListEntry_btnAction_btnSearch
${edit_btn}   id:cpListEntry_gvSaleOrder_ImgBtnEdit_0
${Checkbox_CF}  id:cpListEntry_rdStatus_2
${radio_Confirm}  id:cpListEntry_rdStatus_2
${saveSaleOrder_btn}   id:cpListEntry_btnSubmit
${Logout_btn}  id:btnLogout
@{loading}  
...  id:__dimScreen
...  //div[contains(@class,'img-loading')]
...  //div[contains(@class,'modal-backdrop fade in')]

${loading_CPSM}  //div[contains(@class,'img-loading')]
${correct_btn}  id:cpListEntry_gvSaleOrder_ImgBtnStatus_0
${loc_getStatus}   (//td[contains(.,'Confirm')])[4]

@{list_Sale_Order_Management}
...  //legend[contains(.,'ข้อมูลลูกค้าผู้มาติดต่อ')]
...  //legend[contains(.,'รายละเอียดรายการ')]

${Contract_menu}   //span[@class='folder'][contains(.,'Contract')]
${Contract_list_menu}   //a[contains(.,'Contract List')]
${input_Quotation_No}   id:cpListEntry_txtQuotation
${btn_export}  id:cpListEntry_btnExport
${Calandar}  id:dpkContractSigningDate
${Status_dropdown}      (//span[@unselectable='on'][contains(.,'Open')])[3]
${OncontractStatus}     (//*[contains(text(),'On Contract')])[1]
${Save_btn}     //a[contains(.,'Save')]
${popup_Success}   //div[contains(@class,'modal-content')]
${CreateAttachment_btn}     id:cpListEntry_gvContractList_img_Attachment_0
${Export_btn}       id:cpListEntry_btnExport

# ------------------------------------------------------------------------------------------
#${testCompany}             //*[@id="cpListEntry_Label1"]
# ${belowpage}        //*[@id="main"]/div[3]/p

${input_usrname}        //input[@id="txtuid"]
${input_password}       //*[@id="txtpass"]
# ${OK_popup}             //*[@id="colorbox_alert"]/table/tbody/tr[3]/td/img
${cpListEntry_txtSaleOrderNo}        //*[@id="cpListEntry_txtSaleOrderNo"]

# ${BROWSER}        	gc
${FleExcel}      Data.xlsx
${nameSheet}      SheetData1
# ${indexSaleOrderNo}    3
# ${getorderNo}  Read Excel Column     col_num=${indexSaleOrderNo}
${cpListEntry_txtSaleOrderNo}    //*[@id="cpListEntry_txtSaleOrderNo"]
${cpListEntry_txtSaleOrderNo}    //*[@id="cpListEntry_txtSaleOrderNo"]

${SMIS_URL}       https://test-csm.intra.ais/SMIS/Form/UT_Login.aspx
${SaleOrder_menu}     xpath=//span[contains(text(),'Sale Order')]
${SaleOrderlist_menu}     xpath=//a[contains(text(),'Sale Order List')]
# ${btnok_login}          xpath=//*[@id="alert_close"]
# ${Search_btn}           cpListEntry_btnAction_btnSearch
${Checkbox_CF}       //*[@id="cpListEntry_rdStatus_2"]
${Logout_btn}       //*[@id="btnLogout"]

# ${Calandar}        //label[contains(text(),'วันที่ลูกค้าลงนามในข้อตกลงและเงื่อนไข :')]/parent::div//input

${OncontractStatus}     (//*[contains(text(),'On Contract')])[1]

${input_orderNo}    //input[@id="cpListEntry_txtSaleOrderNo"]
# ${ok_popup}         //div[@class="modal-content"]/div[3]/button
${input_usrname}        //input[@id="txtuid"]
${input_password}       //input[@id="txtpass"]
${cpListEntry_txtSaleOrderNo}        //*[@id="cpListEntry_txtSaleOrderNo"]



${nameSheet1}       SheetData1


${SMIS_URL}     https://test-csm.intra.ais/SMIS/Form/UT_Login.aspx
${input_usrname}        //input[@id="txtuid"]
${input_password}       //input[@id="txtpass"]
${search_contract}      //input[@id="DeliveryManagement_ContractNo"]
${search_btn}           //a[@id="DeliveryManagement_btnSearch"]
${ok_btn}               //*[@id="btnShipToSave"]
${input_form}           //*[@id="txtCP_DeliveryManagement_From"]
${input_to}             //input[@id="txtCP_DeliveryManagement_To"]
${Add_record}           //*[@id="btnCP_DeliveryManagement_AddAT"]
${Add_btn}              //button[contains(.,'Add')]
${Clear_btn}            //*[@id="btnMainClear"]
${SMIS_URL}             https://test-csm.intra.ais/SMIS/Form/UT_Login.aspx
${input_usrname}        //input[@id="txtuid"]
${input_password}       //input[@id="txtpass"]
${Input_Order}          //*[@id="txtSaleOrderNo"]
${Information}          //div[@id="divPopupPrinPickGoods"]
${success_popup}        //div[@class="modal-content"]
${SMIS_URL}             https://test-csm.intra.ais/SMIS/Form/UT_Login.aspx
${input_usrname}        //input[@id="txtuid"]
${input_password}       //input[@id="txtpass"]
${CheckAll}             id:checkall
${Popup_sucess}         //*[@id="divPopupAlreadyGrouping"]
${PrintDO_btn}          id:btnPrintDO
${Cancel_DO}            id:btnCancelDO
${SMIS_URL}     https://test-csm.intra.ais/SMIS/Form/UT_Login.aspx
${Save_Attach_btn}             id:cpListEntry_BtnAttCheckAccountNumber
${Import_btn}    (//*[contains(text(),'Save')])[1]
${choose_file_btn}     id:ctl00_cpListEntry_fupData_ctl02
${promotionname}    //tr[@id='cpListEntry_trddlPromotionName1']//input[@id="cpListEntry_txtPromotionNameSearch"]
${selectpro}        //select[@id="cpListEntry_ddlPackage"]
${Searchpro}         //*[@id="cpListEntry_btnSearch"]
${save_import}      id:cpListEntry_btnSave
${Plus_btn}   //img[@src='../Image/collapsed.gif']
${edit_attachment}   id:cpListEntry_gvContractList_gvAttach_0_btnEdit_0
${filesim_path}            C:\Users\Paweesuda\PycharmProjects\SMA\Resource\PageKeywords\C2022_000520_AT000988_19102022_132412.xlsx
${input_usrname}        //input[@id="txtuid"]
${input_password}       //input[@id="txtpass"]
${dropdown_promorion}          //select[@id="cpListEntry_ddlPackage"]
${List_pakage}          //select[@id="cpListEntry_ddlPackage"]
${List_pakage}          //select[@id="cpListEntry_ddlPackage"]
${update_btn}           id:cpListEntry_btnUpdate
${Frame}                xpath=//iframe[@class="cboxIframe"]
${input_NoFrom}   id:cpListEntry_txtNoFrom
${Input_NoTo}     id:cpListEntry_txtNoTo
${Input_Promption}      id:cpListEntry_txtPromotionNameSearch
${Scroll_Search}        //span[@id="cpListEntry_lblddlPackageNameTextSearch"]
${Search_Pro}           id:cpListEntry_btnSearch
${Frame2}               //*[@id="cboxLoadedContent"]/iframe

${SMIS_URL}     https://test-csm.intra.ais/SMIS/Form/UT_Login.aspx
${CB_warhouse}      //input[@id="cpListEntry_rdoChooseCPSM_0"]
${submit_btn}       //input[@id="cpListEntry_ImageButton1"]
${requestSIM_btn}   id:cpListEntry_BtnRequestSIM
${exportfile_btn}       //a[@class='btn btn-default'][contains(.,'Export')]
${browse_file_btn}      //input[@id="filesImportData"]
${input_usrname}        //input[@id="txtuid"]
${input_password}       //input[@id="txtpass"]
${submit_btn}           //a[@id="btnSubmit"]
${btn_Submit}           id:btnSubmit
${btnSelectWordfile}    xpath=//input[@type="file"]
${imgFile}              C:\Users\Paweesuda\PycharmProjects\SMA\Resource\PageKeywords\ContractAttachment_20221010103824.xlsx
${titleFileOnQueue}     xpath=//span[@title="testfile.png"]

# #-----------------------------------------------------------------------------------
@{list_Contract Management}
...  //label[contains(.,'กรุณากรอกข้อมูลตามความเป็นจริง และลงลายมือชื่อพร้อมแนบสำเนาเอกสารประกอบตามคำแนะนำให้ครบถ้วน')]
...  id:logoTitle
...  id:dpkContractSigningDate
...  id:btnSaveNEW

${popup_success}  //button[contains(@data-bb-handler,'success')]
${loc_QuotationNo}   id:cpListEntry_lblQuotationNoSMT
${check_On_Contract}  (//span[@unselectable='on'][contains(.,'On Contract')])[3]

@{list_Manage_Attachment}
...  //span[contains(@id,'lblTab1')][contains(.,'ผู้ใช้บริการ')]
...  //span[contains(@id,'lblMoaMoa')][contains(.,'ค่าเหมาจ่าย / ค่าเช่า')]
...  //span[contains(@id,'lblTab2')][contains(.,'การจัดส่งสินค้า')]
...  //span[contains(@id,'lblTabResult')][contains(.,'แสดงผล')]
...  //span[contains(.,'วันที่เอกสารและมูลค่าสัญญา')]
...  ${Save_Attach_btn}
...  id:cpListEntry_BtnAttCancel

${btn_export_ContractAttachment}   id:cpListEntry_btnDoIt
${btn_ImportNumber}  id:cpListEntry_btnImportNumber
${Entry_txtTotalRecord}  id:cpListEntry_txtTotalRecord

@{list_Promotion_detail}
...  (//td[@align='center'][contains(.,'G1800033')])[3]
...  (//td[@align='left'][contains(.,'-โทร 400 นาที เหมาจ่าย 850 บาท ส่วนเกินนาทีละ 2.50 บาท')])[1]
${check_file_upload}   //span[contains(@class,'k-filename')]
${check_upload_progress}  //strong[contains(.,'Doneuploaded')]

${Menu_CorporateSellingManagement}  //span[@class='folder'][contains(.,'Corporate Selling Management')]
${subMenu_CorporateSellingManagement}   //span[@class='file'][contains(.,'Corporate Selling Management')]
${Menu_ContractPhone}   //li[contains(@id,'ContractPhone')]
${subMenu_DeliveryManagement}   (//li[contains(.,'Delivery Management')])[1]
${Deli_SaleOrder}  id:DeliveryManagement_SaleOrderNo
${icon_Choose}   //a[contains(@class,'k-button k-button-icontext k-grid-Select btnSearch')]

@{list_DeliveryMangement}
...  (//div[contains(@class,'row marginTop')])[1]
...  (//div[@class='row marginTop'])[2]

${btn_Add_ShipTo}   id:btnSearchShipTo
${btn_Choose_Address}   (//tr[contains(@role,'row')])[1]    # Choose delivery location ครั้งที่ 1 
${btn_ShipTo_Save}   id:btnShipToSave
${icon_deliveryChoose}   //a[contains(@title,'Choose')]
@{list_panel_ManageDevice}  
...  id:panelManageDevice
...  id:GridDevice
${check_dataInTable}   (//td[@role='gridcell'][contains(.,'1')])[5]
${Device_From}  id:txtCP_DeliveryManagement_From
${Device_To}  id:txtCP_DeliveryManagement_To
${Delete_Device}   id:btnCP_DeliveryManagement_DelAT
${Add_Device}  id:btnCP_DeliveryManagement_AddAT
${btn_Reserve}  id:btnMainSave
${Choose_deliverylocation}   (//tr[contains(@role,'row')])[3]    # Choose delivery location ครั้งที่ 2
${check_location_no2}  (//td[@role='gridcell'][contains(.,'2')])[4]
${Choose_location_2}   (//a[contains(@title,'Choose')])[2]
${subMenu_GroupingOrderManagement}   //a[contains(.,'Grouping Order Management')]
${GruopingManagement}   id:GridCP_GruopingManagement
${checkBox_AutoRefresh}   id:chkAutoRefresh
${txt_SaleOrderNo}  id:txtSaleOrderNo
${input_SaleOrderNo}  id:txtSaleOrder
${btn_Search}   //a[contains(.,'Search')]
${checkAll_GroupingOrder}   //input[contains(@class,'checkAll btnAdd')]
${btn_GroupingOrder}   id:btnCreateDO
${btn_CreateDO}  id:btnCreateDO
@{list_ConfirmGroupingOrder}
...  //span[contains(.,'Confirm Grouping Order')]
...  //a[contains(.,'Save')]
${text_PickNo}  id:divPickNo
@{list_popupInformation}
...  //span[contains(.,'Information')]
...  //a[contains(@onclick,'PrinPickGoods()')]
...  //a[@class='btn btn-success '][contains(.,'Print Pick Goods By Sale Order')]
${btn_PrinPickGoods}  //a[contains(@onclick,'PrinPickGoods()')]
${x_Close}   (//a[@role='button'][contains(.,'Close')])[2]
${CPSM_Logout}   //a[contains(@title,'Logout')]
${subMenu_GroupingOrderList}   //a[contains(.,'Grouping Order List')]
${grid_GruopingOrderList}   id:gridGruopingOrderList
${txt_PickNo}  id:txtPickNo
${icon_ExportFile}   //a[contains(@title,'Export File')]
${subMenu_CreateDOManagement}  //a[contains(.,'Create DO Management')]
${btn_PrintDO}   //a[contains(.,'Print DO')]
${subMenu_CancelReprintDOManagement}  //a[contains(.,'Cancel / Reprint DO Management')]
${grid_DetailCancelDO}  id:gridDetailCancelDO
${loc_ContractNo}   id:cpListEntry_lblContractNo
${iframe_cboxIframe}   //iframe[contains(@class,'cboxIframe')]
${button_Search}   id:DeliveryManagement_btnSearch
${popup_btn_ok}  //button[text()='OK']
${popup_text_success}   //div[text()='บันทึกข้อมูลเรียบร้อยแล้ว']
@{list_SearchShipTo}  
...  //span[text()='SMIS_CP020 : Search Ship To']
...  id:btnSearchShipto
...  id:btnResetShipTo
...  id:btnAddOneTimeShipTo
...  id:GridSearchShipTo
${check_Page_DeliveryManagement}   //span[text()='Contract Phone > SMIS_CP019 : Delivery Management']
${txt_you_want_to_reserve}   //div[text()='Are you sure you want to reserve ?']
${text_success}   //div[@class='modal-body'][contains(.,'บันทึกข้อมูลเรียบร้อยแล้ว')]
${check_data_Attachment}   (//tr[contains(@role,'row')])[2]
${popup_detail_Confirmation}   //h4[text()=' Confirmation']
