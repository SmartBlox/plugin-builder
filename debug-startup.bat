@echo off
echo ========================================
echo Minecraft Plugin Builder - DEBUG MODE
echo ========================================
echo.

echo Current directory: %CD%
echo.

echo Step 1: Checking Go installation...
go version
if %errorlevel% neq 0 (
    echo ERROR: Go is not installed or not in PATH
    pause
    exit /b 1
)
echo Go check passed!
echo.

echo Step 2: Checking Node.js installation...
node --version
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed or not in PATH
    pause
    exit /b 1
)
echo Node.js check passed!
echo.

echo Step 3: Checking npm installation...
npm --version
if %errorlevel% neq 0 (
    echo ERROR: npm is not installed or not in PATH
    pause
    exit /b 1
)
echo npm check passed!
echo.

echo Step 4: Checking if kite-web directory exists...
if not exist "kite-web" (
    echo ERROR: kite-web directory not found!
    echo Current directory contents:
    dir
    pause
    exit /b 1
)
echo kite-web directory found!
echo.

echo Step 5: Checking if kite-service directory exists...
if not exist "kite-service" (
    echo ERROR: kite-service directory not found!
    echo Current directory contents:
    dir
    pause
    exit /b 1
)
echo kite-service directory found!
echo.

echo Step 6: Installing frontend dependencies...
cd kite-web
echo Current directory: %CD%
echo.

echo Running: npm install --legacy-peer-deps
call npm install --legacy-peer-deps
if %errorlevel% neq 0 (
    echo ERROR: npm install failed!
    echo.
    echo Trying alternative method...
    call npm install --force
    if %errorlevel% neq 0 (
        echo ERROR: npm install failed with both methods!
        pause
        exit /b 1
    )
)
echo npm install completed!
echo.

echo Step 7: Building frontend...
echo Running: npm run build
call npm run build
if %errorlevel% neq 0 (
    echo ERROR: npm build failed!
    pause
    exit /b 1
)
echo Frontend build completed!
cd ..
echo.

echo Step 8: Installing backend dependencies...
cd kite-service
echo Current directory: %CD%
echo.

echo Running: go mod download
call go mod download
if %errorlevel% neq 0 (
    echo ERROR: go mod download failed!
    pause
    exit /b 1
)
echo Backend dependencies installed!
echo.

echo Step 9: Setting up configuration...
echo Copying config file...
copy ..\kite.toml kite.toml
if %errorlevel% neq 0 (
    echo WARNING: Could not copy config file, using default
) else (
    echo Config file copied successfully!
)
echo.

echo Step 10: Starting the server...
echo Running: go run main.go server start
echo.
echo The application should be available at:
echo - Main Interface: http://localhost:8080
echo - Preview Server: http://localhost:8081
echo.
echo Press Ctrl+C to stop the server.
echo.

call go run main.go server start

echo.
echo Server stopped. Press any key to exit...
pause >nul 