# 🚀 Quick Start Guide - Minecraft Plugin Builder

## Prerequisites

You need to install these tools first:

### 1. Install Go
- Download from: https://go.dev/doc/install
- Follow the Windows installation instructions
- Restart your terminal after installation

### 2. Install Node.js
- Download from: https://nodejs.org/
- Choose the LTS version (18.x or higher recommended)
- Restart your terminal after installation

### 3. Install PostgreSQL (Optional - for full features)
- Download from: https://www.postgresql.org/download/windows/
- Or use Docker: `docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:15`

## Quick Start Options

### Option 1: Use PowerShell Script (Recommended)
1. Right-click `start-minecraft-builder.ps1` and select "Run with PowerShell"
2. Or open PowerShell as Administrator and run: `.\start-minecraft-builder.ps1`
3. The script will handle npm warnings and start everything automatically
4. Open http://localhost:8080 in your browser

### Option 2: Use Batch Script
1. Double-click `start-minecraft-builder.bat`
2. The script will check dependencies and start everything automatically
3. Open http://localhost:8080 in your browser

### Option 3: Manual Setup
1. **Install dependencies:**
   ```bash
   # Frontend (with reduced warnings)
   cd kite-web
   npm install --legacy-peer-deps --no-audit --no-fund
   npm run build
   cd ..
   
   # Backend
   cd kite-service
   go mod download
   cd ..
   ```

2. **Start the application:**
   ```bash
   cd kite-service
   go run main.go server
   ```

3. **Start the preview server (in a new terminal):**
   ```bash
   cd kite-service
   go run cmd/preview/main.go
   ```

### Option 4: Use Docker (No Go installation needed)
1. Install Docker Desktop: https://www.docker.com/products/docker-desktop/
2. Run the application:
   ```bash
   docker-compose -f docker-compose.minecraft.yaml up
   ```

## About npm Warnings

**Don't worry about npm warnings!** They are common and usually not critical:

- **Deprecation warnings**: Some packages use older APIs but still work fine
- **Peer dependency warnings**: Normal for React/Next.js projects
- **Audit warnings**: Security notices that don't affect functionality

The installation scripts use these flags to reduce warnings:
- `--legacy-peer-deps`: Handles React peer dependencies
- `--no-audit`: Skips security audits during install
- `--no-fund`: Removes funding messages

## What You'll Get

After starting the application:

- **Main Interface**: http://localhost:8080
  - Visual flow editor for creating Minecraft plugins
  - Drag-and-drop interface
  - No coding required

- **Preview Server**: http://localhost:8081
  - Test your plugins in a simulated environment
  - Add test players
  - Simulate events

## First Steps

1. **Open the main interface** at http://localhost:8080
2. **Create a new plugin** by clicking "Create New Plugin"
3. **Add a Minecraft Event** node (drag from the left panel)
4. **Configure the event** (e.g., "Player Join")
5. **Add an action** (e.g., "Send Message to Player")
6. **Test your plugin** using the Preview button
7. **Export your plugin** as a JAR file

## Troubleshooting

### npm Warnings and Errors
- **"npm WARN" messages**: These are normal and can be ignored
- **"peer dependency" warnings**: Normal for React projects
- **Installation fails**: Try running the PowerShell script instead
- **Build fails**: Check that Node.js version is 18+ and npm version is 9+

### "go: command not found"
- Install Go from https://go.dev/doc/install
- Restart your terminal after installation

### "node: command not found"
- Install Node.js from https://nodejs.org/
- Restart your terminal after installation

### Database connection errors
- Make sure PostgreSQL is running on port 5432
- Or use Docker: `docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:15`
- You can skip database setup if you don't need persistent storage

### Port already in use
- Make sure ports 8080 and 8081 are not being used by other applications
- You can change ports in the configuration files

### PowerShell execution policy error
- Run PowerShell as Administrator
- Execute: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Then run the PowerShell script again

## Need Help?

- Check the full documentation in `MINECRAFT_PLUGIN_BUILDER.md`
- Look at the example flows in the application
- The preview system helps you test plugins before deployment

---

**Happy plugin building! 🎮✨** 