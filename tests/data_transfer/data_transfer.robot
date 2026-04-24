*** Settings ***
Resource    ../epc_keywords.robot

*** Test Cases ***
TC14 Verify Starting Data Transfer
    [Tags]    transfer    positive
    [Setup]    Attach UE-8
    Start DL Transfer On UE-8 Bearer-9 Speed 50 Mbps
    Verify DL Transfer Is Active On UE-8 Bearer-9
    [Teardown]    Detach UE-8

TC15 Verify Starting Transfer Exceeding Max Speed Throws Error
    [Tags]    transfer    negative
    [Setup]    Attach UE-9
    Run Keyword And Expect Error    *400 Client Error*|*422 Client Error*    Start DL Transfer On UE-9 Bearer-9 Speed 150 Mbps
    [Teardown]    Detach UE-9

TC16 Verify Negative Speed Is Rejected
    [Tags]    logic    transfer    negative
    Reset EPC Network Simulator
    Attach UE-36
    Add Bearer-1 To UE-36
    Run Keyword And Expect Error    *    Api Start Data Transfer    36    1    -1
    [Teardown]    Detach UE-36

TC17 Verify Starting Transfer On Inactive Bearer Throws Error
    [Tags]    transfer    negative
    [Setup]    Attach UE-10
    Run Keyword And Expect Error    *400 Client Error*    Start DL Transfer On UE-10 Bearer-5 Speed 20 Mbps
    [Teardown]    Detach UE-10

TC18 Verify Ending Specific Bearer Transfer
    [Tags]    transfer    positive
    [Setup]    Attach UE-12
    Start DL Transfer On UE-12 Bearer-9 Speed 40 Mbps
    End Transfer On UE-12 Bearer-9
    Verify No Transfer Is Active On UE-12 Bearer-9
    [Teardown]    Detach UE-12
