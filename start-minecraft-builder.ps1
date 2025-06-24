# Minecraft Plugin Builder - PowerShell Quick Start Script
# Run this script in PowerShell as Administrator if needed

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Minecraft Plugin Builder - Quick Start" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Go is installed
Write-Host "Checking if Go is installed..." -ForegroundColor Yellow
try {
    $goVersion = go version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Go is installed!" -ForegroundColor Green
        Write-Host $goVersion -ForegroundColor Gray
    } else {
        throw "Go not found"
    }
} catch {
    Write-Host "✗ Go is not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Go from: https://go.dev/doc/install" -ForegroundColor Yellow
    Write-Host "After installation, restart this script." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""

# Check if Node.js is installed
Write-Host "Checking if Node.js is installed..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Node.js is installed!" -ForegroundColor Green
        Write-Host $nodeVersion -ForegroundColor Gray
    } else {
        throw "Node.js not found"
    }
} catch {
    Write-Host "✗ Node.js is not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Node.js from: https://nodejs.org/" -ForegroundColor Yellow
    Write-Host "After installation, restart this script." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""

# Check npm version
Write-Host "Checking npm version..." -ForegroundColor Yellow
try {
    $npmVersion = npm --version 2>$null
    Write-Host "npm version: $npmVersion" -ForegroundColor Gray
} catch {
    Write-Host "Warning: Could not determine npm version" -ForegroundColor Yellow
}

Write-Host ""

# Frontend Installation
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Frontend Dependencies" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Set-Location "kite-web"

# Clean previous installation
Write-Host "Cleaning previous installation..." -ForegroundColor Yellow
if (Test-Path "node_modules") {
    Write-Host "Removing old node_modules..." -ForegroundColor Gray
    Remove-Item -Recurse -Force "node_modules" -ErrorAction SilentlyContinue
}
if (Test-Path "package-lock.json") {
    Write-Host "Removing old package-lock.json..." -ForegroundColor Gray
    Remove-Item "package-lock.json" -ErrorAction SilentlyContinue
}

# Install dependencies with reduced warnings
Write-Host "Installing dependencies (this may take a few minutes)..." -ForegroundColor Yellow
Write-Host "Note: Some npm warnings are normal and can be ignored." -ForegroundColor Gray

$installResult = npm install --legacy-peer-deps --no-audit --no-fund 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "First installation attempt failed, trying alternative method..." -ForegroundColor Yellow
    $installResult = npm install --force --no-audit --no-fund 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ Failed to install frontend dependencies!" -ForegroundColor Red
        Write-Host "Error output:" -ForegroundColor Red
        Write-Host $installResult -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}

Write-Host "✓ Dependencies installed successfully!" -ForegroundColor Green

# Build frontend
Write-Host "Building frontend..." -ForegroundColor Yellow
$buildResult = npm run build 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to build frontend!" -ForegroundColor Red
    Write-Host "This might be due to TypeScript errors or missing dependencies." -ForegroundColor Yellow
    Write-Host "Error output:" -ForegroundColor Red
    Write-Host $buildResult -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "✓ Frontend built successfully!" -ForegroundColor Green
Set-Location ".."

Write-Host ""

# Backend Installation
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Backend Dependencies" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Set-Location "kite-service"

# Install Go dependencies
Write-Host "Installing backend dependencies..." -ForegroundColor Yellow
$goModResult = go mod download 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to install backend dependencies!" -ForegroundColor Red
    Write-Host "Error output:" -ForegroundColor Red
    Write-Host $goModResult -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "✓ Backend dependencies installed successfully!" -ForegroundColor Green

# Setup configuration
Write-Host "Setting up configuration..." -ForegroundColor Yellow
Write-Host "Copying config file..." -ForegroundColor Gray
try {
    Copy-Item "..\kite.toml" "kite.toml" -ErrorAction Stop
    Write-Host "✓ Config file copied successfully!" -ForegroundColor Green
} catch {
    Write-Host "⚠ Warning: Could not copy config file, using default" -ForegroundColor Yellow
}

Write-Host ""

# Database setup
Write-Host "Setting up database..." -ForegroundColor Yellow
Write-Host "Note: This requires PostgreSQL to be running on localhost:5432" -ForegroundColor Gray
Write-Host "If you don't have PostgreSQL, you can:" -ForegroundColor Gray
Write-Host "1. Install it from https://www.postgresql.org/download/windows/" -ForegroundColor Gray
Write-Host "2. Or use Docker: docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:15" -ForegroundColor Gray
Write-Host ""

$dbResult = go run main.go database migrate postgres up 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to set up database!" -ForegroundColor Red
    Write-Host "Make sure PostgreSQL is running on localhost:5432" -ForegroundColor Yellow
    Write-Host "You can skip this step if you don't need database features." -ForegroundColor Gray
    Write-Host ""
    $continue = Read-Host "Continue without database? (y/n)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        Read-Host "Press Enter to exit"
        exit 1
    }
} else {
    Write-Host "✓ Database setup completed!" -ForegroundColor Green
}

Write-Host ""

# Start the application
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Starting Minecraft Plugin Builder..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "The application will be available at:" -ForegroundColor Green
Write-Host "- Main Interface: http://localhost:8080" -ForegroundColor White
Write-Host "- Preview Server: http://localhost:8081" -ForegroundColor White
Write-Host ""
Write-Host "Press Ctrl+C to stop the server." -ForegroundColor Yellow
Write-Host ""

# Start the server
go run main.go server start 