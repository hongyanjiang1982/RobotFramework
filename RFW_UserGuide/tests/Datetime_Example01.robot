*** Settings ***
Library    DateTime    


*** Test Cases ***

Timestamp
    ${date1}=    Convert Date    2014-06-11 10:07:42.000
    ${date2}=    Convert Date    20140611 100742    result_format=timestamp
    Should Be Equal    ${date1}    ${date2}    
    Log    ${date1} ${date2}
    ${date}=    Convert Date    20140612 12:57    exclude_millis=yes
    Should Be Equal    ${date}    2014-06-12 12:57:00    
    Log    ${date}
    
Custom timestamp
    [Documentation]    %Y-%m-%d %H:%M:%S.%f, date_format, result_format   
    ${date}=    Convert Date    28.05.2014 12:05    date_format=%d.%m.%Y %H:%M
    Should Be Equal    ${date}    2014-05-28 12:05:00.000    
    Log    ${date}    
    ${date}=    Convert Date    ${date}    result_format=%d.%m.%Y
    Should Be Equal    ${date}    28.05.2014    
    Log    ${date}
    
Python datetime
    [Documentation]    Python's standard datetime objects.In input they are recognized
    ...    automatically, and in output it is possible to get them by giving datetime
    ...    value to result_format argument.
    ${datetime}=    Convert Date    2014-06-11 10:07:42.123    datetime
    Should Be Equal As Integers    ${datetime.year}    2014    
    Should Be Equal As Integers    ${datetime.month}    6    
    Should Be Equal As Integers    ${datetime.day}    11    
    Should Be Equal As Integers    ${datetime.hour}    10    
    Should Be Equal As Integers    ${datetime.minute}    7    
    Should Be Equal As Integers    ${datetime.second}    42    
    Should Be Equal As Integers    ${datetime.microsecond}    123000    
    

Epoch time
    [Documentation]    Epoch time is the time in seconds since the UNIX epoch.
    ...    i.e. 00:00:00.000 (UTC) 1 January 1970.
    ${date}=    Convert Date    ${1000000000}    
    Log    ${date}
    ${date}=    Convert Date    2020-03-15 09:16:30.000    epoch
    Log    Epoch time of 2020-03-15 09:16:30.000 is ${date}    
    
Earliest supported date
    [Documentation]    Earliest supported date
    Log    please refer to http://robotframework.org/robotframework/latest/libraries/DateTime.html
    
Time formats: Number
    [Documentation]    Time given as a number is interpreted to be seconds.
    ${time}=    Convert Time    3.14    
    Should Be Equal    ${time}    ${3.14}    
    Log    ${time}        
    ${time}=    Convert Time    ${time}    result_format=number
    Should Be Equal    ${time}    ${3.14}    

Time formats: Time string
    [Documentation]    Time strings are strings in format like 1 minute 42 seconds or 1min 42s.
    ...    The available time specifiers are:
    ...    days, day, d
    ...    hours, hour, h
    ...    minutes, minute, mins, min, m
    ...    seconds, second, sec, sec, s
    ...    milliseconds, millisecond, millis, ms
    ${time}=    Convert Time    1 minute 42 seconds    
    Should Be Equal    ${time}    ${102}    
    Log    ${time}
    ${time}=    Convert Time    4200    verbose
    Should Be Equal    ${time}    1 hour 10 minutes    
    Log    ${time}
    ${time}=    Convert Time    - 1.5 hours    compact
    Should Be Equal    ${time}    - 1h 30min    
    Log    ${time}    
    
Time formats: Timer string
    [Documentation]    Timer string is a string given in timer
    ...     like format hh:mm:ss.mil
    ${time}=    Convert Time    01:42    
    Should Be Equal    ${time}    ${102}    
    ${time}=    Convert Time    01:10:00.123    
    Should Be Equal    ${time}    ${4200.123}    
    ${time}=    Convert Time    102    timer
    Should Be Equal    ${time}    00:01:42.000    
    ${time}=    Convert Time    -101.567    timer    exclude_millis=yes
    Should Be Equal    ${time}    -00:01:42    
    
Python timedelta
    [Documentation]    Python timedelta
    ${timedelta}=    Convert Time    01:10:02.123    timedelta
    Should Be Equal    ${timedelta.total_seconds()}    ${4202.123}    
    
Millisecond handing
    [Documentation]    Millisecond handing
    ${date}=    Convert Date    2014-06-11 10:07:42    
    Log    ${date}    
    ${date}=    Convert Date    2014-06-11 10:07:42.500    exclude_millis=yes
    Log    ${date}    
    ${dt}=    Convert Date    2014-06-11 10:07:42.500    datetime    exclude_millis=yes
    Log    ${dt}    
    Should Be Equal    ${dt.second}    ${43}    
    Should Be Equal    ${dt.microsecond}    ${0}    
    ${time}=    Convert Time    102    timer    exclude_millis=false
    Log    ${time}    
    ${time}=    Convert Time    102.567    timer    exclude_millis=true
    Log    ${time}    
    Should Be Equal    ${time}    00:01:43    
    
Add Time to Date
    [Documentation]    Adds time to another time
    ${date}=    Add Time To Date    2014-05-28 12:05:03.111    7 days
    Log    ${date}    
    ${date}=    Add Time To Date    2014-05-28 12:05:03.111    01:02:03.004    
    Should Be Equal    ${date}    2014-05-28 13:07:06.115    
            
Add Time to Time
    [Documentation]    Adds time to another time and returns the resulting time.       
    ${time}=    Add Time To Time    1 minute    42    
    Should Be Equal    ${time}    ${102}    
    ${time}=    Add Time To Time    3 hours 5 minutes    01:02:03    timer    exclude_millis=yes
    Should Be Equal    ${time}    04:07:03    
    ${time}=    Add Time To Time    3 hours 5 minutes    01:02:03    result_format=number    exclude_millis=yes
    Should Be Equal    ${time}    ${14823}

Convert Date
    [Documentation]    Converts between supported date formats
    ${date}=    Convert Date    20140528 12:05:03.111    
    Should Be Equal    ${date}    2014-05-28 12:05:03.111    
    ${date}=    Convert Date    ${date}    epoch
    Log    ${date}    
    ${date}=    Convert Date    5.28.2014 12:05    exclude_millis=yes    date_format=%m.%d.%Y %H:%M
    Log    ${date}    
    
Convert Time
    [Documentation]    Converts between supported time formats
    ${time}=    Convert Time    10 seconds    
    Should Be Equal    ${time}    ${10}    
    ${time}=    Convert Time    1:00:01    verbose
    Log    ${time}    
    ${time}=    Convert Time    ${3661.5}    timer    exclude_milles=yes
    Log    ${time}    
    
Get Current Date
    [Documentation]    Returns current local or UTC time with an optional increment
    ${date}=    Get Current Date    
    Log    ${date}    
    ${date}=    Get Current Date    UTC
    Log    ${date}
    ${date}=    Get Current Date    increment=02:30:00
    Log    ${date}
    ${date}=    Get Current Date    UTC    -5hours
    Log    ${date}    
    ${date}=    Get Current Date    result_format=datetime
    Log    ${date}
    Log    ${date.year}
    Log    ${date.month}
 
Subtract Date From Date
    [Documentation]    Subtracts date from another date and returns time between
    ${time}=    Subtract Date From Date    2014-05-28 12:05:52    2014-05-28 12:05:10    
    Should Be Equal    ${time}    ${42}    
    ${time}=    Subtract Date From Date    2014-05-28 12:05:52    2014-05-27 12:05:10    verbose
    Should Be Equal    ${time}    1 day 42 seconds    
    
Subtract Time From Date
    [Documentation]    Subtracts time from date and returns the resulting date
    ${date}=    Subtract Time From Date    2014-06-04 12:05:03.111    7 days    
    Should Be Equal    ${date}    2014-05-28 12:05:03.111    
    ${date}=    Subtract Time From Date    2014-05-28 13:07:06.115    01:02:03.004    
    Should Be Equal    ${date}    2014-05-28 12:05:03.111    
    
Subtract Time From Time
    [Documentation]    Subtracts time from another time and returns the resulting time
    ${time}=    Subtract Time From Time    00:02:30    100    
    Should Be Equal    ${time}    ${50}    
    ${time}=    Subtract Time From Time    ${time}    1 minute    compact
    Should Be Equal    ${time}    - 10s    
           
       