*** Settings ***
Documentation     
Resource          ../Common/common_kw.robot
Resource          ../Browser/ManageBrowser.robot    
Resource          ../UI/login_po.robot

*** Variables ***

*** Keywords ***
Go to the website page
    Go To    ${URL}
Go To The Login Page
    Click    ${login_page}
Input The Email "${VAR_USER_USERNAME}" in the field
    Fill Text    ${login_email}    ${VAR_USER_USERNAME}   
Input The Password "${VAR_USER_PASSWORD}" in the field
    Fill Text    ${login_password}    ${VAR_USER_PASSWORD}  
Click On Login Button
    Click    ${login_button}

