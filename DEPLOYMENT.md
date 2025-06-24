# 🚀 Deployment Guide - Minecraft Plugin Builder

## Quick Deploy Options (No Local Setup Required)

### Option 1: Railway (Recommended - Easiest)

Railway is perfect for full-stack applications and has a generous free tier.

1. **Sign up for Railway**: https://railway.app/
2. **Connect your GitHub repository**
3. **Deploy automatically**:
   - Railway will detect the `railway.json` file
   - It will automatically build and deploy your app
   - No configuration needed!

**Benefits**:
- ✅ Free tier with 500 hours/month
- ✅ Automatic deployments from GitHub
- ✅ Built-in database support
- ✅ Custom domains
- ✅ SSL certificates included

### Option 2: Render (Great Alternative)

Render offers a free tier and is very developer-friendly.

1. **Sign up for Render**: https://render.com/
2. **Create a new Web Service**
3. **Connect your GitHub repository**
4. **Configure the service**:
   - **Build Command**: `cd kite-web && npm install && npm run build && cd ../kite-service && go mod download`
   - **Start Command**: `cd kite-service && go run main.go server start`
   - **Environment**: Go

**Benefits**:
- ✅ Free tier available
- ✅ Automatic deployments
- ✅ Built-in database support
- ✅ Custom domains

### Option 3: Vercel (Frontend + API Routes)

Vercel is great for frontend applications with serverless backend.

1. **Sign up for Vercel**: https://vercel.com/
2. **Import your GitHub repository**
3. **Deploy automatically**

**Note**: Vercel works best for frontend-heavy applications. For full-stack apps, Railway or Render are better.

### Option 4: Heroku (Classic Choice)

Heroku is a well-established platform with good Go support.

1. **Sign up for Heroku**: https://heroku.com/
2. **Install Heroku CLI**
3. **Deploy**:
   ```bash
   heroku create your-app-name
   git push heroku main
   ```

## Database Setup

### Option A: Use Built-in Database (Railway/Render)
Both Railway and Render offer PostgreSQL databases:
- Railway: Add a PostgreSQL service to your project
- Render: Create a PostgreSQL database service

### Option B: External Database
- **Supabase** (Free tier): https://supabase.com/
- **PlanetScale** (Free tier): https://planetscale.com/
- **Neon** (Free tier): https://neon.tech/

## Environment Variables

Set these in your deployment platform:

```env
# Database (if using external database)
DATABASE_URL=postgresql://username:password@host:port/database

# Application URLs (update with your domain)
KITE_APP__PUBLIC_BASE_URL=https://your-app.railway.app
KITE_API__PUBLIC_BASE_URL=https://your-app.railway.app

# Optional: OpenAI API (for AI features)
OPENAI_API_KEY=your_openai_key
```

## Step-by-Step Railway Deployment

1. **Go to Railway**: https://railway.app/
2. **Sign up with GitHub**
3. **Click "New Project"**
4. **Select "Deploy from GitHub repo"**
5. **Choose your repository**
6. **Railway will automatically detect the configuration**
7. **Add a PostgreSQL database** (optional but recommended)
8. **Your app will be deployed automatically!**

## Step-by-Step Render Deployment

1. **Go to Render**: https://render.com/
2. **Sign up with GitHub**
3. **Click "New +" → "Web Service"**
4. **Connect your repository**
5. **Configure**:
   - **Name**: minecraft-plugin-builder
   - **Environment**: Go
   - **Build Command**: `cd kite-web && npm install && npm run build && cd ../kite-service && go mod download`
   - **Start Command**: `cd kite-service && go run main.go server start`
6. **Click "Create Web Service"**

## Troubleshooting Deployment

### Common Issues:

1. **Build fails**:
   - Check that Node.js and Go are properly configured
   - Ensure all dependencies are in package.json and go.mod

2. **Database connection fails**:
   - Make sure database URL is correct
   - Check if database service is running

3. **Port issues**:
   - Use `PORT` environment variable (platforms set this automatically)
   - Update config to use `0.0.0.0` instead of `127.0.0.1`

### Getting Help:

- **Railway Discord**: https://discord.gg/railway
- **Render Community**: https://community.render.com/
- **Vercel Support**: https://vercel.com/support

## Cost Comparison

| Platform | Free Tier | Paid Plans |
|----------|-----------|------------|
| Railway | 500 hours/month | $5/month |
| Render | 750 hours/month | $7/month |
| Vercel | 100GB bandwidth | $20/month |
| Heroku | 550-1000 hours/month | $7/month |

## Recommendation

**Start with Railway** - it's the easiest to set up and has the best free tier for full-stack applications like this one.

---

**Need help?** Check the platform-specific documentation or ask in their community forums! 