# JAHYN SERVICES - Ngrok Setup Instructions

## What is Ngrok?
Ngrok creates a secure tunnel from your local computer to the internet, allowing anyone to access your local Flask app from anywhere in the world.

## Prerequisites
1. **Install ngrok**: Download from https://ngrok.com/download
2. **Sign up for ngrok account** (free tier available)
3. **Get your auth token** from ngrok dashboard

## Setup Steps

### 1. Install and Configure Ngrok
```bash
# After downloading ngrok, configure it
ngrok config add-authtoken YOUR_AUTH_TOKEN_HERE
```

### 2. Start Your Local Server
Your Flask app runs on port 5000. Make sure it's running:
```bash
python3 app.py
```

### 3. Run the Ngrok Script
Use the provided `run_ngrok.bat` script:
```bash
run_ngrok.bat
```

Or manually:
```bash
ngrok http 5000
```

## What Happens Next

Ngrok will generate a public URL like:
```
https://abcd1234.ngrok-free.app
```

Anyone with this URL can access your JAHYN SERVICES website from anywhere in the world.

## Important Notes

- **Free tier limitations**: URLs change each time you restart ngrok
- **Security**: Don't share sensitive information over free ngrok tunnels
- **Port**: Make sure your Flask app is running on port 5000

## Troubleshooting

- If ngrok doesn't start: Check if port 5000 is available
- If Flask app isn't running: Start it with `python3 app.py`
- If auth token issues: Re-run `ngrok config add-authtoken`

## For Production Deployment

For permanent hosting, consider:
- Heroku
- DigitalOcean
- AWS
- PythonAnywhere (mentioned in your README)

This ngrok setup is perfect for testing and sharing your work during development!