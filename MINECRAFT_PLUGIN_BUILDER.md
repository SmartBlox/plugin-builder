# 🎮 Minecraft Plugin Builder

Transform your Discord bot builder into a powerful Minecraft plugin creation tool! This system allows you to create Minecraft plugins using a visual flow editor, just like the original Discord bot builder.

## ✨ Features

### 🎯 **Visual Flow Editor**
- Drag-and-drop interface for creating plugin logic
- No coding required - everything is visual
- Real-time preview of your plugin structure

### 🎮 **Minecraft-Specific Nodes**
- **Commands**: Create custom Minecraft commands
- **Events**: Listen for player join, death, chat, block break, etc.
- **Actions**: Send messages, teleport players, give items, create effects
- **Conditions**: Check permissions, world, gamemode, etc.
- **Control Flow**: Loops, conditions, delays

### 🧪 **Preview System**
- Test your plugins in a simulated Minecraft environment
- Real-time event simulation
- Player management and interaction testing
- Server logs and debugging

### 📦 **Export System**
- Generate ready-to-use JAR files
- Compatible with Paper servers
- Automatic plugin.yml generation
- Proper Java code structure

## 🚀 Getting Started

### Prerequisites
- Node.js 18+ and npm
- Go 1.22+
- PostgreSQL database

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo>
   cd kite
   ```

2. **Install frontend dependencies**
   ```bash
   cd kite-web
   npm install
   ```

3. **Install backend dependencies**
   ```bash
   cd ../kite-service
   go mod download
   ```

4. **Set up the database**
   ```bash
   go run main.go database migrate postgres up
   ```

5. **Build the frontend**
   ```bash
   cd ../kite-web
   npm run build
   ```

6. **Start the main application**
   ```bash
   cd ../kite-service
   go run main.go server
   ```

### Starting the Preview Server

The preview server allows you to test your plugins:

```bash
cd kite-service
go run cmd/preview/main.go
```

The preview server will start on port 8081.

## 🎨 How to Use

### 1. **Create a New Plugin**

1. Open the web interface at `http://localhost:8080`
2. Click "Create New Plugin"
3. Give your plugin a name and description

### 2. **Design Your Plugin Logic**

#### **Adding Commands**
1. Drag a "Minecraft Command" node onto the canvas
2. Configure the command name and description
3. Add actions that will execute when the command is used

#### **Adding Event Listeners**
1. Drag a "Minecraft Event" node onto the canvas
2. Select the event type (player join, death, chat, etc.)
3. Add actions that will execute when the event occurs

#### **Available Actions**
- **Send Message**: Send chat messages, titles, or action bar text
- **Teleport Player**: Move players to specific locations
- **Give Item**: Give items to players (with enchantments)
- **World Effects**: Create lightning, explosions, particles
- **Player Management**: Kick, ban, or modify players

#### **Available Conditions**
- **Permission Check**: Verify if a player has a permission
- **World Check**: Check if a player is in a specific world
- **Gamemode Check**: Verify the player's gamemode

### 3. **Test Your Plugin**

1. Click the "Preview Plugin" button in the navigation
2. The preview server will open in a new window
3. Add test players and simulate events
4. Watch your plugin logic execute in real-time

### 4. **Export Your Plugin**

1. Click the "Export Plugin" button
2. Fill in the plugin details (name, version, author, description)
3. Click "Export Plugin" to download the JAR file
4. Upload the JAR to your Paper server's plugins folder

## 📋 Node Types

### Entry Nodes
- **Minecraft Command**: Triggers when a player uses `/commandname`
- **Minecraft Event**: Triggers on specific game events
- **Button**: Triggers when a UI button is clicked

### Action Nodes
- **Send Message**: `action_player_message`
- **Teleport Player**: `action_player_teleport`
- **Give Item**: `action_player_give_item`
- **Kick Player**: `action_player_kick`
- **Ban Player**: `action_player_ban`
- **World Effect**: `action_world_effect`

### Condition Nodes
- **Check Permission**: `condition_player_permission`
- **Check World**: `condition_player_world`
- **Check Gamemode**: `condition_player_gamemode`

### Control Nodes
- **Loop**: Repeat actions multiple times
- **Sleep**: Add delays between actions
- **Compare**: Compare values and branch logic

## 🎯 Example Plugins

### Welcome Plugin
1. Add a "Minecraft Event" node for "player_join"
2. Connect it to a "Send Message" action
3. Configure the message: "Welcome to the server, {{player_name}}!"

### Starter Kit Plugin
1. Add a "Minecraft Event" node for "player_join"
2. Add a condition to check if the player is new
3. If new, connect to "Give Item" actions for starter items

### Chat Filter Plugin
1. Add a "Minecraft Event" node for "player_chat"
2. Add conditions to check for inappropriate words
3. Connect to "Kick Player" or "Send Message" actions

## 🔧 Configuration

### Plugin Settings
- **Name**: The plugin's internal name
- **Version**: Plugin version number
- **Author**: Your name or organization
- **Description**: What the plugin does

### Preview Server Settings
- **Port**: Default 8081
- **Worlds**: Automatically creates "world" and "world_nether"
- **Players**: Simulated players for testing

## 🐛 Troubleshooting

### Preview Server Issues
- Make sure port 8081 is not in use
- Check that the preview server is running
- Verify the web interface can connect to the preview server

### Export Issues
- Ensure all required fields are filled in the export dialog
- Check that the plugin name follows Java naming conventions
- Verify the JAR file is generated correctly

### Flow Editor Issues
- Make sure all nodes are properly connected
- Check that required fields are filled in node configurations
- Verify that the flow logic makes sense

## 🚀 Deployment

### To a Paper Server
1. Export your plugin as a JAR file
2. Upload the JAR to your server's `plugins` folder
3. Restart the server
4. The plugin will automatically load and register commands

### Permissions
The generated plugin will include permission nodes:
- `pluginname.user` - Basic user permissions
- `pluginname.admin` - Administrative permissions

Configure these in your permission plugin (LuckPerms, PermissionsEx, etc.)

## 🔮 Future Features

- **More Events**: Additional Minecraft events
- **Advanced Actions**: More complex player and world interactions
- **Database Integration**: Persistent data storage
- **GUI Creation**: Visual interface builder for plugins
- **Multi-World Support**: Advanced world management
- **Economy Integration**: Built-in economy system support

## 🤝 Contributing

This is a transformation of the original Discord bot builder. To contribute:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Happy plugin building! 🎮✨** 