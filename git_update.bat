@echo off
:: Enable UTF-8 encoding
chcp 65001 > nul
setlocal enabledelayedexpansion

echo ==========================================
echo       SW-SJ-BIRIYANI GIT UPDATE TOOL
echo ==========================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed or not in PATH.
    echo Please install Git from https://git-scm.com/
    pause
    exit /b 1
)

:: Git Status
echo Checking current status...
git status
echo.

:: Prompt for commit message
set /p commit_msg="Enter commit message (or press Enter for 'Auto Update'): "
if "%commit_msg%"=="" (
    set commit_msg=Auto Update
)

:: Stage all files
echo.
echo Staging all changes...
git add .

:: Commit
echo.
echo Committing changes...
git commit -m "%commit_msg%"

:: Check current branch name
for /f "tokens=*" %%i in ('git branch --show-current') do set branch=%%i
if "%branch%"=="" (
    set branch=main
)

:: Push changes
echo.
echo Pushing to remote (branch: %branch%)...
git push -u origin %branch%

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] Git repository updated successfully!
) else (
    echo.
    echo [ERROR] Git push failed. Please check your internet connection or git credentials.
)

echo.
pause
