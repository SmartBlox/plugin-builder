@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Minecraft Plugin Builder - Quick Start
echo ========================================
echo.

echo Checking if Go is installed...
go version >nul 2>&1
if %errorlevel% neq 0 (
    echo Go is not installed!
    echo.
    echo Please install Go from: https://go.dev/doc/install
    echo After installation, restart this script.
    echo.
    pause
    exit /b 1
)

echo Go is installed! Checking version...
go version
echo.

echo Checking if Node.js is installed...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is not installed!
    echo.
    echo Please install Node.js from: https://nodejs.org/
    echo After installation, restart this script.
    echo.
    pause
    exit /b 1
)

echo Node.js is installed! Checking version...
node --version
echo.

echo Checking npm version...
npm --version
echo.

echo ========================================
echo Installing Frontend Dependencies
echo ========================================
echo.

echo Cleaning previous installation...
cd kite-web
if exist node_modules (
    echo Removing old node_modules...
    rmdir /s /q node_modules
)
if exist package-lock.json (
    echo Removing old package-lock.json...
    del package-lock.json
)

echo Installing dependencies with legacy peer deps (reduces warnings)...
call npm install --legacy-peer-deps
if %errorlevel% neq 0 (
    echo Failed to install frontend dependencies!
    echo Trying alternative installation method...
    call npm install --force
    if %errorlevel% neq 0 (
        echo Failed to install frontend dependencies!
        echo.
        echo Please check the error messages above.
        echo Common solutions:
        echo 1. Make sure you have Node.js 18+ installed
        echo 2. Try running as Administrator
        echo 3. Check your internet connection
        echo.
        pause
        exit /b 1
    )
)

echo Building frontend...
call npm run build
if %errorlevel% neq 0 (
    echo Failed to build frontend!
    echo This might be due to TypeScript errors or missing dependencies.
    echo Check the error messages above.
    echo.
    pause
    exit /b 1
)
cd ..

echo.
echo ========================================
echo Installing Backend Dependencies
echo ========================================
echo.

echo Installing backend dependencies...
cd kite-service
call go mod download
if %errorlevel% neq 0 (
    echo Failed to install backend dependencies!
    echo.
    echo Please check the error messages above.
    echo Common solutions:
    echo 1. Make sure you have Go 1.22+ installed
    echo 2. Check your internet connection
    echo 3. Try running: go clean -modcache
    echo.
    pause
    exit /b 1
)

echo Setting up configuration...
echo Copying config file...
copy ..\kite.toml kite.toml
if %errorlevel% neq 0 (
    echo WARNING: Could not copy config file, using default
) else (
    echo Config file copied successfully!
)
echo.

echo Setting up database...
echo Note: This requires PostgreSQL to be running on localhost:5432
echo If you don't have PostgreSQL, you can:
echo 1. Install it from https://www.postgresql.org/download/windows/
echo 2. Or use Docker: docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:15
echo.
call go run main.go database migrate postgres up
if %errorlevel% neq 0 (
    echo Failed to set up database!
    echo Make sure PostgreSQL is running on localhost:5432
    echo You can skip this step if you don't need database features.
    echo.
    set /p continue="Continue without database? (y/n): "
    if /i not "%continue%"=="y" (
        pause
        exit /b 1
    )
)

echo.
echo ========================================
echo Starting Minecraft Plugin Builder...
echo ========================================
echo.
echo The application will be available at:
echo - Main Interface: http://localhost:8080
echo - Preview Server: http://localhost:8081
echo.
echo Press Ctrl+C to stop the server.
echo.

echo Starting server... (this may take a moment)
call go run main.go server start

echo.
echo Server stopped. Press any key to exit...
pause >nul 