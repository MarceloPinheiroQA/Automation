*** Settings ***
Documentation     
Library           requests
Library           Collections
Library           JSONLibrary
Resource          ../Common/common_kw.robot
Resource          ../Resources/API/SmokeAPI_po.robot  

*** Variables ***

*** Keywords ***

Make Get Call Of "${endpoint}" Endpoint
    [Documentation]    Makes a GET call to the specified endpoint by combining it with the base URL from config
    
    # Construct full URL
    ${full_url}=    Set Variable    ${BASE_URL}${endpoint}
    
    # Make GET request
    ${response}=    Get    ${full_url}
    
    # Log response to console
    Log    API Response: ${response.text}    console=yes
    Log    Status Code: ${response.status_code}    console=yes
    
    # Return response for further validation if needed
    RETURN    ${response}

Validate Response Status Is "${expected_status}" And Response Body Contains "${expected_text}" Text
    [Documentation]    Validates the response status code and checks if response body contains expected text
    [Arguments]        ${response} 
    # Validate status code
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    # Validate response body contains expected text
    Should Contain    ${response.text}    ${expected_text}


