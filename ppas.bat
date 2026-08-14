@echo off
SET THEFILE=d:\project\Linetris\SumGNULinetris.exe
echo Linking %THEFILE%
d:\lazarus\bin\fpc\3.2.2\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections    --entry=_mainCRTStartup    -o d:\project\Linetris\Linetris.exe d:\project\Linetris\link3876.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
