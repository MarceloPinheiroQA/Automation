*** Variables ***

${register_name_loc}            input[data-qa="signup-name"]
${register_email_loc}           input[data-qa="signup-email"]
${register_button_loc}          button[data-qa="signup-button"]

${login_page}                    a[href="/login"]
${login_email_loc}               input[data-qa="login-email"]
${login_password_loc}            input[data-qa="login-password"]
${login_button_loc}              button[data-qa="login-button"]
${logout_page_button}            a[href="/logout"]

# Account Information Locators
${gender_male_loc}               input[id="id_gender1"]
${name_field_loc}                id=name
${password_field_loc}            id=password
${days_dropdown_loc}             id=days
${months_dropdown_loc}           id=months
${years_dropdown_loc}            id=years

# Address Information Locators
${first_name_loc}                id=first_name
${last_name_loc}                 id=last_name
${company_loc}                   id=company
${address1_loc}                  id=address1
${country_dropdown_loc}          id=country
${state_loc}                     id=state
${city_loc}                      id=city
${zipcode_loc}                   id=zipcode
${mobile_number_loc}             id=mobile_number
${create_account_button_loc}     button[data-qa="create-account"]

# Account Information Values
${account_name}                  Marcelo Portfolio
${account_password}              Test123!
${birth_day}                     21
${birth_month}                   12
${birth_year}                    2001

# Address Information Values
${first_name_value}              Marcelo
${last_name_value}               Portfolio
${company_name}                  PortfolioCompany
${address_value}                 Imaginy St, 1462
${country_value}                 India
${state_value}                   Georgia
${city_value}                    LA
${zipcode_value}                 2112
${mobile_number_value}           459988745

# Account created values
${register_continue_button}      a[data-qa="continue-button"]
${delete_button}                 a[href="/delete_account"] 
${email_exist_locator}           xpath=//input[@value="signup"]/following-sibling::p
${email_exist_message}           Email Address already exist!