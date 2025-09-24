# JAHYN SERVICES - Deployment Guide

## Supabase Setup (Required)

### 1. Create Supabase Account
1. Go to https://supabase.com/
2. Create a free account
3. Create a new project

### 2. Set up Database
1. Go to SQL Editor in Supabase dashboard
2. Run the `supabase_schema.sql` file to create tables and sample data
3. Go to Settings > API to get your project URL and anon key

### 3. Configure Environment Variables
1. Update `.env` file with your Supabase credentials:
   ```
   SUPABASE_URL=https://your-project.supabase.co
   SUPABASE_KEY=your-anon-key-here
   ```

## Local Development
1. Install requirements: `pip install -r requirements.txt`
2. Set up environment variables in `.env`
3. Run locally: `python app.py`
4. Open http://127.0.0.1:5000

## Deployment to PythonAnywhere

### Step 1: Create PythonAnywhere Account
1. Go to https://www.pythonanywhere.com/
2. Create a free account
3. Verify your email

### Step 2: Upload Files
1. Go to "Files" tab in PythonAnywhere dashboard
2. Upload all files from this project:
   - `app.py`
   - `requirements.txt`
   - `templates/index.html`
   - Any image files (logo, etc.)

### Step 3: Set up Web App
1. Go to "Web" tab
2. Click "Add a new web app"
3. Choose "Flask" and Python 3.10
4. Set the path to your app.py file (usually `/home/yourusername/app.py`)

### Step 4: Install Requirements
1. Go to "Consoles" tab
2. Open a Bash console
3. Run: `pip install -r requirements.txt`

### Step 5: Configure Static Files (if needed)
1. In Web tab, go to "Static Files"
2. Add static file mappings if you have images:
   - URL: `/static/`
   - Directory: `/home/yourusername/static/`

### Step 6: Reload Web App
1. Go back to "Web" tab
2. Click "Reload" button
3. Your site will be live at: `https://yourusername.pythonanywhere.com`

## 🌟 Features Included
- ✅ Complete service marketplace
- ✅ User registration and login
- ✅ Booking system
- ✅ Provider profiles
- ✅ Search and filtering
- ✅ Mobile responsive
- ✅ AI recommendations
- ✅ Payment integration ready
- ✅ Multi-language support
- ✅ Emergency booking
- ✅ Job board
- ✅ Newsletter signup
- ✅ App download section
- ✅ **Admin Dashboard** with real-time monitoring
- ✅ **Email Notifications** for all activities
- ✅ **Provider Resources** (Performance Dashboard, Safety Guidelines, Community Forum)
- ✅ **Modern UI/UX** with attractive gradients and animations
- ✅ **Real-time Statistics** and user management

## 🎯 Admin Dashboard
Access the professional admin panel at `/admin/dashboard` with:
- **Login:** `admin@gmail.com` / `admin@123`
- **Real-time Statistics:** User counts, bookings, ratings
- **User Management:** View and manage all users
- **Notifications:** Live activity feed
- **Email Settings:** Configure notification preferences

## 📧 Email Notifications
Automated email alerts sent to `techtitans105@gmail.com` for:
- New provider registrations
- New service bookings
- Emergency requests
- System activities

*Setup email configuration using `EMAIL_SETUP.md`*

## 🚀 Upload to GitHub
Follow the complete guide in `GITHUB_UPLOAD_GUIDE.md` to:
- Create GitHub repository
- Upload your project
- Share with the world

## 🎨 Provider Resources
Activated features for service providers:
- **Performance Dashboard:** Track earnings and ratings
- **Safety Guidelines:** Professional service standards
- **Community Forum:** Connect with other providers

## Customization
- Replace logo with your actual logo file
- Update contact information (done: +91 9555863867, techtitans105@gmail.com)
- Add real payment gateway integration
- Connect to Supabase for persistent data
- Configure email notifications