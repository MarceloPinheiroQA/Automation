# Robot Framework Arguments File
# This file contains command-line arguments for Robot Framework execution
# Usage: robot -A Data/ArgumentsFiles/Arguments.robot

# =============================================================================
# ENVIRONMENT TO BE SET
# =============================================================================
# Set the target environment for test execution
-v ENVIRONMENT:uat
# --v ENVIRONMENT:staging
# --v ENVIRONMENT:production

# Set browser configuration
-v WEB_BROWSER:chromium
-v BROWSER_IS_HEADLESS:False
-v BROWSER_TIMEOUT:30
-v BROWSER_STRATEGY:incognito
-v DEFAULT_WINDOW_RESOLUTION:FHD


# =============================================================================
# MISC SETTINGS
# =============================================================================
# Logging and output configuration
--loglevel INFO
--outputdir results
--log log.html
--report report.html
--output output.xml


# Parallel execution (if using pabot)
# --processes 4
# --pabotlib

# Retry failed tests
# --rerunfailed output.xml
# --outputdir results/retry

# =============================================================================
# CONFIG FILE PATH
# =============================================================================
# Import variables from configuration files
-V Data/ConfigFiles/uat.json

# Import custom libraries
# --pythonpath Resources/Libraries

# =============================================================================
# TEST TAGS
# =============================================================================
# Include specific test tags


# =============================================================================
# TEST FILE PATH
# =============================================================================
# Specify test files or directories to execute
Tests/UI/01_Login_Signup/login.robot
# =============================================================================
# ADDITIONAL OPTIONS
# =============================================================================
# Test execution options
#--dryrun
# --exitonfailure
# --exitonerror
# --skipteardownonfailure

# Variable overrides
# --variable TIMEOUT:60
# --variable RETRY_COUNT:3

# Custom listeners
# --listener Resources/Listeners/CustomListener.py

# Pre-run and post-run modifiers
# --prerunmodifier Resources/Modifiers/PreRunModifier.py
# --postrunmodifier Resources/Modifiers/PostRunModifier.py
