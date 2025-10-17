@echo off
rem This file is generated from build-msvc.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;C:\Program Files\Git\cmd;C:\Qt\6.10.0\msvc2020_64\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build;%PATH%
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH (
echo PATCH not found
exit /b
)
echo 1
if exist C:\Qt\6.10.0\msvc2020_64\bin\qmake.exe goto qt_end
if not exist Qt-6.10.0-msvc2020.7z (
    echo downloading Qt-6.10.0-msvc2020.7z
    curl -L -o Qt-6.10.0-msvc2020.7z https://github.com/mugiseyebrows/build-qt/releases/download/6.10.0/Qt-6.10.0-msvc2020.7z
)
7z x -y -oC:\Qt\6.10.0 Qt-6.10.0-msvc2020.7z
:qt_end
set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not exist qwt git clone -b qwt-6.3 https://git.code.sf.net/p/qwt/git qwt
pushd qwt
    "%PATCH%" -N -i ../0001-QWT_INSTALL_PREFIX.patch
    "%PATCH%" -N -i ../0001-no-examples.patch
    "%PATCH%" -N -i ../0001-release-build.patch
popd
call vcvars64.bat
pushd qwt
    qmake
    nmake
    nmake install
popd
7z a -y Qwt-6.3.1-Qt-6.10.0-msvc2020.7z C:\Qwt-6.3.1-Qt-6.10.0