*** Settings ***
Documentation     
Resource          ../Common/common_kw.robot
Resource          ../Browser/ManageBrowser.robot    
Resource          ../UI/login_po.robot

*** Variables ***
${error message}    EMPTY

*** Keywords ***
Go to the website page
    Go To    ${URL}

Go To The Login Page
    Click    ${login_page}

Input The Email "${VAR_USER_USERNAME}" in the field
    Fill Text    ${login_email_loc}    ${VAR_USER_USERNAME}   

Input The Password "${VAR_USER_PASSWORD}" in the field
    Fill Text    ${login_password_loc}    ${VAR_USER_PASSWORD}

Click On Login Button
    Click    ${login_button_loc}

Validate Invalid Credentials Message
    ${error message}         Get Text    ${invalid_cred_msg_loc}
    Should Be Equal As Strings    ${error message}    ${invalid_credentials_msg}
Input Registration Credentials
    ${random_email}=    Generate Random Email
    Fill Text    ${register_name_loc}    Marcelo Portfolio
    Fill Text    ${register_email_loc}    ${random_email}
    Click        ${register_button_loc}

Input Registration Name Credential
    [Arguments]    ${name_credential}
    Fill Text    ${register_name_loc}    ${name_credential}

Input Registration Email Credential
    [Arguments]    ${email_credential}
    Fill Text    ${register_email_loc}    ${email_credential}

Click On Registration Register Button
    Click        ${register_button_loc}

Validate Existing Email Message
    ${error message}         Get Text    ${email_exist_locator}
    Should Be Equal As Strings    ${error message}    ${email_exist_message}

Enter Account Information
    Click     ${gender_male_loc}
    Fill Text    ${name_field_loc}    ${account_name}
    Fill Text    ${password_field_loc}    ${account_password}
    Select Options By    ${days_dropdown_loc}    value    ${birth_day}
    Select Options By    ${months_dropdown_loc}    value   ${birth_month}
    Select Options By    ${years_dropdown_loc}    value    ${birth_year}

Enter Address Information
    Fill Text    ${first_name_loc}    ${first_name_value}
    Fill Text    ${last_name_loc}    ${last_name_value}
    Fill Text    ${company_loc}        ${company_name}
    Fill Text    ${address1_loc}        ${address_value}
    Select Options By    ${country_dropdown_loc}    value    ${country_value}
    Fill Text    ${state_loc}    ${state_value}
    Fill Text    ${city_loc}    ${city_value}
    Fill Text    ${zipcode_loc}    ${zipcode_value}
    Fill Text    ${mobile_number_loc}    ${mobile_number_value}
    Click    ${create_account_button_loc}
    Click On Continue 

Click On Continue 
    Wait For Elements State    ${register_continue_button}    visible    timeout=5
    Click    ${register_continue_button}

Delete Account
    Click    ${delete_button}
    Click On Continue 

Logout From The Application
    Wait For Elements State    ${logout_page_button}    visible    10s
    Click    ${logout_page_button}