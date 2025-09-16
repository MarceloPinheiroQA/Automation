*** Settings ***
Documentation     
Library           JsonLibrary
Resource          ${CURDIR}/../Browser/ManageBrowser.robot

*** Variables ***
${USERNAME_FIELD}        data-qa=login-email
${PASSWORD_FIELD}        data-qa=login-password


*** Keywords ***

Setup Automation UI
    Load Configuration
    Create Browser With Context
    
Load Configuration
    Set Suite Variable    ${URL}                ${LOGIN_CONFIG}[url]
    Set Suite Variable    ${USER_USERNAME}      ${LOGIN_CONFIG}[username]
    Set Suite Variable    ${USER_PASSWORD}      ${LOGIN_CONFIG}[password]

Login in the application
    [Arguments]    ${username}    ${password}
    Go To        ${LOGIN_URL}
    Fill Text    ${USERNAME_FIELD}    ${username}
    Fill Text    ${PASSWORD_FIELD}    ${password}
    Click        ${LOGIN_BUTTON}
