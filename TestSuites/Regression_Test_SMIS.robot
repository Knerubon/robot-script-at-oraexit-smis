*** Settings ***
Metadata        Version 1.0.0
Documentation   Regression Test SMIS
# Library         DatabaseLibrary
Library         cx_Oracle
Library           DatabaseLibrary
Library           OperatingSystem
Library           OracleDBLibrary

Resource        ../Resource/Keywords/SMIS_Common_Keywords.robot
Resource        ../Resource/Variables/SMIS_Common_Variables.robot
Resource        ../Resource/Repository/SMIS_Common_Repository.robot

*** Test Cases ***
SMIS_New_Sale_Order_001
        # [Tags]      New_Sale_Order
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การเข้าใช้งานหน้าจอ Sale Order ด้วย User role: Sale support ${\n}

        ...     TEST STEPS: 
        ...     1.เข้า URL: ******/SMIS/Form/UT_Login.aspx
        ...     2.Login ด้วย Role  Sale support
        ...     User :nutchans
        ...     Password:nutchans
        ...     3.คลิกที่เมนู Sale Order -> คลิก Sale Order List
        ...     4.กรอกข้อมูล Sale Order No>: 
        ...     5.คลิกปุ่ม Search 
        ...     6.กดปุ่ม Edit ที่ Column Manage ของเลข Order ที่เราต้องการ  ${\n}

        ...     EXPECTED RESULT: 
        ...     ระบบแสดงหน้าจอ Sale Order Management  ${\n}

        Open web SMIS and user login :  ${user_nutchans_RoleSalesupport}    
        Click Execute Javascript :  ${Menu_Sale_Order}
        Click Element :  ${subMenu_SaleOrderList}
        Generate Order Service
        Get File Text :  NEW_OrderNo
        Input Text :  ${input_orderNo}  ${orderNo}
        Click Element :  ${Search_btn}
        Click Element :  ${edit_btn}
        Validate List Data And Should Be Visible :  ${list_Sale_Order_Management}

SMIS_New_Sale_Order_002
        # [Tags]      New_Sale_Order
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Update Status Sale Order ${\n}

        ...     TEST STEPS: 
        ...     1.เปลี่ยน Status ให้เป็น Confirm
        ...     2.คลืกปุ่ม Save
        ...     3.คลิกปุ่ม OK ที่ PopUp   ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงหน้าจอSale Order List และ   Status เอกสาร = Confirm
        ...     - สามารถดำเนินการขั้นตอนสร้าง Contract ได้  ${\n}

        # Open web SMIS and user login :  ${user_nutchans_RoleSalesupport}    
        # Click Execute Javascript :  ${Menu_Sale_Order}
        # Click Element :  ${subMenu_SaleOrderList}
        # Generate Order Service
        # Get File Text :  NEW_OrderNo
        # Input Text :  ${input_orderNo}  ${orderNo}
        # Click Element :  ${Search_btn}
        # Click Element :  ${edit_btn}
        #--------------------------------------------------------
        Scroll Height
        Click Element :  ${radio_Confirm}
        Click Element :  ${saveSaleOrder_btn}
        Click Element :  ${alert_close}
        Get Text And Should Be True :  ${loc_getStatus}   Confirm
        # Logout

New_Contract_001
        # [Tags]      New_Contract
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การเข้าใช้งานหน้าจอ Contract Manage  ${\n}

        ...     TEST STEPS: 
        ...     1.เข้า URL:******/SMIS/Form/UT_Login.aspx
        ...     2.Login ด้วย Role  Sale support
        ...         User :nutchans
        ...         Password:nutchans
        ...     3. คลิกที่เมนู Sale Order -> คลิก Sale Order List
        ...     4.กรอกข้อมูล Sale Order No: ที่ได้สร้างมาจาก Case ด้านบน
        ...     5.คลิกปุ่ม Search 
        ...     6. เลือกเครื่องหมาย √ เพื่อสร้าง Contract   ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงหน้า Contract Management ที่ฝั่ง  ${\n}

        # Open web SMIS and user login :  ${user_nutchans_RoleSalesupport}    
        # Click Execute Javascript :  ${Menu_Sale_Order}
        # Click Element :  ${subMenu_SaleOrderList}
        Get File Text :  NEW_OrderNo
        Input Text :  ${input_orderNo}  ${orderNo}
        Click Element :  ${Search_btn}
        #---------------------------------------------------------------
        Click Element :  ${correct_btn}
        Validate List Data And Should Be Visible :  ${list_Contract Management}

New_Contract_002
        # [Tags]      New_Contract
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การสร้าง Create Contract  ${\n}

        ...     TEST STEPS: 
        ...     1.กรอกข้อมูล วันที่ลูกค้าลงนามในข้อตกลงและเงื่อนไข :
        ...     2. เปลี่ยน status ให้เป็น On Contract
        ...     3 กด Save
        ...     4.คลิกปุ่ม OK ที่ Popup Success  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ได้เอกสาร Contract 
        ...     - Status On Contract และสามารถนำสร้าง Attacnment ได้  ${\n}
        
        # Open web SMIS and user login :  ${user_nutchans_RoleSalesupport}    
        # Click Execute Javascript :  ${Menu_Sale_Order}
        # Click Element :  ${subMenu_SaleOrderList}
        # Get File Text :  NEW_OrderNo
        # Input Text :  ${input_orderNo}  ${orderNo}
        # Click Element :  ${Search_btn}
        #---------------------------------------------------------------
        Gen Current Date
        Input Text :   ${Calandar}      ${ContractSigningDate}
        Click Element :  ${Status_dropdown}
        Click Element javascript  ${OncontractStatus}
        Wait Until Element Is Visible  ${check_On_Contract}  30s
        Click Element  ${Save_btn}
        Wait Until Element Is Visible  ${popup_btn_ok}  240s
        Click Element :  ${popup_btn_ok}
        Close Browser
        
New_Attachment_001
        # [Tags]      New_Attachment
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การเข้าใช้งานหน้าจอ Attachment Manage Contract Phone  ${\n}

        ...     TEST STEPS: 
        ...     1.เข้า URL:******/SMIS/Form/UT_Login.aspx
        ...     2.Login ด้วย Role  Sale support
        ...     User :nutchans
        ...     Password:nutchans
        ...     3.คลิกที่เมนู Contract -> คลิก Contract List
        ...     4.กรอกข้อมูล Quotation No. :QUO-20224-220901 : ที่ได้สร้างมาจาก SMT
        ...     5.คลิกปุ่ม Search
        ...     6.คลิกเครื่องหมาย +  เพื่อสร้าง Attachment  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงหน้าจอ Manage Attachment Contract - Contract Phone - Sudkum - P1 ${\n}
    
        Open web SMIS and user login :  ${user_nutchans_RoleSalesupport}    
        Click Execute Javascript :  ${Contract_menu}
        Click Element :  ${Contract_list_menu}
        Get File Text :  NEW_QuotationNo
        Input Text :  ${input_Quotation_No}  ${QuotationNo}
        Click Element :  ${Search_btn}
        #---------------------------------------------------------------
        Click Element :  ${CreateAttachment_btn}
        Validate List Data And Should Be Visible :  ${list_Manage_Attachment}
        #---------------------------------------------------------------
        # # # # # # # # # # # #  Case Retest 
        # Click Element :  ${plus_btn}
        # Click Element :  ${edit_attachment}
        # # # # # # # # # # # #
        #---------------------------------------------------------------
        Get Contract No

New_Attachment_002
        # [Tags]      New_Attachment
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การเข้าใช้งานหน้าจอ Attachment Manage Contract Phone  ${\n}

        ...     TEST STEPS: 
        ...     1.คลิกปุ่ม Save 
        ...     2.คลิกปุ่ม Export กรอกข้อมูล ใน File Excel
        ...        - หมายเลขโทรศัพท์เคลื่อนที่ 10 ตัวอักษร
        ...     3.กดปุ่ม Save
        # ...     4.คลิกเครื่องหมายถูกที่ Record Already !  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงหน้า Manage Attachment Contract - Contract Phone - Sudkum - P1 
        ...     - แสดง Attachment No. ที่มี  Status = Open  ${\n}
    
        # Click Save Attchment
        Click Element :   ${Save_Attach_btn}
        # Wait Until Page Contains Element    ${Popup_ok}
        Click Element :   ${alert_close}
        # Wait Until Keyword Succeeds     3m  30s    Click element      ${Popup_ok}
       
New_Attachment_003
        # [Tags]      New_Attachment
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Export ข้อมูล  ${\n}

        ...     TEST STEPS: 
        ...     1.คลิกปุ่ม Export  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดง File Excel เพื่อใช้ในการ Import ข้อมูล  ${\n}

        Click Export File Excel And Verify File Name : ContractAttachment

New_Attachment_004
        # [Tags]      New_Attachment
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Import ข้อมูล  ${\n}

        ...     TEST STEPS: 
        ...     1. กรอกข้อมูล ใน File Excel
        ...        - หมายเลขโทรศัพท์เคลื่อนที่ 10 ตัวอักษร
        ...     2.คลิกปุ่ม Import
        ...     3.คลิกปุ่ม Choose File  เลือกไฟล์ที่เตรียมไว้
        ...     4.คลิกปุ่ม SAVE
        ...     5.คลิกเครื่องหมาย ถูกที่ Popup  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบจะนำข้อมูลใน File Excel มาแสดงข้อมูลในตารางแสดงข้อมูล   ${\n}

        Click Element :  ${btn_ImportNumber} 
        Contract_Import

New_Attachment_005
        # [Tags]      New_Attachment
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Update ข้อมูล  ${\n}

        ...     TEST STEPS: 
        ...     1.คลิกปุ่ม Update 
        ...     2.ระบุข้อมูล
        ...      - * No. From :1
        ...      - * No. To:2
        ...     -กรอกข้อมูล Promotion/Package Name : Call 400 min Pay 850B 
        ...     - คลิกปุ่ม Search
        ...     - คลิก DDL: Promotion/Package Name  เลือก Promotion 
        ...     3.คลิกปุ่ม SAVE  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบจะนำข้อมูลมาแสดงข้อมูลในตารางแสดงข้อมูล    ${\n}

        Sleep  2s
        Click Element :   ${update_btn}
        Sleep   2s
        ${excludes} =	Get Window Handles
        Wait Until Keyword Succeeds  10s  2s  Select frame  //iframe[contains(@frameborder,'0')]
        Input Text :  ${input_NoFrom}   ${1}
        Input Text :  ${Input_NoTo}     ${2}
        Input Text :  ${Input_Promption}   ${promation_name}
        Click Execute Javascript :  ${Search_Pro}
        # Click Element :  ${List_pakage}
        sleep  2s
        Select From List by Value   ${dropdown_promorion}   ${Value}
        Sleep   2s
        Click Element :  ${save_import}
        # Update Data
        Validate List Data And Should Be Visible :  ${list_Promotion_detail}

New_Attachment_006
        # [Tags]      New_Attachment
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Update ข้อมูล Attachment  ${\n}

        ...     TEST STEPS: 
        ...     1.คลิกปุ่ม SAVE
        ...     2.คลิกเครื่องหมายถูกที่ Record Already !  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบจะ Update ข้อมูล Attachment ที่ทำการ Import และ Update    ${\n}

        # Click Save Attchment
        Click Element :  ${Save_Attach_btn}
        Click Element :  ${alert_close} 
        Logout

Request_SIM_Management_001
        # [Tags]      Request_SIM_Management
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การเข้าใช้งานหน้าจอ Request_SIM_Management  ${\n}

        ...     TEST STEPS: 
        ...             ...     1.เข้า URL:******/SMIS/Form/UT_Login.aspx
        ...     2.Login ด้วย Role  Sale support
        ...     User :nutchans
        ...     Password:nutchans
        ...     3.คลิกที่เมนู Contract -> คลิก Contract List
        ...     4.กรอกข้อมูล Quotation No. :QUO-20224-220901 : ที่ได้สร้างมาจาก SMT
        ...     5.คลิกปุ่ม Search 
        ...     6.คลิกเครื่องหมาย + ตารางแสดงข้อมูล เพื่อให้แสดงตารางข้อมูล Attachment
        ...     7.คลิกปุ่ม Edit ที่ Column Manage ของ Attachment ที่อยู่ภายใต้ Contract List ที่ต้องการ Request SIM
        ...     7.คลิกปุ่ม Request SIM ที่หน้า Attachment
        ...     8.คลิกเลือก Radio Button : Warehouse 
        ...     9.กดปุ่ม Submit  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงหน้าจอ Request_SIM_Management - Warehouse    ${\n}

        Open web SMIS and user login :  ${user_nutchans_RoleSalesupport}    
        Click Execute Javascript :  ${Contract_menu}
        Click Element :  ${Contract_list_menu}
        Get File Text :  NEW_QuotationNo
        Input Text :  ${input_Quotation_No}  ${QuotationNo}
        Click Element :  ${Search_btn}
        #---------------------------------------------------------------
        Click Element :  ${plus_btn}
        Click Execute Javascript :  ${edit_attachment}
        Click Element :  ${requestSIM_btn}
        Requset SIM

Request_SIM_Management_002
        # [Tags]      Request_SIM_Management
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Export  ข้อมูล Excel   ${\n}

        ...     TEST STEPS: 
        ...     1. คลิกปุ่ม Export   ${\n}
        ...     2.คลิกปุ่ม Browse
        ...     3.เลือก Fileที่เตรียมข้อมูล 
        ...     4.คลิกปุ่ม Add  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดง File Excel 
        ...     - กรอกข้อมูล ใน File Excel     
        ...     - ระบบจะนำข้อมูลใน File Excel มาแสดงข้อมูลในตารางแสดงข้อมูล   ${\n}

        Click Export File Excel And Verify File Name : Request SIM
        ChooseFile  ${browse_file_btn}   ${path_ExceleditFile}
        Wait Until Element Is Enabled   ${check_file_upload}
        Click Element :  ${Add_btn}
        Wait Until Element Is Enabled   ${check_upload_progress}

Request_SIM_Management_003
        # [Tags]      Request_SIM_Management
        [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Comfirm การทำรายการ   ${\n}

        ...     TEST STEPS: 
        ...     คลิกปุ่ม Submit
        ...     บันทึกข้อมูล   ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดง Popup 'Confirmation แสดงจำนวน Main SIM และ Multi SIM เพื่อยืนยันการทำรายการ   ${\n}
        ...     - ระบบแสดง Popup Success : บันทึกข้อมูลเรียบร้อยแล้ว
        ...     - Order Request No. : WS2022000011
        ...     - Total Request SIM : 3     ${\n}

        Click Execute Javascript :  ${btn_Submit} 
        Capture Page Screenshot
        Click Execute Javascript :  ${popup_btn_ok}
        Sleep  4s
        Wait Until Element Is Enabled   ${text_success}   120s
        Click Execute Javascript :  ${popup_btn_ok}

Delivery_Managenet_001
        [Tags]      Delivery_Managenet
        # [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การเข้าใช้งานหน้าจอ Delivery Managenet   ${\n}

        ...     TEST STEPS: 
        ...     1.เข้า URL:******/SMIS/Form/UT_Login.aspx
        ...     2. Login ด้วย Role Sale Support : NUTCHANS
        ...     3. เมนู Corporate Selling Management
        ...     4. เมนู Contract Phone > Delivery Management
        ...     5.กรอก Contract No ที่ต้องการ:C2022/000409
        ...     6.กดปุ่ม Search 
        ...     7. คลิกปุ่ม Choose ที่ Column Manage  ${\n}

        ...     EXPECTED RESULT: 
        ...     ระบบแสดงหน้าจอ Delivery Mangement 
        ...     - ประกอบด้วยข้อมูล 2 ส่วน ดังนี้
        ...       -> Choose delivery location
        ...       -> Device details  ${\n}

        Open web SMIS and user login :  ${user_nutchans_RoleSalesupport}    
        Click Execute Javascript :  ${Menu_CorporateSellingManagement}
        Click Element :  ${subMenu_CorporateSellingManagement}
        Sleep  2s
        # Switch Window	NEW
        Click Element :  ${Menu_ContractPhone}
        Click Element :  ${subMenu_DeliveryManagement}
        Get File Text :  NEW_OrderNo
        Input Text :  ${Deli_SaleOrder}   ${OrderNo}
        Click Element :  ${button_Search}
        Click Element :  ${icon_Choose}
        Validate List Data And Should Be Visible :  ${list_DeliveryMangement}

Delivery_Managenet_002
        [Tags]      Delivery_Managenet
        # [Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     ส่วน Choose delivery location ครั้งที่ 1   ${\n}

        ...     TEST STEPS: 
        ...     1.กดปุ่ม Add   ${\n}

        ...     EXPECTED RESULT: 
        ...     ระบบแสดงที่อยู่ในการจัดส่งที่ตาราง Search Ship To  ${\n}

        ## Add No. 1
        Click Element :  ${btn_Add_ShipTo}
        Validate List Data And Should Be Visible :  ${list_SearchShipTo}
        
Delivery_Managenet_003
        [Tags]      Delivery_Managenet
        #[Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     ตาราง Search Ship To   ${\n}

        ...     TEST STEPS: 
        ...     1.กดปุ่ม Choose เลือกที่อยู่ที่ต้องการจัดส่ง Record ที่ 1
        ...     2.กดปุ่ม OK   ${\n}

        ...     EXPECTED RESULT: 
        ...     ระบบแสดงที่อยู่ ที่ต้องการจัดส่ง ส่วนของตาราง Choose delivery location  ${\n}

        Sleep  2s
        Click Element :  ${btn_Choose_Address}  
        Click Element :  ${btn_ShipTo_Save}
        Wait Until Element Is Visible  ${check_Page_DeliveryManagement}   120s

Delivery_Managenet_004
        [Tags]      Delivery_Managenet
        #[Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     ส่วน Device details   ${\n}

        ...     TEST STEPS: 
        ...     1.กด Choose Location  เลือกที่อยู่ในการจัดส่ง ที่ตารางส่วนของ Choose delivery location   ${\n}

        ...     EXPECTED RESULT: 
        ...     ระบบแสดงตาราง Device  Detail   ${\n}

        Click Element :  ${icon_deliveryChoose}
        Validate List Data And Should Be Visible :  ${list_panel_ManageDevice}

Delivery_Managenet_005
        [Tags]      Delivery_Managenet
        #[Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Delete Device ส่วน Add / Delete Device   ${\n}

        ...     TEST STEPS: 
        ...     1.ระบุ No form :1
        ...     2.ระบุ No To :2
        ...     3.คลิกปุ่ม Delete   ${\n}

        ...     EXPECTED RESULT: 
        ...     ระบบลบข้อมูล Device ออกจากตารางแสดงข้อมูล  Device  Detail   ${\n}

        Input Text :  ${Device_From}  ${1}
        Input Text :  ${Device_To}  ${2}
        Click Element :  ${Delete_Device}
        Wait Until Element Does Not Contain   ${check_dataInTable}     30s

Delivery_Managenet_006
        [Tags]      Delivery_Managenet
        #[Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Add Device Record ที่ 1 ส่วน Add / Delete Device   ${\n}

        ...     TEST STEPS: 
        ...     1.ระบุ No form :1
        ...     2.ระบุ No To :1
        ...     3.คลิกปุ่ม Add  ${\n}

        ...     EXPECTED RESULT: 
        ...     ระบบแสดงข้อมูล Device ตารางแสดงข้อมูล  Device  Detail   ${\n}

        Wait Loading screen Not Visible
        Input Text :  ${Device_From}  ${1}
        Input Text :  ${Device_To}  ${1}
        Click Element :  ${Add_Device}
        Wait Until Element Is Visible   ${check_data_Attachment}   120s

Delivery_Managenet_007
        [Tags]      Delivery_Managenet
        #[Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     ตรวจสอบกดปุ่ม Reserve ครั้งที่ 1   ${\n}

        ...     TEST STEPS: 
        ...     1.กด Choose Location เลือกที่อยู่ในการจัดส่ง
        ...     2.เลือก Device ที่ต้องการจัดส่ง ของแต่ละ Location
        ...     3.กดปุ่ม Reserve  ${\n}

        ...     EXPECTED RESULT: 
        ...     - สามารถทำการ Reserve Device ได้ และมีการตัด Stock ที่ ระบบ TDM   ${\n}

        Click Execute Javascript :  ${btn_Reserve}
        Wait Until Element Is Visible   ${txt_you_want_to_reserve}   120s
        Click Execute Javascript :  ${popup_btn_ok}
        sleep  2s
        Wait Until Element Is Visible   ${popup_text_success}   120s
        Click Execute Javascript :  ${popup_btn_ok}

Delivery_Managenet_008
        [Tags]      Delivery_Managenet
        #[Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     ส่วน Choose delivery location ครั้งที่ 2   ${\n}

        ...     TEST STEPS: 
        ...     1.กดปุ่ม Add  
        ...     2.เลือกที่อยู่ Record ที่ 2
        ...     3.กดปุ่ม OK  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงที่อยู่ ที่ต้องการจัดส่ง ส่วนของตาราง Choose delivery location   ${\n}

        ## Add No. 2
        Click Element :  ${btn_Add_ShipTo}
        # Wait Until Element Is Visible   ${Choose_deliverylocation}   120s
        Click Element :  ${Choose_deliverylocation}
        Click Execute Javascript :  ${btn_ShipTo_Save}
        Wait Until Element Is Visible   ${check_location_no2}   120s

Delivery_Managenet_009
        [Tags]      Delivery_Managenet
        #[Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     ส่วน Device details ครั้งที่ 2   ${\n}

        ...     TEST STEPS: 
        ...     1.กด Choose Location ที่ Record ที่ 2 เลือกที่อยู่ในการจัดส่ง ที่ตารางส่วนของ Choose delivery location  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงตาราง Device  Detail    ${\n}

        Click Element :  ${Choose_location_2}
        Validate List Data And Should Be Visible :  ${list_panel_ManageDevice}

Delivery_Managenet_010
        [Tags]      Delivery_Managenet
        #[Tags]      Regression
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     ตรวจสอบกดปุ่ม Reserve ครั้งที่ 2   ${\n}

        ...     TEST STEPS: 
        ...     1.กด Choose Location เลือกที่อยู่ในการจัดส่ง
        ...     2.เลือก Device ที่ต้องการจัดส่ง ของแต่ละ Location
        ...     3.กดปุ่ม Reserve   ${\n}

        ...     EXPECTED RESULT: 
        ...     - สามารถทำการ Reserve Device ได้ และมีการตัด Stock ที่ ระบบ TDM   ${\n}

        Click Execute Javascript :  ${btn_Reserve}
        Wait Until Element Is Visible   ${txt_you_want_to_reserve}   120s
        Click Execute Javascript :  ${popup_btn_ok}
        # Wait Loading screen Not Visible
        Wait Until Element Is Visible   ${text_success}   120s
        Click Element :  ${popup_btn_ok}

Grouping_Order_Management_001
        [Tags]      Grouping_Order_Management
        # [Tags]      Grouping_Order
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การเข้าหน้าจอ Grouping_Order_Management  ${\n}

        ...     TEST STEPS: 
        ...     1.เข้า URL:******/SMIS/Form/UT_Login.aspx
        ...     2. Login ด้วย Role Warehouset : JUTHARAJ
        ...     3. เมนู Corporate Selling Management
        ...     4.คลิกเมนู Conract Phone -> คลิกเมนู Grouping_Order_Management  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงหน้าจอ Grouping_Order_Management แสดง Record ตามที่อยู่ในการจัดส่ง   ${\n}

        Open web SMIS and user login :  ${user_JUTHARAJ_RoleWarehouset}   
        Click Execute Javascript :  ${Menu_CorporateSellingManagement}
        Click Element :  ${subMenu_CorporateSellingManagement}
        Sleep  2s
        Click Element :  ${Menu_ContractPhone}
        Click Element :  ${subMenu_GroupingOrderManagement}
        Wait Until Element Is Visible   ${GruopingManagement}   30s

Grouping_Order_Management_002
        [Tags]      Grouping_Order_Management
        # [Tags]      Grouping_Order
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การใช้งานหน้าจอ Grouping_Order_Management  ${\n}

        ...     TEST STEPS: 
        ...     1.Tick Check Box Auto Refresh ออก
        ...     2.กรอกข้อมูล Sale Order No.:
        ...     3.คลิกปุ่ม Search
        ...     4.Tick เลือก Check Box หน้า Column Manage
        ...     5.คลิกปุ่ม Grouping Order  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงหน้า Popup Confirm Grouping Order   ${\n}

        Get File Text :  NEW_OrderNo
        Input Text :  ${txt_SaleOrderNo}   ${OrderNo}
        Click Element :  ${btn_Search}
        Click Execute Javascript :  ${checkBox_AutoRefresh}
        Click Execute Javascript :  ${checkAll_GroupingOrder}
        Click Element :  ${btn_GroupingOrder}
        Validate List Data And Should Be Visible :  ${list_ConfirmGroupingOrder}

Grouping_Order_Management_003
        [Tags]      Grouping_Order_Management
        # [Tags]      Grouping_Order
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Popup Confirm Grouping Order  ${\n}

        ...     TEST STEPS: 
        ...     1.กดปุ่ม SAVE  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดง Popup Information
        ...     - แสดงข้อมูล Pick No. CCP220900034   ${\n}

        Click Element :  ${Save_btn}
        Get Text Pick No And Save data :  ${text_PickNo}
        Validate List Data And Should Be Visible :  ${list_popupInformation}

Grouping_Order_Management_004
        [Tags]      Grouping_Order_Management
        # [Tags]      Grouping_Order
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Popup Information  ${\n}

        ...     TEST STEPS: 
        ...     1.คลิก Print Pick Good  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดง PDF File 
        ...     - ระบบได้ดำเนินการ Send Mail รายการ Pick Goods ไปหาผู้ที่เกี่ยวข้อง   ${\n}

        Click Element :  ${btn_PrinPickGoods}
        Get File Text :  NEW_PickNo
        Check url PDF
        Close All Browsers

Grouping_Order_List_001
        [Tags]      Grouping_Order_List
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การเข้าใช้งานหน้าจอ Grouping Order List เพื่อทำการตรวจสอบข้อมูลการ Grouping Order  ${\n}

        ...     TEST STEPS: 
        ...     1.เข้า URL:******/SMIS/Form/UT_Login.aspx
        ...     2. Login ด้วย Role Warehouset : JUTHARAJ
        ...     3.คลิกเมนู Conract Phone -> คลิกเมนู Grouping Order List
        ...     4.Tick Check Box Auto Refresh ออก
        ...     5.กรอกข้อมูล Pick No.:
        ...     6.คลิกปุ่ม Search  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงรายการที่ต้องการ  ${\n}

        Open web SMIS and user login :  ${user_JUTHARAJ_RoleWarehouset}   
        Click Execute Javascript :  ${Menu_CorporateSellingManagement}
        Click Element :  ${subMenu_CorporateSellingManagement}
        Sleep  2s
        Click Element :  ${Menu_ContractPhone}
        Click Element :  ${subMenu_GroupingOrderList}
        Wait Until Element Is Visible   ${grid_GruopingOrderList}   30s

        Get File Text :  NEW_PickNo
        Input Text :  ${txt_PickNo}  ${PickNo}
        Click Element :  ${btn_Search}
        Validate data in table
        Click Element :  ${checkBox_AutoRefresh}

Grouping_Order_List_002
        [Tags]      Grouping_Order_List
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Export Excel File   ${\n}

        ...     TEST STEPS: 
        ...     1.คลิกปุ่ม Export File  ที่ Column    ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงข้อมูล File Excel  ${\n}

        Click Export File Excel And Verify File Name : Device

Grouping_Order_List_003
        [Tags]      Grouping_Order_List
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     PDF PickGood   ${\n}

        ...     TEST STEPS: 
        ...     1.คลิกเลข Pick No.  ที่ Column Pick No.   ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดง PDF File Pick Good  ${\n}

        # Get Pick No
        Get File Text :  NEW_PickNo
        Click Element :  //a[contains(.,'${PickNo}')]
        Check url PDF
        Update Data Receive Optimus
        Close Browser

Create_DO_Management_001
        [Tags]      Create_DO_Management
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Create DO Management จะแสดงข้อมูลให้ทำรายการเมื่อ GroupOrder มี Status = Complete  ${\n}

        ...     TEST STEPS: 
        ...     1.เข้า URL:******/SMIS/Form/UT_Login.aspx
        ...     2. Login ด้วย Role Warehouset : JUTHARAJ
        ...     3.คลิกเมนู Conract Phone -> คลิกเมนู Create DO Management
        ...     4.Tick Check Box Auto Refresh ออก
        ...     5.Tick Check Box เลือกรายการ
        ...     6.คลิกปุ่ม Create DO
        ...     7.คลิกปุ่ม OK ที่ Popup Confrim    ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดง Popup Information ยืนยันการสร้าง DO  ${\n}
        
        Open web SMIS and user login :  ${user_JUTHARAJ_RoleWarehouset}   
        Click Execute Javascript :  ${Menu_CorporateSellingManagement}
        Click Element :  ${subMenu_CorporateSellingManagement}
        Sleep  2s
        Click Element :  ${Menu_ContractPhone}
        Click Element :  ${subMenu_CreateDOManagement}
        # Wait Until Element Is Visible   ${grid_GruopingOrderList}   30s

        Get File Text :  NEW_OrderNo
        Input Text :  ${input_SaleOrderNo}  ${orderNo}
        Click Element :  ${btn_Search}
        Click Element :  ${checkBox_AutoRefresh}
        Click Element :  ${CheckAll}
        Click Execute Javascript :  ${btn_CreateDO}
        Wait Until Element Is Visible  ${popup_detail_Confirmation}   120
        Click Element :  ${popup_btn_ok}

Create_DO_Management_002
        [Tags]      Create_DO_Management
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Popup Information  ${\n}

        ...     TEST STEPS: 
        ...     1,คลิกปุ่ม Print DO   ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบจะแสดงข้อมูล File  PDFCreateDO  ${\n}

        Click Element :  ${btn_PrintDO}
        Sleep  2s
        Capture Page Screenshot

Cancel_Reprint_DO_Management_001
        [Tags]      Cancel_DO_Management
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     การเข้าใช้งานหน้าจอ Cancel / Reprint DO Management  ${\n}

        ...     TEST STEPS: 
        ...     1.เข้า URL:******/SMIS/Form/UT_Login.aspx
        ...     2. Login ด้วย Role Warehouset : JUTHARAJ
        ...     3.คลิกเมนู Conract Phone -> คลิกเมนู Create DO Management  ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดงหน้าจอ Cancel / Reprint DO Management  ${\n}

        Open web SMIS and user login :  ${user_JUTHARAJ_RoleWarehouset}   
        Click Execute Javascript :  ${Menu_CorporateSellingManagement}
        Click Element :  ${subMenu_CorporateSellingManagement}
        Sleep  2s
        Click Element :  ${Menu_ContractPhone}
        Click Element :  ${subMenu_CancelReprintDOManagement}
        Wait Until Element Is Visible   ${grid_DetailCancelDO}   30s

Cancel_Reprint_DO_Management_002
        [Tags]      Cancel_DO_Management
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Print Do   ${\n}

        ...     TEST STEPS: 
        ...     1.Tick Check Box Auto Refresh ออก
        ...     2.Tick Check Box เลือกรายการ
        ...     3.คลิกปุ่ม Print Do   ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบแสดง PDF File ใบจัดสินค้า Contract Phone ${\n}

        Click Element :  ${checkBox_AutoRefresh}
        Click Element :  ${CheckAll}
        Click Element :  ${PrintDO_btn} 
        Sleep  2s
        Capture Page Screenshot

Cancel_Reprint_DO_Management_003
        [Tags]      Cancel_DO_Management
        [Documentation]
        ...     TEST DESCRIPTION:  
        ...     Cancel Do    ${\n}

        ...     TEST STEPS: 
        ...     1.Tick Check Box Auto Refresh ออก
        ...     2.Tick Check Box เลือกรายการ
        ...     3.คลิกปุ่ม Cancel Do 
        ...     4.คลิกปุ่ม OK ที่ Popup Confrim Cancel DO
        ...     5.คลิกปุ่ม OK ที่ Popup Success   ${\n}

        ...     EXPECTED RESULT: 
        ...     - ระบบทำการ Cancel การออก Do  ${\n}

        Click Execute Javascript :  ${Cancel_DO}
        Click Execute Javascript :  ${popup_btn_ok}
        Close Browser





