#!/bin/sh

## Program:   VMTK
## Module:    Anaconda Distribution
## Language:  Python
## Date:      January 30, 2018
##
##   Copyright (c) Richard Izzo, Luca Antiga, David Steinman. All rights reserved.
##   See LICENSE file for details.
##      This software is distributed WITHOUT ANY WARRANTY; without even
##      the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
##      PURPOSE.  See the above copyright notices for more information.
##
## Note: this script was contributed by
##       Richard Izzo (Github @rlizzo)
##       University at Buffalo
##
## This file contains the packaging and distribution shell script data for packaging
## VMTK via the Continuum Analytics Anaconda Python distribution.
## See https://www.continuum.io/ for distribution info

mkdir build
cd ./build

#if [[ $PY3K -eq 1 || $PY3K == "True" ]]; then
#  export PY_STR="${PY_VER}m"
#else
#  export PY_STR="${PY_VER}"
#fi


if [ `uname` = "Darwin" ]; then
    cmake .. -LAH -G "Ninja" \
    -Wno-dev \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="12.3" \
    -DCMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.3.sdk" \
    -DVMTK_BUILD_TESTING:BOOL=ON \
    -DCMAKE_BUILD_TYPE:STRING="Release" \
    -DVTK_LEGACY_SILENT:BOOL=OFF \
    -DITK_LEGACY_SILENT:BOOL=OFF \
    -DVTK_VMTK_USE_COCOA:BOOL=ON \
    -DVMTK_RENDERING_BACKEND:STRING="OpenGL2" \
    -DVMTK_USE_RENDERING:BOOL=ON \
    -DVTK_VMTK_CONTRIB:BOOL=ON \
    -DVMTK_CONTRIB_SCRIPTS:BOOL=ON \
    -DCMAKE_CXX_STANDARD=11 \
    -DCMAKE_CXX_STANDARD_REQUIRED=ON \
    -DUSE_SYSTEM_VTK:BOOL=ON \
    -DUSE_SYSTEM_ITK:BOOL=ON \
    -DCMAKE_CXX_EXTENSIONS=OFF \
    -DVMTK_USE_VTK9=ON \
    -DVMTK_USE_SUPERBUILD:BOOL=OFF \
    -DVMTK_USE_ITK5=ON \
    -DPYTHON_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
    -DPYTHON_LIBRARY=$(python3 -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))") \
    -DPYTHON_EXECUTABLE="/opt/homebrew/bin/python3" \
    -DVMTK_PYTHON_VERSION:STRING="python3" \
    -DVMTK_BREW_PYTHON:BOOL=ON \
    -DVMTK_VTK_WRAP_PYTHON:BOOL=OFF \
    -DVTK_VMTK_WRAP_PYTHON:BOOL=ON \
    -DVMTK_PYTHON_VERSION:STRING="python3" \
    -DPython3_FIND_STRATEGY=LOCATION \
    -DQt5_DIR="/opt/homebrew/opt/qt@5/lib/cmake/Qt5" \
    -DCMAKE_C_COMPILER=/opt/homebrew/opt/llvm/bin/clang\
    -DCMAKE_CXX_COMPILER=/opt/homebrew/opt/llvm/bin/clang++ \
    -DVTK_DIR="/opt/homebrew/Cellar/vtk/9.1.0_4/lib/cmake" \
    -DITK_DIR="/opt/homebrew/Cellar/itk/5.2.1_2/lib/cmake"

    # -DSUPERBUILD_INSTALL_PREFIX:STRING=${PREFIX} \
    # ninja install
    # -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    # -DVMTK_MODULE_INSTALL_LIB_DIR="$PREFIX"/vmtk \
    # -DINSTALL_PKGCONFIG_DIR="$PREFIX"/lib/pkgconfig \
fi

if [ `uname` = "Linux" ]; then
    cmake .. -LAH -G "Ninja" \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE:STRING="Release" \
    -DUSE_SYSTEM_VTK:BOOL=ON \
    -DUSE_SYSTEM_ITK:BOOL=ON \
    -DVMTK_BUILD_TESTING:BOOL=ON \
    -DSUPERBUILD_INSTALL_PREFIX:STRING=${PREFIX} \
    -DPython3_FIND_STRATEGY=LOCATION \
    -DPython3_ROOT_DIR=${PREFIX} \
    -DPython3_EXECUTABLE=${PREFIX}/bin/python \
    -DCMAKE_INSTALL_PREFIX:STRING=${PREFIX} \
    -DCMAKE_CXX_STANDARD=11 \
    -DCMAKE_CXX_STANDARD_REQUIRED=ON \
    -DCMAKE_CXX_EXTENSIONS=OFF \
    -DVMTK_MODULE_INSTALL_LIB_DIR:STRING="${PREFIX}/vmtk" \
    -DINSTALL_PKGCONFIG_DIR:STRING="${PREFIX}/lib/pkgconfig" \
    -DGIT_PROTOCOL_HTTPS:BOOL=ON \
    -DVMTK_USE_RENDERING:BOOL=ON \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DVMTK_MINIMAL_INSTALL:BOOL=OFF \
    -DVMTK_USE_VTK9:BOOL:BOOL=ON \
    -DVMTK_CONTRIB_SCRIPTS:BOOL=ON \
    -DVMTK_SCRIPTS_ENABLED:BOOL=ON \
    -DVMTK_ENABLE_DISTRIBUTION:BOOL=OFF \
    -DVMTK_WITH_LIBRARY_VERSION:BOOL=OFF \
    -DVMTK_USE_SUPERBUILD:BOOL=OFF \
    -DVTK_VMTK_WRAP_PYTHON:BOOL=ON \
    -DVMTK_PYTHON_VERSION:STRING="python${PY_VER}" \
    -DITK_LEGACY_SILENT:BOOL=ON \
    -DVTK_LEGACY_SILENT:BOOL=ON \
    -DCMAKE_CXX_STANDARD=11 \
    -DCMAKE_CXX_STANDARD_REQUIRED=ON \
    -DBUILD_DOCUMENTATION:BOOL=OFF 

    ninja install 
fi
