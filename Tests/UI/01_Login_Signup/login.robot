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

*** Test Cases ***
Scenario 1 > Login with valid credentials
    [Documentation]    Test scenario description
    [Tags]             smoke    login
    Go to the website page
    Go To The Login Page
    Input The Email "${USER_USERNAME}" in the field
    Input The Password "${USER_PASSWORD}" in the field

