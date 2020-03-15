*** Settings ***
Library    Dialogs    

*** Test Cases ***

Sample01
    [Documentation]    Will Send a Message in dialog to manually interception.
    Execute Manual Step    "Hello, World!"
    Execute Manual Step    "False ? Pass"    default_error=fail it    

Sample02
    [Documentation]    Manually Selection from the options
    ${user}=    Get Selection From User    Select User    User1    User2    Admin
    Log    Selected user is ${user}
    
Sample03
    [Documentation]    Manually Select multiple options
    ${users}=    Get Selections From User    Select User    User1    User2    Admin
    Log    Selected users are ${users}

Sample04
    [Documentation]    Get Value form the manual inputs
    ${username}=    Get Value From User    Input user name    default_value=mgw
    ${password}=    Get Value From User    Input password    hidden=yes
    Log    The username and password are (${username}, ${password}).
    
Sample05
    [Documentation]    Sample05
    Pause Execution    message=Test execution paused.Press OK to continue.
           