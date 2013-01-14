@echo off
REM App Inventor Portable Batch File for Windows
REM non-Root / USB UserHome Version.
:STARTING
echo *************************************
echo AppInventor実行環境セットアップ
echo *************************************
set CURDIR=%~dp0
set JAVA_HOME=%CURDIR%\jdk1.6.0_37_32
set STPATH=%PATH%
set PATH=%JAVA_HOME%\bin;%PATH%
set AIDIR=%CURDIR%\.appinventor
set AIDIREXIST=0
IF EXIST "%AIDIR%" (
    set AIDIREXIST=1
)
IF %AIDIREXIST% == 1 (
    GOTO CONFIG
) ELSE (
    mkdir "%AIDIR%"
    echo.%~dp0AppInventor\commands-for-Appinventor>> "%AIDIR%\appinventordirectorycache"
)
:CONFIG
echo *************************************
echo JavaWebStartの関連付けを行います
echo *************************************
echo jnlp_auto_fileキーの存在チェック
echo *************************************
reg query HKCU\Software\Classes\jnlp_auto_file /s
IF %ERRORLEVEL% == 0 (
    echo jnlp_auto_fileキーのレジストリデータをexportします
    reg export HKCU\Software\Classes\jnlp_auto_file %CURDIR%\jnlp_auto_file_BkUp.reg
)
echo jnlp_auto_fileキーをPortable用に変更します
reg add HKCU\Software\Classes\jnlp_auto_file\shell\open\command /ve /t REG_SZ /d "%JAVA_HOME%\jre\bin\javaws.exe -J-Duser.home=%CURDIR% \"%%1\""
echo *************************************
echo .jnlpキーの存在チェック
echo *************************************
reg query HKCU\Software\Classes\.jnlp /s
IF %ERRORLEVEL% == 0 (
    echo Classes\.jnlpキーのレジストリデータをexportします
    reg export HKCU\Software\Classes\.jnlp %CURDIR%\jnlp_ext_BkUp.reg
) ELSE (
    echo Classes\.jnlpキーをPortable用に設定します
    reg add HKCU\Software\Classes\.jnlp /ve /t REG_SZ /d "jnlp_auto_file"
)
echo *************************************
echo .jnlp\UserChoiseキーの存在チェック
echo *************************************
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /s
IF %ERRORLEVEL% == 0 (
    echo FileExts\.jnlpキーのレジストリデータをexportします
    reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp %CURDIR%\jnlp_userchoice_BkUp.reg
    echo FileExts\.jnlp\UserChoiceキーが存在する場合は変更できないので設定値を利用します
) ELSE (
    echo FileExts\.jnlpキーをPortable用に設定します
    reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /v ProgId /t REG_SZ /d "jnlp_auto_file"
)
echo **************************************************
echo App Inventor Portableの設定が完了しました
echo 　　　　　　　USB環境のApp Inventorが利用可能です
echo 全ての作業が終了し、
echo 設定した内容を元に戻すには何かキーを押してください
echo **************************************************
pause
:END
set PATH=%STPATH%
set JAVA_HOME=
echo *************************************
echo JavaWebStartの関連付けを解除します
echo *************************************
IF EXIST %CURDIR%\jnlp_userchoice_BkUp.reg (
    echo FileExts\.jnlpキーのexportデータを削除します
    REM reg import %CURDIR%\jnlp_userchoice_BkUp.reg
    del %CURDIR%\jnlp_userchoice_BkUp.reg
) ELSE (
    echo .jnlp\UserChoiceキーのレジストリデータを解除します
    reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /f
)
IF EXIST %CURDIR%\jnlp_ext_BkUp.reg (
    echo .jnlpキーのexportデータを削除します
    REM reg import %CURDIR%\jnlp_ext_BkUp.reg
    del %CURDIR%\jnlp_ext_BkUp.reg
) ELSE (
    echo .jnlpキーのレジストリデータを解除します
    reg delete HKCU\Software\Classes\.jnlp /f
)
IF EXIST %CURDIR%\jnlp_auto_file_BkUp.reg (
    echo jnlp_auto_fileキーのレジストリデータをimportします
    reg import %CURDIR%\jnlp_auto_file_BkUp.reg
    del %CURDIR%\jnlp_auto_file_BkUp.reg
) ELSE (
    echo jnlp_auto_fileキーのレジストリデータを解除します
    reg delete HKCU\Software\Classes\jnlp_auto_file /f
)
IF %AIDIREXIST% == 0 (
    rmdir /S /Q "%AIDIR%"
)
taskkill /f /im adb.exe
echo *************************************
echo AppInventor実行環境設定を解除しました
echo *************************************
pause
