*** Settings ***
Documentation     
Library           JsonLibrary
Library           String
Library           Collections
Resource          ${CURDIR}/../Browser/ManageBrowser.robot

*** Variables ***
${USERNAME_FIELD}        data-qa=login-email
${PASSWORD_FIELD}        data-qa=login-password


*** Keywords ***

Setup Automation UI
    Load Configuration
    Create Browser With Context

Setup Automation API
    Load Configuration
Load Configuration
    Set Suite Variable    ${URL}                ${LOGIN_CONFIG}[url]
    Set Suite Variable    ${USER_USERNAME}      ${LOGIN_CONFIG}[username]
    Set Suite Variable    ${USER_PASSWORD}      ${LOGIN_CONFIG}[password]
    Set Suite Variable    ${USER_NAME}          ${LOGIN_CONFIG}[name]
    Set Suite Variable    ${BASE_URL}           ${LOGIN_CONFIG}[base_url]

Login in the application
    [Arguments]    ${username}    ${password}
    Go To        ${LOGIN_URL}
    Fill Text    ${USERNAME_FIELD}    ${username}
    Fill Text    ${PASSWORD_FIELD}    ${password}
    Click        ${LOGIN_BUTTON}

Generate Random Email
    [Documentation]    Generates a random email with format: marceloportfolio[random_numbers]@test.com
    ${random_numbers}=    Generate Random String    5    [NUMBERS]
    ${random_email}=      Set Variable              marceloportfolio${random_numbers}@test.com
    RETURN            ${random_email}