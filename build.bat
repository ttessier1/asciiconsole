@echo off
echo Setting CSC

REM Test batch file for the count.exe program
REM This batch file "should" build the count.exe program
REM as well as run a few simple tests
REM ascii.exe 

set CSC=c:\windows\microsoft.net\Framework64\v4.0.30319\csc.exe
set PARAMS=-warnaserror -warn:4
set TEST_PROGRAM=.\ascii.exe
echo After Set CSC
if NOT EXIST "%CSC%" goto CSCNotExist

echo CSC is "%CSC%"
%CSC% %PARAMS% /out:%TEST_PROGRAM% /debug+ /debug:full /target:exe main.cs
set LASTVALUE=%ERRORLEVEL%
IF "%ERRORLEVEL%"=="0" goto TESTS
goto END


:CSCNotExist
echo [%CSC%] does not exist in the normal location
exit /b 1

:TestProgramNotExist
echo [%TEST_PROGRAM%] does not exist in the normal location
exit /b 1

:TESTS
echo Completed
set TEST=0

set /A TEST=%TEST%+1
echo TEST[%TEST%] Calling %TEST_PROGRAM% with no arguments 
echo %TEST_PROGRAM%
%TEST_PROGRAM% >output\test%TEST%.output 2>output\test%TEST%.error
set LASTVALUE=%ERRORLEVEL%
echo Program returned %ERRORLEVEL% %LASTVALUE%
if "%LASTVALUE%"=="0" echo [32mSuccess[0m & type output\test%TEST%.output
if NOT "%LASTVALUE%"=="0" IF EXIST output\test%TEST%.output type output\test%TEST%.output
if NOT "%LASTVALUE%"=="0" echo [31mFailure[0m & type output\test%TEST%.error
IF NOT EXIST expect\TEST%TEST%.expect goto MissingExpect
for /f "" %%A IN (expect\TEST%TEST%.expect) DO set LAST_EXPECT=%%A
if "%LASTVALUE%"=="%LAST_EXPECT%" echo [32mResult Expected[0m 
if NOT "%LASTVALUE%"=="%LAST_EXPECT%" echo [31mResult Not Expected[0m & goto FAILEXPECT
echo .


exit /b 0

:END
echo Failed to compile
exit /b 1

:FAILEXPECT
echo Failed expected Result

exit /b 1

:MissingExpect
echo Missing the expect file
exit /b 1