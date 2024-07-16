*** Settings ***
Documentation  Basic Robot Framework tests for checking Internet availibility on Win
Library  OperatingSystem
Library    String
Variables     ./resources/variables.yaml

*** Test Cases ***

Check Internet Connectivity
    FOR  ${host}  IN  @{HOST_LIST}
        ${output} =    Run And Return Rc And Output    ping ${host}
        Log To Console    \n${output}[1]
        ${stats} =    Get Lines Containing String   ${output}[1]    Packets
        Log To Console    \n${stats}
        Should Contain    ${stats}    (0% loss)
        Should Not Contain    ${stats}    (100% loss)
    END

Check Trace Routes

    FOR  ${host}  IN  @{HOST_LIST}
        ${output} =    Run And Return Rc And Output    tracert ${host}
        Log To Console    \n${output}[1]
        Should Not Contain    ${output}[1]    Request timed out
    END