*** Settings ***
Documentation     Login Test Suite
Library           Browser
Library           Collections
Resource          ../../../Resources/Common/common_kw.robot
Resource          ../../../Resources/Browser/ManageBrowser.robot
Resource          ../../../Resources/UI/login_kw.robot
Suite Setup       Setup Automation UI

*** Variables ***
${BROWSER}        chrome
${URL}            https://example.com
${TIMEOUT}        10s
${GENERIC_NAME}   Marcelo Portfolio
${GENERIC_WRONG_PASSWORD}    notarealpassword

*** Test Cases ***

Scenario 0 > Create An Account In The Website
    [Documentation]
    [Tags]
    Go to the website page
    Go To The Login Page
    ${random_email_user} =     Generate Random Email
    Input Registration Name Credential            ${GENERIC_NAME}
    Input Registration Email Credential           ${random_email_user}
    Click On Registration Register Button
    Enter Account Information
    Enter Address Information
    Delete Account

Scenario 1 > Register User with existing email
    [Documentation]
    [Tags]    fail
    Go to the website page
    Go To The Login Page
    Input Registration Name Credential    ${USER_NAME}
    Input Registration Email Credential   ${USER_USERNAME}
    Click On Registration Register Button
    Validate Existing Email Message
    
Scenario 2 > Login with valid credentials
    [Documentation]    Test scenario description
    [Tags]             smoke    login
    Go to the website page
    Go To The Login Page
    Input The Email "${USER_USERNAME}" in the field
    Input The Password "${USER_PASSWORD}" in the field
    Logout From The Application

Scenario 3 > Login With Invalid Credentials
    [Documentation]    Test scenario description
    [Tags]             smoke    login
    Go to the website page
    Go To The Login Page
    Input The Email "${USER_USERNAME}" in the field
    Input The Password "${GENERIC_WRONG_PASSWORD}" in the field


