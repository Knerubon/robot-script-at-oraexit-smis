*** Settings ***
Library     Selenium2Library
Library     BuiltIn
Library     String
Library     Collections
Library     OperatingSystem
Library     DateTime
Library     ExcelLibrary
Library     XML
Library     JSONLibrary
Library     RequestsLibrary
Library    SoapLibrary

Resource        ../../Resource/Repository/SMIS_Common_Repository.robot
Resource        ../../Resource/Variables/SMIS_Common_Variables.robot

*** Keywords ***

Open Browser Chrome
    [Arguments]  ${_url} 
     ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
     ${disabled}    Create List    Chrome PDF Viewer
     # set  download default
     ${prefs} =    create dictionary    download.prompt_for_download=${FALSE}    download.directory_upgrade=${TRUE}    download.default_directory=${CURDIR}\\Download  safebrowsing.enabled=${TRUE}
     call method    ${CHROME_OPTIONS}    add_experimental_option    prefs    ${prefs}
     Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors  
     Create Webdriver    Chrome   chrome_options=${chrome_options} 
     Go To  ${_url}   
     Maximize Browser Window

Split Data Test :
    [Arguments]   ${inputData}
    @{list_data}     Create List   ${inputData}
    log  ${list_data}
    @{Data} =    Split String      ${list_data[${0}]}      |
    log  ${Data}
    Set Test Variable  ${Data}

Login : 
    [Arguments]  ${inputUser}  ${loc_user}  ${loc_password}
    Split Data Test :  ${inputUser}
    Wait Until Element Is Visible   ${loc_user}
    Input Text  ${loc_user}  ${Data[${0}]}
    Input Text  ${loc_password}  ${Data[${1}]}
    # Wait Until Element Is Visible   ${alert_close}    45s
    Click Element :  ${btn_submitLogin}
    # Wait Until Element Is Visible  id:cboxContent
    Sleep  2s
    # Wait Until Element Is Visible   ${alert_close}    45s
    Click Execute Javascript :   ${alert_close}
    Wait Loading screen Not Visible
    
Open web SMIS and user login :
    [Arguments]    ${User_name}
    Open Browser Chrome  ${url_SMIS}
    Login :  ${User_name}  ${loc_user}  ${loc_password}

# Open web SMIS and user login :
#     [Arguments]    ${User_name}
#     Open Browser Chrome  ${url_SMIS}
#     Login :  ${User_name}  ${loc_user}  ${loc_password}

Click Element :
    [Arguments]   ${Local}
    ${status}	${value} =  Run Keyword And Ignore Error  Wait Until Element Is Visible  ${Local}
    Run Keyword If	'${status}' == 'FAIL'  Sleep  4s
    # Wait Until Page Contains Element  ${Local}  45s
    # Wait Until Element Is Visible   ${Local}  45s
    Wait Until Element Is Enabled   ${Local}  45s
    Scroll Element Into View  ${Local}
    Click Element   ${Local}
    Wait Loading screen Not Visible

Click Element And Wait Loading :
    [Arguments]   ${Local}
    ${status}	${value} =  Run Keyword And Ignore Error  Wait Until Element Is Visible  ${Local}  10s
    Run Keyword If	'${status}' == 'FAIL'  Sleep  5s
    Wait Until Page Contains Element  ${Local}  30s
    Scroll Element Into View  ${Local}
    Click Element   ${Local}
    Wait Loading screen Not Visible

Click Execute Javascript :
    [Arguments]   ${xPath}
    ${status}	${value} =  Run Keyword And Ignore Error  Wait Until Element Is Visible  ${xPath}  20s
    Run Keyword If	'${status}' == 'FAIL'  Sleep  4s
    ${ele}    Get WebElement   ${xPath}
    Scroll Element Into View   ${xPath}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 

Input Text :
    [Arguments]   ${locator}  ${inputData}
    Wait Until Element Is Visible  ${locator}   60s
    Input Text  ${locator}  ${inputData}

Validate List Data And Should Be Visible :
    [Arguments]   ${listData}  
    Set Test Variable  ${listData}
    ${Length}    Get Length   ${listData}
    FOR    ${i}    IN RANGE    ${Length}
        Log  ${listdata[${i}]}
        Wait Until Element Is Visible  ${listdata[${i}]}  120s
        Element Should Be Visible  ${listdata[${i}]}  60s
        Page Should Contain Element  ${listdata[${i}]}  120s
        Scroll Element Into View    ${listdata[${i}]}
    END

Wait Loading screen Not Visible

    ${Length}   Get Length  ${loading}
    FOR    ${i}    IN RANGE    ${Length}
        log  ${loading[${i}]}
        Run Keyword And Ignore Error  Wait Until Page Does Not Contain Element   ${loading[${i}]}  240s

    END

Edit File Excel
    Open Excel Document  ContractList*.xlsx  ${path_editFile}  # ${ExcelName}        ${excelPath}    
    Write Excel Cell  5  2  0810000010  sheet_name=Contract  # row_num, col_num, value, sheet_name=None    
    Save Excel Document  ContractList*.xlsx  # ${ExcelName}

#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------

Change Status
    Wait Until Keyword Succeeds     15s  1s     Element Should be visible   ${Checkbox_CF}
    Scroll Element Into View      ${Checkbox_CF}
    Wait Until Keyword Succeeds     10s  2s     Click element    ${Checkbox_CF}
    Scroll Element Into View        ${belowpage}
    Wait Until Keyword Succeeds     10s  2s     Click Button     ${save_btn}
    Sleep    3s
    Wait Until Keyword Succeeds     20s  2s     Click element       ${OK_popup}

Logout
    Click element :  ${Logout_btn}
    Close Browser
    
Open Browser to Loginpage
    open browser   ${SMIS_URL}     ${BROWSER}        options=add_argument("--ignore-certificate-errors")
    Maximize Browser Window

Click Element javascript
    [Arguments]     ${xpath}
    execute javascript   document.evaluate("${xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()
Search OrderNo
    Wait Until Keyword Succeeds     15s  2s     Element Should be visible    ${SaleOrder_menu}
    Wait Until Keyword Succeeds     10s  2s     click element      ${SaleOrder_menu}
    Wait Until Keyword Succeeds     10s  2s     Element Should be visible    ${SaleOrderlist_menu}
    Wait Until Keyword Succeeds     10s  2s     click element    ${SaleOrderlist_menu}
    Wait Until Keyword Succeeds     20s  2s     Element Should be visible      ${cpListEntry_txtSaleOrderNo}
    Wait Until Keyword Succeeds     10s  2s     Input Text    ${input_orderNo}      ${orderNo}
    Wait Until Keyword Succeeds     10s  2s     Click Button    ${Search_btn}
Choose Date
    # Wait Until Keyword Succeeds     10s  2s     click element    ${correct_btn}
    ${currentdate}    Get Current Date   result_format=%d/%m/%Y
    Wait Until Element Is Visible       ${Calandar}     30s
    Input Text        ${Calandar}      ${currentdate}

Click Save
    Click Element  ${Save_btn}
    Sleep   4s
    Click Element :  ${popup_ok_btn}
    
Search Quotation No
    Wait Until Element Is Visible    ${input_Quotation_No}     30s
    # Click Element :    ${Contract_menu}
    # Click Element :    ${Contract_list_menu}
    Input Text    ${input_Quotation_No}    ${Quotation_No}
    Click Element :   ${Search_btn}

Click Create Attachment
    Wait Until Element Is Visible   ${CreateAttachment_btn}     30s
    Wait Until Keyword Succeeds     10s  2s     click element   ${CreateAttachment_btn}

Input NoFrom
     [Arguments]    ${input_Nofrom}    ${inputNofrom}
    Input Text    ${input_Nofrom}       ${inputNofrom}
Input NoTo
    [Arguments]    ${input_Noto}    ${inputNoto}
    Input Text    ${input_Noto}         ${inputNoto}
Input update
    sleep   4s
    log     ${input_Nofrom}
    Wait Until Keyword Succeeds     10s     2s      element should be visible   ${input_Nofrom}
    Wait Until Keyword Succeeds     10s     2s      Input Text    ${input_Nofrom}     1
    Wait Until Keyword Succeeds     10s     2s      Input Text      ${input_Noto}       2

Export file
    Wait Until Keyword Succeeds     10s  2s     click element   ${Plus_btn}      #กดปุ่ม+เพื่อแสดง submenu addAttachment
    Wait Until Keyword Succeeds     10s  2s     click element   ${edit_attachment}  #กดปุ่ม edit Attachment
    Wait Until Keyword Succeeds     10s  2s     click element   ${Export_btn}

Gen Current Date
    ${getdate} =  Get Current Date
    ${genDataDate} =  Convert Date  ${getdate}  result_format=%Y%m%d%H%M%S
    ${Date_today} =  Convert Date  ${getdate}  result_format=%y%m%d
    ${Date_Time} =  Convert Date  ${getdate}  result_format=%H%M
    ${ContractSigningDate} =  Convert Date  ${getdate}   result_format=%d/%m/%Y
    # ${} =  Convert Date  ${getdate}  result_format=%Y%m%d%H%M%S
    
    # Log To Console   Time=${genDataDate_t}
    # Set Test Variable    ${gen_Time}
    Set Test Variable    ${genDataDate}
    Set Test Variable    ${Date_today}
    Set Test Variable    ${Date_Time}
    Set Test Variable    ${ContractSigningDate}

Inputnumber to excel
    ${Excel_name}    Set Global Variable     ${file_name}
    Open Excel Document    ${file_name}       D:\robot\TestRobot\ProjectQA    # ${ExcelName}        ${excelPath}
    Write Excel Cell    10  2  Test in put   sheet_name=Test    # row_num, col_num, value, sheet_name=None
    Save Excel Document   dataRegister.xlsx    # ${ExcelName}


Search Contractno
     Wait Until Keyword Succeeds     10s  2s     click element       ${coparate_menu}
    Wait Until Keyword Succeeds     15s  2s     click element       //*[@id="175"]/span/a
    Wait Until Keyword Succeeds     30s  10s     click element       ${contactphone}
    Wait Until Keyword Succeeds     10s  2s     click element       ${delivery_menu}
    Wait Until Keyword Succeeds     10s  2s     click element       //*[@id="GridUpdateReserveStock_SearchCriteria"]/div[1]/div[4]/span/span/span[1]
    Wait Until Keyword Succeeds     10s  2s     click element       //*[@id="ddlStatus_listbox"]/li[1]
    input text        ${search_contract}        ${contractNo}
    click element       ${search_btn}
Choose
    Wait Until Keyword Succeeds     35s   5s     Element Should Be Visible      ${choose_btn}
    Wait Until Keyword Succeeds     10s  5s     click element       ${choose_btn}
Add Location 1
    Wait Until Keyword Succeeds     10s  2s     click element   ${Add_btn}     #ปุ่ม add
    Wait Until Keyword Succeeds     10s  2s     click element   //*[@id="GridSearchShipTo"]/div[3]/table/tbody/tr[1]/td[1]/a
    Wait Until Keyword Succeeds     10s  2s     click element   //a[@id="btnShipToSave"]
    Wait Until Keyword Succeeds     10s  2s     click element   //*[@id="GridDelivery"]/div[3]/table/tbody/tr/td[1]/a[1]
    Wait Until Keyword Succeeds     6s   3s      input text      ${input_form}        1
    Wait Until Keyword Succeeds     6s   3s      input text      ${input_to}         2
    click element   ${Del_record}
    Sleep   2s
    Wait Until Keyword Succeeds     15s   2s      Input text         ${input_form}         1
    Wait Until Keyword Succeeds     10s   2s      Input text         ${input_to}          1
    Wait Until Keyword Succeeds     6s    3s      click element       ${Add_record}
    Sleep   2s
    Wait Until Keyword Succeeds     10s   2s     Element Should Be Visible       ${reserve_btn}
    Wait Until Keyword Succeeds     10s   2s     click element       ${reserve_btn}
    sleep    2s
    Wait Until Keyword Succeeds     10s   2s     click element          ${ok_popup}
    Wait Until Keyword Succeeds     20s   1s     click element         ${ok_popup_save}
Add Location 2
    Wait Until Keyword Succeeds     35s   5s     Element Should Be Visible      ${Add_btn}
    Sleep   3s
    Wait Until Keyword Succeeds     15s   2s     click element       ${Add_btn}
    Wait Until Keyword Succeeds     15s   2s     click element       ${2nd_Address}
    Wait Until Keyword Succeeds     15s   2s     click element          ${ok_btn}
    Wait Until Keyword Succeeds     15s   2s     Element Should Be Visible      ${Choose_Lo2}
    Wait Until Keyword Succeeds     15s   2s     click element      ${Choose_Lo2}
    Wait Until Keyword Succeeds     10s   2s     click element       ${reserve_btn}
    Wait Until Keyword Succeeds     10s   5s     click element          ${ok_popup}
    Wait Until Keyword Succeeds     10s   5s     Element Should Be Visible  ${ok_popup_save}
    Wait Until Keyword Succeeds     10s   5s     click element         ${ok_popup_save}

Group order Menu
    Wait Until Keyword Succeeds     10s  2s     Element Should Be Visible       ${contractPH_menu}
    Wait Until Keyword Succeeds     20s  2s     click element   ${contractPH_menu}
    Wait Until Keyword Succeeds     10s  2s     click element   ${Group_order_menu}

Group Order
    Wait Until Keyword Succeeds     10s  2s     click element       ${checkbox_autorefresh}
    Wait Until Keyword Succeeds     10s  2s     Element Should Be Visible       ${Choose_all}
    Wait Until Keyword Succeeds     10s  2s     click element       ${Choose_all}
    Wait Until Keyword Succeeds     10s  2s     click element       ${Group_order_btn}
    Wait Until Keyword Succeeds     10s  5s     click element       ${save_btn}
    Sleep   2s
    Wait Until Keyword Succeeds     10s  2s     Element Should Be Visible       ${Information}
    ${test}     Get Text        //*[@id="divPickNo"]
    Wait Until Keyword Succeeds     10s  5s     click element       ${print_picking}
    Wait Until Keyword Succeeds     20s  5s     click element       ${OK_popup}
    Wait Until Keyword Succeeds     10s  2s     Element Should Be Visible       ${success_popup}

Print and Cancel
    Wait Until Keyword Succeeds     10s  2s     Element Should Be Visible       ${contractPH_menu}
    Wait Until Keyword Succeeds     10s  5s     click element       ${contractPH_menu}
    Wait Until Keyword Succeeds     10s  5s     click element       ${Cancel_RP_menu}
    Wait Until Keyword Succeeds     10s  5s     click element       ${AutoRefresh_CB}
    Wait Until Keyword Succeeds     10s  5s     click element       ${CheckAll}
    Wait Until Keyword Succeeds     10s  5s     click element       ${PrintDO_btn}
    Location Should Be      ${Print_DO_File}
    Wait Until Keyword Succeeds     10s  5s     click element       ${Cancel_DO}
    Wait Until Keyword Succeeds     10s  5s     click element       ${OK_popup}
    Wait Until Keyword Succeeds     10s  5s     Element Should Be Visible   ${ok}
    Wait Until Keyword Succeeds     10s  5s     click element       ${ok}
    Wait Until Keyword Succeeds     10s  5s     click element       ${ok}
Create DO
    Wait Until Keyword Succeeds     10s  2s     Element Should Be Visible       ${contractPH_menu}
    Wait Until Keyword Succeeds     10s  5s     click element       ${contractPH_menu}
    Wait Until Keyword Succeeds     10s  5s     click element       ${CreateDO_menu}
    Wait Until Keyword Succeeds     10s  5s     click element       ${AutoRefresh_CB}
    Wait Until Keyword Succeeds     10s  5s     click element       ${CheckAll}
    Wait Until Keyword Succeeds     10s  5s     click element       ${Create_DO_Btn}
    Wait Until Keyword Succeeds     10s  5s     click element       ${OK_popup}
    Wait Until Keyword Succeeds     10s  2s     Element Should Be Visible       ${Popup_sucess}
    Wait Until Keyword Succeeds     15s  5s     click element       ${PrintDO}
    Location Should Be      ${AfterCreateDO}

Requset SIM
    Wait Until Keyword Succeeds     10s  2s     Element Should Be Visible       ${CB_warhouse}
    Wait Until Keyword Succeeds     10s  2s     click element       ${CB_warhouse}    #checkbox Warehouse
    Wait Until Keyword Succeeds     15s  2s     Element Should Be Visible         ${submit_btn}
    Wait Until Keyword Succeeds     15s  2s     click element     ${submit_btn}   #กดปุ่มsubmit

Creat Order
    ${header}=     Create Dictionary      Content-Type=text/soap+xml;    SOAPAction=http://******/IGenerateOrderService/GenerateOrder
    Create Session      APICreateOrderSMIS      ${url}       verify=False     headers=${header}
    ${XML}    get file      ${XML_Path}
    ${bytes} =  Encode String To Bytes  ${XML}   ASCII   errors=ignore
    ${resp}=    Post On Session     APICreateOrderSMIS     /CPSM/GenerateOrderService.svc?wsdl   data=${bytes}
    [Return]        ${resp}

Contract_Export
    # Open SMIS
    Login SMIS
    Search Quotation No
    Wait Until Keyword Succeeds     10s  2s     click element   ${Plus_btn}     #กดปุ่ม+เพื่อแสดง submenu addAttachment
    Wait Until Keyword Succeeds     10s  2s     click element   ${edit_attachment}  #กดปุ่ม edit Attachment
    Wait Until Keyword Succeeds     10s  2s     click element   ${Export_btn}

click Submit
    wait until keyword succeeds     10s     5s          click element       ${popup_ok}
    #wait until keyword succeeds     10s     5s          click element       ${success_ok}
    wait until keyword succeeds     10s     5s          click element       ${popup_success}

RequestSIM
    # Open SMIS
    Login SMIS
    Search Quotation No
    RequsetSIM
    sleep    2s
    Wait Until Keyword Succeeds     15s  2s     click element       ${exportfile_btn}

Step Create Order
       Set Global Variable     ${XML_Path}
       Creat Order
       

TC3_NewAttachment
      Login SMIS
      Search Quotation No
      sleep     4s
      Click Create Attachment
      Click Save Attchment

Test Upload File
    Open Browser      https://******/    Chrome
    Upload file
    Check File Display On Queue

Upload file
    Wait Until Page Contains Element   ${btnSelectWordfile}
    Choose File     ${btnSelectWordfile}     ${imgFile}Check File Display On Queue
    Wait Until Element Is Visible    ${titleFileOnQueue}

Update
    # Open SMIS
    Login SMIS
    Search Quotation No
    Sleep   5s
    Click Update
    Sleep   4s
    Update Data

NewContact
    Open Browser to Loginpage
    Login SMIS
    Search OrderNo
    sleep   2s
    Wait Until Keyword Succeeds     10s  2s     click element    ${correct_btn}

    ${currentdate}    Get Current Date   result_format=%d/%m/%Y
    Wait Until Element Is Visible       ${Calandar}     30s
    Input Text        ${Calandar}      ${currentdate}
    click element   ${Status_dropdown}
    sleep   3s
    Wait Until Element Is Visible       ${choose_onContact}    10s
    click element   ${Status_dropdown}
    Sleep     3s
    Click Element javascript     ${OncontractStatus}
    Click Element javascript     ${Save_btn}

Click Export File Excel And Verify File Name : ContractAttachment
    Empty Directory  ${path_download}
    Empty Directory  ${path_editFile}
    sleep  2s
    Wait Until Element Is Visible 	 ${btn_export_ContractAttachment}   60s
    Run Keywords
    ...  Click Element   ${btn_export_ContractAttachment}
    ...  AND  Gen Current Date
    sleep  2s
    ${file}    Wait Until Keyword Succeeds    1 min    5 sec    Download should be done    ${path_download}
    ${path_download} =    Join Path    ${path_download}    ${file_name}
    ${path_logdownload} =    Join Path    ${path_logdownload}  ${file_name}
    ${path_editFile} =    Join Path    ${path_editFile}  ${file_name}
    ${Excelpath_ContractAttachment}  Set Variable  ${path_editFile}
    Set Global Variable   ${Excelpath_ContractAttachment}           # Set Global Variable
    @{Data} =    Split String      ${file_name}      _
    sleep  4s
    Should Be True  '${Data[${0}]}' == 'ContractAttachment'
    # Should Be True  '${Data[${1}]}' == '${_today}'     # check date
    # @{Data} =    Split String      ${Data[${2}]}      .
    # ${getdata_count}=	Get Length   ${Data[${0}]}
    # Should Be True  '${Data[${0}]}' == '${today_time}'   # check time
    # Should Be True	 '${getdata_count}' == '6'
    # Move File   ${path_download}    ${path_logdownload}
    Move File   ${path_download}    ${path_editFile}
    # ${PO_Number1}    Generate random string    7    0123456789
    # ${mobile01}    Set Variable    081${PO_Number1}
    # Set Global Variable   ${mobile01}
    # ${PO_Number2}    Generate random string    7    0123456789
    # ${mobile02}    Set Variable    081${PO_Number2}
    # Set Global Variable   ${mobile02}
    # Create File  ${path_data_test}/NEW_Mobiletest.text   ${mobile01}|${mobile02}
    # Open Excel Document    ${Excelpath_ContractAttachment}     doc     # ${excelPath}${ExcelName}   
    # ## Mobile 
    # Write Excel Cell  2  5  ${mobile01}  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    # Write Excel Cell  3  5  ${mobile02}  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None    
    # Save Excel Document  ${Excelpath_ContractAttachment}   # ${ExcelName}

Click Export File Excel And Verify File Name : Request SIM
    Empty Directory  ${path_download}
    Empty Directory  ${path_editFile}
    sleep  4s
    # Switch Window	locator=MAIN
    Wait Until Element Is Visible 	 ${exportfile_btn}   60s
    Run Keywords
    ...  Click Element :   ${exportfile_btn}
    ...  AND  Gen Current Date
    sleep  2s
    ${file}    Wait Until Keyword Succeeds    1 min    5 sec    Download should be done    ${path_download}
    ${path_download} =    Join Path    ${path_download}    ${file_name}
    ${path_logdownload} =    Join Path    ${path_logdownload}  ${file_name}
    ${path_ExceleditFile} =    Join Path    ${path_editFile}  ${file_name}
    # ${path_DataExcelTest}  Set Variable  ${path_ExceleditFile}
    Set Global Variable   ${path_ExceleditFile}           # Set Global Variable
    # @{Data} =    Split String      ${file_name}      _
    # Should Be True  '${Data[${0}]}' == 'ContractAttachment'
    # Should Be True  '${Data[${1}]}' == '${_today}'     # check date
    # @{Data} =    Split String      ${Data[${2}]}      .
    # ${getdata_count}=	Get Length   ${Data[${0}]}
    # Should Be True  '${Data[${0}]}' == '${today_time}'   # check time
    # Should Be True	 '${getdata_count}' == '6'
    # Move File   ${path_download}    ${path_logdownload}
    Move File   ${path_download}    ${path_editFile}
    Sleep  2s
    # log   ${path_editFile}
    # Edit File Excel
    Open Excel Document    ${path_ExceleditFile}    doc     # ${excelPath}${ExcelName}   
    # ## Mobile 
    # Write Excel Cell  2  3  ${mobile01}  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    # Write Excel Cell  3  3  ${mobile02}  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None    
    ## ChargeType - Post-paid
    Write Excel Cell  2  4  Post-paid  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    Write Excel Cell  3  4  Post-paid  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None  
    ## SIM Type - SIM New + Number New
    Write Excel Cell  2  5  SIM New + Number New  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    Write Excel Cell  3  5  SIM New + Number New  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    ## SIM Service - Normal
    Write Excel Cell  2  6  Normal  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    Write Excel Cell  3  6  Normal  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    ## Multi SIM - 1
    Write Excel Cell  2  7  1  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    Write Excel Cell  3  7  1  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    ## จัด SIM (Y/N) - Y
    Write Excel Cell  2  13  Y  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    Write Excel Cell  3  13  Y  sheet_name=Sheet1  # row_num, col_num, value, sheet_name=None   
    Save Excel Document  ${path_ExceleditFile}  # ${ExcelName}

Click Export File Excel And Verify File Name : Device
    Empty Directory  ${path_download}
    Empty Directory  ${path_editFile}
    sleep  2s
    Wait Until Element Is Visible 	 ${icon_ExportFile}   60s
    Run Keywords
    ...  Click Element   ${icon_ExportFile}
    ...  AND  Gen Current Date
    sleep  2s
    ${file}    Wait Until Keyword Succeeds    1 min    5 sec    Download should be done    ${path_download}
    ${path_download} =    Join Path    ${path_download}    ${file_name}
    ${path_logdownload} =    Join Path    ${path_logdownload}  ${file_name}
    ${path_editFile} =    Join Path    ${path_editFile}  ${file_name}
    @{Data} =    Split String      ${file_name}      _
    sleep  4s
    Should Be True  '${Data[${0}]}' == 'Device'
    # Should Be True  '${Data[${1}]}' == '${_today}'     # check date
    # @{Data} =    Split String      ${Data[${2}]}      .
    # ${getdata_count}=	Get Length   ${Data[${0}]}
    # Should Be True  '${Data[${0}]}' == '${today_time}'   # check time
    # Should Be True	 '${getdata_count}' == '6'
    # Move File   ${path_download}    ${path_logdownload}
    Move File   ${path_download}    ${path_editFile}

Get Text And Should Be True :
    [Arguments]   ${Local}   ${Value}
    Wait Until Element Is Visible  ${Local}
    ${GetValue}   Get Text   ${Local}
    Should Be True   '${GetValue}'=='${Value}'
    Set Test Variable  ${GetValue}

Get Text Pick No And Save data :
    [Arguments]   ${Local}  
    Wait Until Element Is Visible  ${Local}
    ${GetValue}   Get Text   ${Local}
    ${Data} =    Split String      ${GetValue}      ${SPACE}
    ${PickNo}    Set Variable   ${Data[${2}]}
    Set Test Variable   ${PickNo}
    Create File  ${path_data_test}/NEW_PickNo.text   ${PickNo}



Check url PDF
    Switch Window    New
    ${location_pdf}  Get Location
    # ${Data} =    Split String      ${location_pdf}      /
    # ${Data} =    Split String      ${Data}      =
    # ${data}  Get File   ${path_data_test}/PickNo.text
    # Set Test Variable  ${PickNo}
    # Should Be True   '${GetValue}'=='ViewPDFPickGood?grpOrderNo'
    # Should Be True   '${location_pdf}'=='https://******/CPSM/CP_GroupingOrderManagement/ViewPDFPickGood?grpOrderNo=${PickNo}'
    Capture Page Screenshot

Validate data in table
    # ${data}  Get File   ${path_data_test}/PickNo.text
    Set Test Variable  ${PickNo}
    Wait Until Element Is Visible  //td[contains(.,'${PickNo}')]

Contract_Import
    Select Frame   ${Frame}
    wait until keyword succeeds      20s     10s    ChooseFile      ${choose_file_btn}       ${Excelpath_ContractAttachment}
    FOR    ${i}    IN RANGE    5
        ${status}   ${value} =  Run Keyword And Ignore Error  Get Text And Should Be True :   ${Entry_txtTotalRecord}   ${2}
        Run Keyword If	'${status}' == 'FAIL'  Sleep  2s
        Exit For Loop IF  '${status}' == 'PASS'
    END

    Click Element   ${save_import}
    Click Element :   ${alert_close}
    
Download should be done
    [Arguments]  ${path_download}
    Sleep  4s
    ${files}  List Files In Directory  ${path_download}
    Length Should Be  ${files}  1
    ${file_name}    Set Variable    ${files[${0}]}
    Set Test Variable   ${file_name}

Generate Order Service
    Empty Directory  ${path_data_test}
    Gen Current Date
    ${QuotationNo}    Set Variable    QUO-${Date_Time}0-${Date_today}
    ${SMTSaleOrderNo}   Set Variable    ORD-${Date_Time}0-${Date_today}
    Set Test Variable   ${QuotationNo}
    Set Test Variable   ${SMTSaleOrderNo}
    ${SOAP_XML}=  Get File  ${CURDIR}\\Create_Order.xml
    ${Result}=   Replace String     ${SOAP_XML}    30/01/2023        ${ContractSigningDate}
    ${Result}=   Replace String     ${Result}    QUO-00013-230130        ${QuotationNo}
    ${Result}=   Replace String     ${Result}    ORD-00013-230130        ${SMTSaleOrderNo}
    Create File  ${CURDIR}/Soap_Create_Order.xml   ${Result}
    ## Create Request 
    create session  APITEST    https://******      
    ${SOAP_XML}=  Parse XML  ${CURDIR}\\Soap_Create_Order.xml
    ${SOAP_XML}=  Element To String  ${SOAP_XML}   .   UTF-8
    ${request_header}=    create dictionary    Content-Type=text/xml; charset=utf-8   SOAPAction=http://******/IGenerateOrderService/GenerateOrder   
    ## Send the XML request body
    ${SAVE_Response}=    POST On Session    APITEST    /CPSM/GenerateOrderService.svc    headers=${request_header}    data=${SOAP_XML}
    log to console    ${SAVE_Response.status_code}
    # # log    ${SAVE_Response.headers}
    # # log    ${SAVE_Response.content}
    ${xml_Response} =  Set Variable    ${SAVE_Response.content}
    # # log  ${xml_Response}
    ${root} =	Parse XML	${xml_Response}   keep_clark_notation=yes
    ${text}  Get Element Text  ${root}  .
    ${Data} =    Split String      ${text}      true
    ${OrderNo} =  Set Variable   ${Data[${1}]}
    Set Test Variable   ${OrderNo}
    Create File  ${path_data_test}/NEW_OrderNo.text   ${OrderNo}
    Create File  ${path_data_test}/NEW_QuotationNo.text   ${QuotationNo}

Get File Text :
    [Arguments]  ${File_name}
    ${data}  Get File   ${path_data_test}/${File_name}.text
    Set Test Variable  ${data}
    Run Keyword If	'${File_name}' == 'NEW_OrderNo'   Set Variable OrderNo
    Run Keyword If	'${File_name}' == 'NEW_QuotationNo'   Set Variable QuotationNo
    Run Keyword If	'${File_name}' == 'NEW_PickNo'   Set Variable PickNo

Set Variable OrderNo 
    ${OrderNo}  Set Variable  ${data}
    Set Test Variable  ${OrderNo}

Set Variable QuotationNo 
    ${QuotationNo}  Set Variable  ${data}
    Set Test Variable  ${QuotationNo}

Set Variable PickNo 
    ${PickNo}  Set Variable  ${data}
    Set Test Variable  ${PickNo}

Get Contract No
    Wait Until Element Is Visible  ${loc_ContractNo}   160s
    Scroll Element Into View  ${loc_ContractNo}
    ${ContractNo}   Get Text   ${loc_ContractNo}
    Set Test Variable  ${ContractNo}
    Create File  ${path_data_test}/NEW_ContractNo.text   ${ContractNo}

Scroll Height
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

Wait Until Element and Should Be Visible :
    [Arguments]  ${locator}
    Wait Until Element Is Visible  ${locator}    60s
    Element Should Be Visible  ${locator}     60s

Logout CPSM
    Click Element :  ${CPSM_Logout}
    Click Element :  ${popup_ok_btn} 

Update Data Receive Optimus
    Gen Current Date
    Create Session      APIUpdateDataReceiveOptimus     ${url}       
    ${json_string}=    Load JSON From File    ${CURDIR}\\UpdateDataReceiveOptimus.json   UTF-8
    # log  ${json_string['SUBJECT']}
    # ${data_SUBJECT} =  Get Variable Value  ${json_string['SUBJECT']}
    # Set Test Variable   ${data_SUBJECT}
    ${contractNo}  Get File   ${path_data_test}/New_contractNo.text
    ${orderNo}  Get File   ${path_data_test}/NEW_OrderNo.text

    ${json_string}=	 Update Value To Json	${json_string}	 $..contractNo  ${contractNo}
    # log  ${json_string}
    ${json_string}=	 Update Value To Json	${json_string}	 $..saleOrderNo  ${orderNo}
    # log  ${json_string}
    ${json_string}   Convert Json To String   ${json_string}
    # log  ${json_string}
    ${header}=      Create Dictionary      Content-Type=application/json; charset=utf-8   
    ${resp}=    Post On Session     APIUpdateDataReceiveOptimus      /CPSM/RestAPIsService/api/UpdateDataReceiveOptimus   data=${json_string}    headers=${header}

    Log     ${resp.text}
    ${json} =  Set Variable  ${resp.json()}
    Should Be Equal  ${resp.status_code}  ${200}