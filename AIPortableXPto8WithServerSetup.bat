@echo off
REM App Inventor Portable Batch File for Windows
REM non-Admin / USB UserHome Version
REM Author : naominix
:STARTING
REM SERVER���N������ꍇ��1���N�����Ȃ��ꍇ��0���`
set SERVER=0
REM �o�b�`�t�@�C�������s���Ă���h���C�u���J�����g�t�H���_���̎擾
set CURDIR=%~dp0
IF NOT "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
    echo "JAVA_HOME��USB����������JDK(32bit)�Ɏw��"
    set JAVA_HOME=%CURDIR%\jdk1.7.0_13_32
) ELSE (
    echo "64bit OS�̏ꍇ��USB����������JDK(64bit)�Ɏw��"
    set JAVA_HOME=%CURDIR%\jdk1.7.0_13
)
REM PATH���ϐ��̈ꎞ�ۑ�
set STPATH=%PATH%
REM USB����������JDK��PATH���ŗD��Œʂ�
set PATH=%JAVA_HOME%\bin;%PATH%
REM USB���������Ƀ��[�U�z�[����.appinventor�t�H���_���쐬���邽�߂̏���
set AIDIR=%CURDIR%\.appinventor
set AIDIREXIST=0
echo *************************************
echo AppInventor���s���Z�b�g�A�b�v
echo *************************************
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
echo JavaWebStart�̊֘A�t�����s���܂�
echo *************************************
echo jnlp_auto_file�L�[�̑��݃`�F�b�N
echo *************************************
reg query HKCU\Software\Classes\jnlp_auto_file /s
IF %ERRORLEVEL% == 0 (
    echo jnlp_auto_file�L�[�̃��W�X�g���f�[�^��export���܂�
    reg export HKCU\Software\Classes\jnlp_auto_file %CURDIR%\jnlp_auto_file_BkUp.reg
)
echo jnlp_auto_file�L�[��Portable�p�ɕύX���܂�
reg add HKCU\Software\Classes\jnlp_auto_file\shell\open\command /ve /t REG_SZ /d "%JAVA_HOME%\jre\bin\javaws.exe -J-Duser.home=%CURDIR% \"%%1\"" /f
echo *************************************
echo .jnlp�L�[�̑��݃`�F�b�N
echo *************************************
reg query HKCU\Software\Classes\.jnlp /s
IF %ERRORLEVEL% == 0 (
    echo Classes\.jnlp�L�[�̃��W�X�g���f�[�^��export���܂�
    reg export HKCU\Software\Classes\.jnlp %CURDIR%\jnlp_ext_BkUp.reg
) ELSE (
    echo Classes\.jnlp�L�[��Portable�p�ɐݒ肵�܂�
    reg add HKCU\Software\Classes\.jnlp /ve /t REG_SZ /d "jnlp_auto_file"
)
echo *************************************
echo .jnlp\UserChoise�L�[�̑��݃`�F�b�N
echo *************************************
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /s
IF %ERRORLEVEL% == 0 (
    echo FileExts\.jnlp�L�[�̃��W�X�g���f�[�^��export���܂�
    reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp %CURDIR%\jnlp_userchoice_BkUp.reg
    echo FileExts\.jnlp\UserChoice�L�[�����݂���ꍇ�͕ύX�ł��Ȃ��̂Őݒ�l�𗘗p���܂�
) ELSE (
    echo FileExts\.jnlp�L�[��Portable�p�ɐݒ肵�܂�
    reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /v ProgId /t REG_SZ /d "jnlp_auto_file"
)
IF %SERVER% == 1 (
    echo **************************************************
    echo App Inventor Server���N�����܂�
    echo **************************************************
    start /MIN %~dp0\AI4A\AppEngine\startAI.cmd
    echo **************************************************
    echo Build Server���N�����܂�
    echo **************************************************
    IF NOT "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
        start /MIN %~dp0\AI4A\BuildServer\launch-buildserver32.cmd
    ) ELSE (
        start /MIN %~dp0\AI4A\BuildServer\launch-buildserver.cmd
    )
)
echo **************************************************
echo App Inventor Portable�̐ݒ肪�������܂���
echo �@�@�@�@�@�@�@USB����App Inventor�����p�\�ł�
echo �S�Ă̍�Ƃ��I�����A
echo �ݒ肵�����e�����ɖ߂��ɂ͉����L�[�������Ă�������
echo **************************************************
pause
:END
set PATH=%STPATH%
set JAVA_HOME=
echo *************************************
echo JavaWebStart�̊֘A�t�����������܂�
echo *************************************
IF EXIST %CURDIR%\jnlp_userchoice_BkUp.reg (
    echo FileExts\.jnlp�L�[��export�f�[�^���폜���܂�
    REM reg import %CURDIR%\jnlp_userchoice_BkUp.reg
    del %CURDIR%\jnlp_userchoice_BkUp.reg
) ELSE (
    echo .jnlp\UserChoice�L�[�̃��W�X�g���f�[�^���������܂�
    reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /f
)
IF EXIST %CURDIR%\jnlp_ext_BkUp.reg (
    echo .jnlp�L�[��export�f�[�^���폜���܂�
    REM reg import %CURDIR%\jnlp_ext_BkUp.reg
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
taskkill /f /im adb.exe
echo *************************************
echo AppInventor���s���ݒ���������܂���
echo *************************************
pause
