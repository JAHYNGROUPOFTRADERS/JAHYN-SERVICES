@echo off
echo 🚀 Starting JAHYN SERVICES local server...
echo Make sure your Flask app is running on port 5000
echo If not running, start it with: python3 app.py
echo.
echo 🔗 Starting ngrok tunnel for port 5000...
echo This will create a public URL that anyone can access
echo.
ngrok http 5000
echo.
echo 🛑 Press Ctrl+C to stop the tunnel
pause