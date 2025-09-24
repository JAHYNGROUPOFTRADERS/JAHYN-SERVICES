# JAHYN SERVICES - Email Notification Setup

## Overview
The admin dashboard sends automatic email notifications to `techtitans105@gmail.com` for:
- New provider registrations
- New service bookings
- Emergency requests
- System alerts

## Email Configuration

### 1. Gmail Setup (Recommended)
1. Go to your Gmail account settings
2. Enable 2-factor authentication (2FA)
3. Generate an App Password:
   - Go to Google Account settings
   - Security → 2-Step Verification → App passwords
   - Generate a password for "Mail"
   - Use this 16-character password (not your regular password)

### 2. Environment Variables
Create or update your `.env` file with:

```env
EMAIL_USER=your-gmail@gmail.com
EMAIL_PASSWORD=your-16-character-app-password
```

**Example:**
```env
EMAIL_USER=techtitans105@gmail.com
EMAIL_PASSWORD=abcd-efgh-ijkl-mnop
```

### 3. Security Notes
- Never share your app password
- Use app passwords instead of your main password
- The app password is specific to this application

## Testing Email Notifications

1. Start your Flask app: `python3 app.py`
2. Register a new provider through the website
3. Check your email (`techtitans105@gmail.com`) for notifications

## Troubleshooting

### Common Issues:
1. **"Authentication failed"**: Check your app password
2. **"Less secure app blocked"**: Use app passwords instead
3. **Emails not sending**: Verify environment variables are loaded

### Alternative Email Providers
If you prefer not to use Gmail, you can modify the SMTP settings in `app.py`:

```python
# For Outlook/Hotmail
SMTP_SERVER = 'smtp-mail.outlook.com'
SMTP_PORT = 587

# For Yahoo
SMTP_SERVER = 'smtp.mail.yahoo.com'
SMTP_PORT = 587
```

## Email Template
Notifications are sent in HTML format with:
- Subject: "JAHYN SERVICES - [Event Type]"
- Styled HTML body with event details
- Sender: Your configured email address
- Recipient: techtitans105@gmail.com

## Privacy & Security
- Emails contain only necessary business information
- No sensitive customer data is transmitted
- All emails are sent securely via SMTP with TLS encryption