@echo off
:STARTING
echo AppInventor���s���Z�b�g�A�b�v
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
echo JavaWebStart�̊֘A�t�����s���܂�
echo jnlp_auto_file�L�[�̑��݃`�F�b�N
reg query HKCU\Software\Classes\jnlp_auto_file /s
IF %ERRORLEVEL% == 0 (
    echo jnlp_auto_file�L�[�̃��W�X�g���f�[�^��export���܂�
    reg export HKCU\Software\Classes\jnlp_auto_file %CURDIR%\jnlp_auto_file_BkUp.reg
)
echo jnlp_auto_file�L�[��Portable�p�ɕύX���܂�
reg add HKCU\Software\Classes\jnlp_auto_file\shell\open\command /ve /t REG_SZ /d "%JAVA_HOME%\jre\bin\javaws.exe -J-Duser.home=%CURDIR% \"%%1\""
echo .jnlp�L�[�̑��݃`�F�b�N
reg query HKCU\Software\Classes\.jnlp /s
IF %ERRORLEVEL% == 0 (
    echo Classes\.jnlp�L�[�̃��W�X�g���f�[�^��export���܂�
    reg export HKCU\Software\Classes\.jnlp %CURDIR%\jnlp_ext_BkUp.reg
) ELSE (
    echo Classes\.jnlp�L�[��Portable�p�ɕύX���܂�
    reg add HKCU\Software\Classes\.jnlp /ve /t REG_SZ /d "jnlp_auto_file"
)
echo .jnlp\UserChoise�L�[�̑��݃`�F�b�N
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /s
IF %ERRORLEVEL% == 0 (
    echo FileExts\.jnlp�L�[�̃��W�X�g���f�[�^��export���܂�
    reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp %CURDIR%\jnlp_userchoice_BkUp.reg
    echo FileExts\.jnlp\UserChoice�L�[�����݂���ꍇ�͕ύX�ł��Ȃ��̂Őݒ�l�𗘗p���܂�
) ELSE (
    echo FileExts\.jnlp�L�[��Portable�p�ɕύX���܂�
    reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /v ProgId /t REG_SZ /d "jnlp_auto_file"
)
echo �ݒ肵�����e�����ɖ߂��ɂ͉����L�[�������Ă�������
pause
:END
set PATH=%STPATH%
set JAVA_HOME=
echo JavaWebStart�̊֘A�t�����������܂�
IF EXIST %CURDIR%\jnlp_userchoice_BkUp.reg (
    echo FileExts\.jnlp�L�[��export�f�[�^���폜���܂�
    REM reg import %CURDIR%\jnlp_userchoice_BkUp.reg
    del %CURDIR%\jnlp_userchoice_BkUp.reg
) ELSE (
    echo .jnlp\UserChoice�L�[�̃��W�X�g���f�[�^���������܂�
    reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /f
)
IF EXIST %CURDIR%\jnlp_ext_BkUp.reg (
    echo .jnlp�L�[�̃��W�X�g���f�[�^��import���܂�
    reg import %CURDIR%\jnlp_ext_BkUp.reg
    del %CURDIR%\jnlp_ext_BkUp.reg
) ELSE (
    echo .jnlp�L�[�̃��W�X�g���f�[�^���������܂�
    reg delete HKCU\Software\Classes\.jnlp /f
)
IF EXIST %CURDIR%\jnlp_auto_file_BkUp.reg (
    echo jnlp_auto_file�L�[�̃��W�X�g���f�[�^��import���܂�
    reg import %CURDIR%\jnlp_auto_file_BkUp.reg
    del %CURDIR%\jnlp_auto_file_BkUp.reg
) ELSE (
    echo jnlp_auto_file�L�[�̃��W�X�g���f�[�^���������܂�
    reg delete HKCU\Software\Classes\jnlp_auto_file /f
)
IF %AIDIREXIST% == 0 (
    rmdir /S /Q "%AIDIR%"
)
echo AppInventor���s���ݒ���������܂�
pause
