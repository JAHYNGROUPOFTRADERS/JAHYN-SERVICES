from flask import Flask, send_from_directory, render_template, request, jsonify
import os
from supabase import create_client, Client
from dotenv import load_dotenv
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import threading

load_dotenv()

app = Flask(__name__)

# Email configuration
ADMIN_EMAIL = 'techtitans105@gmail.com'
SMTP_SERVER = 'smtp.gmail.com'
SMTP_PORT = 587
# Note: In production, use environment variables for email credentials
EMAIL_USER = os.getenv('EMAIL_USER', 'your-email@gmail.com')
EMAIL_PASSWORD = os.getenv('EMAIL_PASSWORD', 'your-app-password')

def send_admin_notification(subject, message):
    """Send email notification to admin"""
    def send_email():
        try:
            msg = MIMEMultipart()
            msg['From'] = EMAIL_USER
            msg['To'] = ADMIN_EMAIL
            msg['Subject'] = f"JAHYN SERVICES - {subject}"

            body = f"""
            <html>
            <body>
                <h2>JAHYN SERVICES Notification</h2>
                <p>{message}</p>
                <hr>
                <p><small>This is an automated notification from JAHYN SERVICES admin panel.</small></p>
            </body>
            </html>
            """

            msg.attach(MIMEText(body, 'html'))

            server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
            server.starttls()
            server.login(EMAIL_USER, EMAIL_PASSWORD)
            text = msg.as_string()
            server.sendmail(EMAIL_USER, ADMIN_EMAIL, text)
            server.quit()

            print(f"Admin notification sent: {subject}")

        except Exception as e:
            print(f"Failed to send admin notification: {e}")

    # Send email in background thread to not block the response
    threading.Thread(target=send_email).start()

# Supabase configuration
SUPABASE_URL = os.getenv('SUPABASE_URL')
SUPABASE_KEY = os.getenv('SUPABASE_KEY')
supabase: Client = None
try:
    if SUPABASE_URL and SUPABASE_KEY and not SUPABASE_URL.startswith('your_') and not SUPABASE_KEY.startswith('your_'):
        supabase = create_client(SUPABASE_URL, SUPABASE_KEY)
except Exception as e:
    print(f"Supabase connection failed: {e}")
    supabase = None

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/<path:path>')
def static_files(path):
    return send_from_directory('.', path)

# API endpoints for services
@app.route('/api/services', methods=['GET'])
def get_services():
    if supabase is None:
        return jsonify({'error': 'Supabase not configured'}), 500
    try:
        response = supabase.table('services').select('*').execute()
        return jsonify(response.data)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/services', methods=['POST'])
def add_service():
    if supabase is None:
        return jsonify({'error': 'Supabase not configured'}), 500
    try:
        data = request.json
        response = supabase.table('services').insert(data).execute()
        return jsonify(response.data), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# API endpoints for providers
@app.route('/api/providers', methods=['GET'])
def get_providers():
    if supabase is None:
        return jsonify({'error': 'Supabase not configured'}), 500
    try:
        response = supabase.table('providers').select('*').execute()
        return jsonify(response.data)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/providers', methods=['POST'])
def add_provider():
    if supabase is None:
        return jsonify({'error': 'Supabase not configured'}), 500
    try:
        data = request.json
        response = supabase.table('providers').insert(data).execute()

        # Send admin notification for new provider registration
        send_admin_notification(
            'New Provider Registration',
            f'New provider registered: {data.get("name", "Unknown")} ({data.get("email", "No email")})<br>'
            f'Service: {data.get("service_category", "Not specified")}<br>'
            f'Location: {data.get("city", "Unknown")}, {data.get("state", "Unknown")}<br>'
            f'Experience: {data.get("experience_years", "Not specified")} years'
        )

        return jsonify(response.data), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# API endpoints for bookings
@app.route('/api/bookings', methods=['GET'])
def get_bookings():
    if supabase is None:
        return jsonify({'error': 'Supabase not configured'}), 500
    try:
        response = supabase.table('bookings').select('*').execute()
        return jsonify(response.data)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/bookings', methods=['POST'])
def add_booking():
    if supabase is None:
        return jsonify({'error': 'Supabase not configured'}), 500
    try:
        data = request.json
        response = supabase.table('bookings').insert(data).execute()

        # Send admin notification for new booking
        send_admin_notification(
            'New Service Booking',
            f'New booking received from: {data.get("customer_name", "Unknown")} ({data.get("customer_email", "No email")})<br>'
            f'Service: {data.get("service_type", "Not specified")}<br>'
            f'Date: {data.get("booking_date", "Not specified")}<br>'
            f'Time: {data.get("booking_time", "Not specified")}<br>'
            f'Address: {data.get("address", "Not provided")}<br>'
            f'Payment: {data.get("payment_method", "Not specified")}'
        )

        return jsonify(response.data), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# API endpoints for locations
@app.route('/api/locations/states', methods=['GET'])
def get_states():
    if supabase is None:
        return jsonify({'error': 'Supabase not configured'}), 500
    try:
        response = supabase.table('locations').select('state').execute()
        states = list(set(item['state'] for item in response.data if item['state']))
        states.sort()
        return jsonify(states)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/locations/cities/<state>', methods=['GET'])
def get_cities_by_state(state):
    if supabase is None:
        return jsonify({'error': 'Supabase not configured'}), 500
    try:
        response = supabase.table('locations').select('city, district, village').eq('state', state.replace('-', ' ').title()).execute()
        locations = []
        for item in response.data:
            if item['city'] and item['city'] not in locations:
                locations.append(item['city'])
            if item['village'] and item['village'] not in locations:
                locations.append(item['village'])
        locations.sort()
        return jsonify(locations)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Admin routes
@app.route('/admin/login', methods=['POST'])
def admin_login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    # Check admin credentials
    if email == 'admin@gmail.com' and password == 'admin@123':
        return jsonify({'success': True, 'message': 'Admin login successful'})
    else:
        return jsonify({'success': False, 'message': 'Invalid admin credentials'}), 401

@app.route('/admin/dashboard')
def admin_dashboard():
    return render_template('admin_dashboard.html')

@app.route('/api/admin/stats', methods=['GET'])
def get_admin_stats():
    # Mock admin statistics - in real app, fetch from database
    stats = {
        'total_users': 1247,
        'total_providers': 387,
        'total_bookings': 2891,
        'avg_rating': 4.7
    }
    return jsonify(stats)

@app.route('/api/admin/users', methods=['GET'])
def get_admin_users():
    # Mock user data - in real app, fetch from database
    users = [
        {
            'name': 'Rajesh Kumar',
            'email': 'rajesh@example.com',
            'role': 'provider',
            'status': 'active',
            'joined': '2024-01-15'
        },
        {
            'name': 'Priya Sharma',
            'email': 'priya@example.com',
            'role': 'provider',
            'status': 'active',
            'joined': '2024-02-20'
        },
        {
            'name': 'Amit Singh',
            'email': 'amit@example.com',
            'role': 'provider',
            'status': 'active',
            'joined': '2024-03-10'
        },
        {
            'name': 'John Customer',
            'email': 'john@example.com',
            'role': 'customer',
            'status': 'active',
            'joined': '2024-04-05'
        }
    ]
    return jsonify(users)

@app.route('/api/admin/notifications', methods=['GET'])
def get_admin_notifications():
    # Mock notifications - in real app, fetch from database
    notifications = [
        {
            'type': 'booking',
            'title': 'New Booking',
            'message': 'Rajesh Kumar booked plumbing service',
            'time': '2 min ago'
        },
        {
            'type': 'user',
            'title': 'New User Registration',
            'message': 'Sarah Johnson joined as customer',
            'time': '15 min ago'
        },
        {
            'type': 'review',
            'title': 'New Review',
            'message': '5-star review for Priya Sharma',
            'time': '1 hour ago'
        },
        {
            'type': 'booking',
            'title': 'Emergency Booking',
            'message': 'Urgent AC repair requested',
            'time': '2 hours ago'
        }
    ]
    return jsonify(notifications)

if __name__ == '__main__':
    app.run(debug=True)