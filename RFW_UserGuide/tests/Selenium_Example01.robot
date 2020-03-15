*** Settings ***
Library    SeleniumLibrary    
Suite Setup    Log    I am inside Test Suite Setup
Suite Teardown    Log    I am inside Test Suite Teardown
Test Setup    Log    I am inside Test Setup
Test Teardown    Log    I am inside Test Teardown

*** Variables ***
${url}    https://opensource-demo.orangehrmlive.com
@{CREDENTIALS}    Admin    admin123
&{LOGINDATA}    username=Admin    password=admin123



*** Test Cases ***

FirstSeleniumTest
    Open Browser    https://google.com    chrome
    Set Browser Implicit Wait    30
    Input Text    name=q    Automation step by step    
    Press Keys    name=q    ENTER
    Sleep    30    
    Close Browser
    Log    Test Completed    
    
SampleLoginTest
    [Documentation]    This is sample login test
    Open Browser    https://opensource-demo.orangehrmlive.com    chrome
    Set Browser Implicit Wait    30
    Input Text    id=txtUsername    Admin    
    Input Password    id=txtPassword    admin123    
    Click Button    id=btnLogin
    Sleep    30        
    Click Element    id=welcome
    Sleep    30        
    Click Element    link=Logout    
    Close Browser
    Log    Test Completed    
    
SampleUsingVars1
    [Documentation]    This is sample login test using variables "LIST"
    Open Browser    ${url}    chrome
    Set Browser Implicit Wait    30
    Input Text    id=txtUsername    ${CREDENTIALS}[0]        
    Input Password    id=txtPassword    ${CREDENTIALS}[1]        
    Click Button    id=btnLogin
    Sleep    30        
    Click Element    id=welcome
    Sleep    30
    Click Element    link=Logout
    Close Browser
    Log    Test Completed

SampleUsingVars2
    [Documentation]    This is sample login test using variables "DICT"
    Open Browser    ${url}    chrome
    Set Browser Implicit Wait    30
    Input Text    id=txtUsername    ${LOGINDATA}[username]    
    Input Password    id=txtPassword    ${LOGINDATA}[password]    
    Click Button    id=btnLogin
    Sleep    30        
    Click Element    id=welcome
    Sleep    30
    Click Element    link=Logout
    Close Browser
    Log    Test Completed
   
SampleUsingKWs
    [Documentation]    This is sample login test using variables "KeyWords"
    Open Browser    ${url}    chrome
    Set Browser Implicit Wait    30
    Login KW    
    Click Element    id=welcome
    Sleep    30
    Click Element    link=Logout
    Close Browser
    Log    Test Completed
    
*** Keywords ***
Login KW
    Input Text    id=txtUsername    @{CREDENTIALS}[0]    
    Input Password    id=txtPassword    @{CREDENTIALS}[1]    
    Click Button    id=btnLogin
    Sleep    30    
