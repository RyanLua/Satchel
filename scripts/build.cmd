@echo off
setlocal enabledelayedexpansion

echo Building Rojo projects...

set "BUILD_DIR=builds"
set "OUTPUT_NAME=Satchel"
set "BUILD_PROJECT=package.project.json"

REM Setup build directory
echo Cleaning up build directory...
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
mkdir "%BUILD_DIR%"
cd "%BUILD_DIR%"

REM Build .rbxm file
rojo build --output "%BUILD_DIR%\%OUTPUT_NAME%.rbxm" ..\%BUILD_PROJECT%

REM Build .rbxmx file
rojo build --output "%BUILD_DIR%\%OUTPUT_NAME%.rbxmx" ..\%BUILD_PROJECT%

echo Build completed successfully!
cd ..