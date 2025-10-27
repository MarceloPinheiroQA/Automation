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

Generate Random User Data
    [Documentation]    Generates a complete dictionary with random user data for account creation
    ${random_email}=    Generate Random Email
    ${random_name}=     Generate Random String    8    [LETTERS]
    ${random_firstname}=    Generate Random String    6    [LETTERS]
    ${random_lastname}=     Generate Random String    8    [LETTERS]
    ${random_company}=      Generate Random String    10   [LETTERS]
    ${random_address1}=     Generate Random String    15   [LETTERS]
    ${random_address2}=     Generate Random String    12   [LETTERS]
    ${random_city}=         Generate Random String    8    [LETTERS]
    ${random_state}=        Generate Random String    6    [LETTERS]
    ${random_zipcode}=      Generate Random String    5    [NUMBERS]
    ${random_mobile}=       Generate Random String    10   [NUMBERS]
    
    # Random title selection
    ${titles}=    Create List    Mr    Mrs    Miss
    ${title_index}=    Evaluate    random.randint(0, 2)    random
    ${random_title}=    Get From List    ${titles}    ${title_index}
    
    # Random birth date
    ${random_day}=       Generate Random String    2    [NUMBERS]
    ${random_month}=     Generate Random String    2    [NUMBERS]
    ${random_year}=      Generate Random String    4    [NUMBERS]
    
    # Ensure day is between 1-28
    ${day_int}=    Convert To Integer    ${random_day}
    ${day_int}=    Evaluate    (${day_int} % 28) + 1
    ${random_day}=    Convert To String    ${day_int}
    
    # Ensure month is between 1-12
    ${month_int}=    Convert To Integer    ${random_month}
    ${month_int}=    Evaluate    (${month_int} % 12) + 1
    ${random_month}=    Convert To String    ${month_int}
    
    # Ensure year is between 1950-2000
    ${year_int}=    Convert To Integer    ${random_year}
    ${year_int}=    Evaluate    (${year_int} % 51) + 1950
    ${random_year}=    Convert To String    ${year_int}
    
    # Random country selection
    ${countries}=    Create List    United States    Canada    United Kingdom    Australia    Germany
    ${country_index}=    Evaluate    random.randint(0, 4)    random
    ${random_country}=    Get From List    ${countries}    ${country_index}
    
    # Create user data dictionary
    ${user_data}=    Create Dictionary
    ...    name=${random_name}
    ...    email=${random_email}
    ...    password=TestPassword123!
    ...    title=${random_title}
    ...    birth_date=${random_day}
    ...    birth_month=${random_month}
    ...    birth_year=${random_year}
    ...    firstname=${random_firstname}
    ...    lastname=${random_lastname}
    ...    company=${random_company}
    ...    address1=${random_address1}
    ...    address2=${random_address2}
    ...    country=${random_country}
    ...    zipcode=${random_zipcode}
    ...    state=${random_state}
    ...    city=${random_city}
    ...    mobile_number=${random_mobile}
    
    # Store as suite variables for reuse in delete scenario
    Set Suite Variable    ${CREATED_USER_EMAIL}    ${random_email}
    Set Suite Variable    ${CREATED_USER_PASSWORD}    TestPassword123!
    
    RETURN    ${user_data}