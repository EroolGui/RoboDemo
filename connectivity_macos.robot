*** Settings ***
Documentation  Basic Robot Framework tests for checking Internet availibility on MacOS
Library  OperatingSystem
Library    String
Variables     ./resources/variables.yaml

*** Test Cases ***

Check Internet Connectivity
    FOR  ${host}  IN  @{HOST_LIST}
        ${output} =    Run And Return Rc And Output    ping -c 4 ${host}
        Log To Console    \n${output}[1]
        ${stats} =    Get Lines Containing String   ${output}[1]    packet loss
        Log To Console    \n${stats}
        Should Contain    ${stats}    0.0%
        Should Not Contain    ${stats}    100.0%
    END

Check Trace Routes

    FOR  ${host}  IN  @{HOST_LIST}
        ${output} =    Run And Return Rc And Output    traceroute ${host}
        Log To Console    \n${output}[1]
    END