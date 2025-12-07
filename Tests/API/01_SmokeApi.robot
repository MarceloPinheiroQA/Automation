*** Settings ***
Documentation     API Test Suite
Library           Browser
Library           Collections
Library           Requests
Resource          ../../Resources/Common/common_kw.robot
Resource          ../../Resources/API/SmokeAPI_kw.robot
Suite Setup       Setup Automation API
Test Tags        smokeapi
*** Variables ***


*** Test Cases ***

Scenario 1 > Get All Products List API Test
    [Documentation]    Test the products list endpoint 
    [Tags]             smokeapi
    ${response}=    Make Get Call Of "${EP_PRODUCT_LIST}" Endpoint
    Validate Response Status Is "200" And Response Body Contains "Babyhug" Text    ${response} 

Scenario 2 > Verify Search Product POST API Test
    [Documentation]    Test the search product endpoint 
    [Tags]             smokeapi
    ${response}=    Make Post Call Of "${EP_SEARCH_PRODUCT}" Endpoint With Parameter "top"
    Validate Response Status Is "200" And Response Body Contains "Babyhug" Text    ${response}

Scenario 3 > Get All Brands List API Test
    [Documentation]    Test the brands list endpoint 
    [Tags]             smokeapi
    ${response}=    Make Get Call Of "${EP_BRANDS_LIST}" Endpoint
    Validate Response Status Is "200" And Response Body Contains "brands" Text    ${response}

Scenario 4 > POST To Verify Login with valid details API Test
    [Documentation]    Test the verifyLogin endpoint with valid email and password
    [Tags]             smokeapi
    ${login_data}=    Create Dictionary    email=${USER_USERNAME}    password=${USER_PASSWORD}
    ${response}=    Make Post Call With Arguments    ${EP_VERIFY_LOGIN}    ${login_data}
    Validate Response Status Is "200" And Response Body Contains "User exists!" Text    ${response}

Scenario 5 > POST To Create/Register User Account API Test
    [Documentation]    Test the createAccount endpoint with random user data
    [Tags]             smokeapi
    ${user_data}=    Generate Random User Data
    ${response}=    Make Post Call With Arguments    ${EP_CREATE_ACCOUNT}    ${user_data}
    Validate Response Status Is "200" And Response Body Contains "User created!" Text    ${response}

Scenario 6 > DELETE METHOD To Delete User Account API Test
    [Documentation]    Test the deleteAccount endpoint with the created user credentials
    [Tags]             smokeapi
    ${delete_data}=    Create Dictionary    email=${CREATED_USER_EMAIL}    password=${CREATED_USER_PASSWORD}
    ${response}=    Make Delete Call With Arguments    ${EP_DELETE_ACCOUNT}    ${delete_data}
    Validate Response Status Is "200" And Response Body Contains "Account deleted!" Text    ${response} 