@echo off
echo Testing Go installation...
echo.

echo Current directory: %CD%
echo.

echo Testing go version:
go version
echo Error level: %errorlevel%
echo.

echo Testing go mod download:
cd kite-service
go mod download
echo Error level: %errorlevel%
echo.

echo Testing go run main.go --help:
go run main.go --help
echo Error level: %errorlevel%
echo.

echo Testing go run main.go server --help:
go run main.go server --help
echo Error level: %errorlevel%
echo.

echo Test complete. Press any key to exit...
pause >nul 