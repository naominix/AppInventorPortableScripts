REM AppInventor Portable for Windows(64bit)
@echo off
NET SESSION > NUL 2>&1
IF %ERRORLEVEL% == 0 (
    ECHO �Ǘ��҂Ƃ��Ď��s��. AppInventor���N�����܂�.
    GOTO START
) ELSE (
    ECHO �Ǘ��҂Ƃ��Ď��s���Ă��܂���. AppInventor���Z�b�g�A�b�v���N���ł��܂���. �E�N���b�N�Łu�Ǘ��҂Ƃ��Ď��s�v�ŋN�����Ă������� >&2
    PAUSE
    EXIT /B 1
)
:START
set JAVA_HOME=%~dp0\jdk1.6.0_37
set STPATH=%PATH%
set PATH=%JAVA_HOME%\bin;%PATH%
assoc .jnlp=JNLPFile
ftype JNLPFile="%JAVA_HOME%\jre\bin\javaws.exe" "%%1"
mklink /D "C:\Program Files\AppInventor" %~dp0\AppInventor
pause
rmdir "C:\Program Files\AppInventor" 
set PATH=%STPATH%
set JAVA_HOME=
ftype JNLPFile=
assoc .jnlp=
