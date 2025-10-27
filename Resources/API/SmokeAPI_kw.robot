*** Settings ***
Documentation     
Library           requests
Library           Collections
Library           JSONLibrary
Resource          ../Common/common_kw.robot
Resource          ${CURDIR}/SmokeAPI_po.robot  

*** Variables ***

*** Keywords ***

Make Get Call Of "${endpoint}" Endpoint
    [Documentation]    Makes a GET call to the specified endpoint by combining it with the base URL from config
    
    # Construct full URL
    ${full_url}=    Set Variable    ${BASE_URL}${endpoint}
    
    # Make GET request
    ${response}=    Get    ${full_url}
    
    # Return response for further validation if needed
    RETURN    ${response}

Validate Response Status Is "${expected_status}" And Response Body Contains "${expected_text}" Text
    [Documentation]    Validates the response status code and checks if response body contains expected text
    [Arguments]        ${response} 
    # Validate status code
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    # Validate response body contains expected text
    Should Contain    ${response.text}    ${expected_text}

Make Post Call Of "${endpoint}" Endpoint With Parameter "${parameter_value}"
    [Documentation]    Makes a POST call to the specified endpoint with parameter passed as argument
    
    # Construct full URL
    ${full_url}=    Set Variable    ${BASE_URL}${endpoint}
    
    # Prepare request parameters as form data (URL-encoded)
    IF    '${endpoint}' == '${EP_SEARCH_PRODUCT}' or '${endpoint}' == '/searchProduct'
        ${request_data}=    Create Dictionary    search_product=${parameter_value}
    ELSE
        ${request_data}=    Set Variable    ${parameter_value}
    END
    
    # Make POST request with form data (URL-encoded)
    ${response}=    Post    ${full_url}    data=${request_data}
    
    
    # Return response for further validation if needed
    RETURN    ${response}

Make Post Call With Arguments
    [Documentation]    Makes a POST call to the specified endpoint with parameter data
    [Arguments]    ${endpoint}   ${parameter_value}   
    
    # Construct full URL
    ${full_url}=    Set Variable    ${BASE_URL}${endpoint}
    
    # Prepare request parameters as form data (URL-encoded)
    # Check if parameter_value is a dictionary (for createAccount) or single value
    ${is_dict}=    Run Keyword And Return Status    Should Be True    type($parameter_value).__name__ == 'dict'
    
    IF    ${is_dict}
        ${request_data}=    Set Variable    ${parameter_value}
    ELSE
        ${request_data}=    Set Variable    ${parameter_value}
    END
    
    # Make POST request with form data (URL-encoded)
    ${response}=    Post    ${full_url}    data=${request_data}
    
    
    # Return response for further validation if needed
    RETURN    ${response}

Make Delete Call With Arguments
    [Documentation]    Makes a DELETE call to the specified endpoint with parameter data dictionary
    [Arguments]    ${endpoint}    ${parameter_data}
    
    # Construct full URL
    ${full_url}=    Set Variable    ${BASE_URL}${endpoint}
    
    # Make DELETE request with form data (URL-encoded)
    ${response}=    Delete    ${full_url}    data=${parameter_data}
    
    
    # Return response for further validation if needed
    RETURN    ${response}

