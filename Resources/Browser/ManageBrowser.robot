*** Settings ***
Documentation    This resource file is to manage browser
Library          Browser
Library          Collections
Library          OperatingSystem
Variables        ${CURDIR}${/}BrowserConfiguration.yaml


*** Variables ***


*** Keywords *** 
Build Web Browser Arguments
    [Documentation]    Build the web browser arguments dictionary
    ${headless_bool}    Convert To Boolean    ${BROWSER_IS_HEADLESS}
    ${timeout_int}    Convert To Integer    ${BROWSER_TIMEOUT}
    ${browser_args}    Create Dictionary
    ...    browser=${WEB_BROWSER}
    ...    headless=${headless_bool}
    ...    timeout=${timeout_int}
    Set Suite Variable    ${WEB_BROWSER_ARGUMENTS}    ${browser_args}

Set Chrome Arguments
    [Documentation]    Set Chrome Arguments
    Set To Dictionary    ${WEB_BROWSER_ARGUMENTS}    args=${CHROME_ARGS}

Configure Download Path
    [Documentation]    Configure Download Path
    TRY    
        Variable Should Exist    ${WEB_BROWSER_DOWNLOAD_PATH}
    EXCEPT
        ${path}   Join Path    ${EXECDIR}    Downloads
        Set Suite Variable    ${WEB_BROWSER_DOWNLOAD_PATH}    ${path}
    END

Get Display Resolution
    [Documentation]    Get Display Resolution from display resolution dictionary
    ...    values: MAX, HD, FHD, QUAD_HD
    ...    DEFAULT: MAX
    ${display_resolution_values}    Get From Dictionary    ${DISPLAY_RESOLUTION_DICT}    ${DEFAULT_WINDOW_RESOLUTION}
    ...      default={"WIDTH": 0, "HEIGHT": 0, "ASPECT_RATIO": null}
    RETURN        ${display_resolution_values}

Create Browser With Context
    [Documentation]    Create Browser With Context based on browser strategy
    ...    values: incognito, persistent
    ...    
    Build Web Browser Arguments
    Configure Download Path
    IF    "${BROWSER_STRATEGY}" == "incognito"
        Create Incognito Browser And Context
    ELSE IF    "${BROWSER_STRATEGY}" == "persistent"
        Create Persistent Browser And Context
    END

Create Incognito Browser And Context
    [Documentation]    Create Incognito Browser With Context
    ${display_resolution_values}    Get Display Resolution
    IF    '${WEB_BROWSER}' == 'chromium'     Set Chrome Arguments
    ${vp_width}    Get From Dictionary    ${display_resolution_values}    WIDTH
    ${vp_height}    Get From Dictionary    ${display_resolution_values}    HEIGHT
    ${viewport}    Create Dictionary    width=${vp_width}    height=${vp_height}
    Set To Dictionary    ${CONTEXT_ARGUMENTS}
    ...    acceptDownloads=True
    ...    viewport=${viewport}
    
    New Browser   &{WEB_BROWSER_ARGUMENTS}
    New Context   &{CONTEXT_ARGUMENTS}
    New Page

Create Persistent Browser And Context
    [Documentation]    Create Persistent Browser With Context
    ${display_resolution_values}    Get Display Resolution
    IF    '${WEB_BROWSER}' == 'chromium'     Set Chrome Arguments
    ${vp_width}    Get From Dictionary    ${display_resolution_values}    WIDTH
    ${vp_height}    Get From Dictionary    ${display_resolution_values}    HEIGHT
    ${viewport}    Create Dictionary    width=${vp_width}    height=${vp_height}
    Set To Dictionary    ${CONTEXT_ARGUMENTS}
    ...    acceptDownloads=True
    ...    viewport=${viewport}
    
    New Browser   &{WEB_BROWSER_ARGUMENTS}
    New Context   &{CONTEXT_ARGUMENTS}
    New Page

Quit Browser
    [Documentation]    Closes the browser instance
    Set Local Variable    @{current_list}    CURRENT
    ${browser_ids}    Get Browser Ids    @{current_list}
    Close Browser    @{current_list}
    RETURN    ${browser_ids}