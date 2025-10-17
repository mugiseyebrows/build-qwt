@echo off
rem This file is generated from build-mingw.pbat, all edits will be lost
set PATH=C:\mingw1310_64\bin;C:\Program Files\7-Zip;C:\Program Files\Git\cmd;C:\Qt\6.10.0\mingw_64\bin;%PATH%
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH (
echo PATCH not found
exit /b
)
if exist "C:\Program Files\Git\mingw32\bin\curl.exe" set CURL=C:\Program Files\Git\mingw32\bin\curl.exe
if exist "C:\Program Files\Git\mingw64\bin\curl.exe" set CURL=C:\Program Files\Git\mingw64\bin\curl.exe
if exist "C:\Windows\System32\curl.exe" set CURL=C:\Windows\System32\curl.exe
if not defined CURL (
echo CURL not found
exit /b
)
if exist C:\mingw1310_64\bin\gcc.exe goto mingw_end
if not exist winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z (
    echo downloading winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
    "%CURL%" -L -o winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z https://github.com/brechtsanders/winlibs_mingw/releases/download/13.1.0-16.0.5-11.0.0-ucrt-r5/winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
)
7z rn winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z mingw64 mingw1310_64
if not exist C:\mingw1310_64\bin\gcc.exe 7z x -y -oC:\ winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
:mingw_end
if exist C:\Qt\6.10.0\mingw_64\bin\qmake.exe goto qt_end
if not exist Qt-6.10.0-mingw13.7z (
    echo downloading Qt-6.10.0-mingw13.7z
    "%CURL%" -L -o Qt-6.10.0-mingw13.7z https://github.com/mugiseyebrows/build-qt/releases/download/6.10.0/Qt-6.10.0-mingw13.7z
)
7z x -y -oC:\Qt\6.10.0 Qt-6.10.0-mingw13.7z
:qt_end
set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not exist qwt git clone -b qwt-6.3 https://git.code.sf.net/p/qwt/git qwt
pushd qwt
    "%PATCH%" -N -i ../0001-QWT_INSTALL_PREFIX.patch
    "%PATCH%" -N -i ../0001-no-examples.patch
popd
pushd qwt
    qmake
    mingw32-make
    mingw32-make install
popd