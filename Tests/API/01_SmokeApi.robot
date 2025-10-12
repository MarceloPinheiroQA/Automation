*** Settings ***
Documentation     API Test Suite
Library           Browser
Library           Collections
Library           Requests
Resource          ../../Resources/Common/common_kw.robot
Resource          ../../Resources/API/SmokeAPI_kw.robot
Suite Setup       Setup Automation API

*** Variables ***


*** Test Cases ***

Scenario 1 > Sample GET API Test
    [Documentation]    Test the products list endpoint using the generic GET keyword
    ${response}=    Make Get Call Of "productsList" Endpoint
    Validate Response Status Is "200" And Response Body Contains "Babyhug" Text    ${response} 

