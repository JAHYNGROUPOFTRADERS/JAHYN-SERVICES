-- JAHYN SERVICES Database Schema for Supabase

-- Services table
CREATE TABLE services (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    icon VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Providers table
CREATE TABLE providers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    service_category VARCHAR(100),
    experience_years INTEGER,
    city VARCHAR(100),
    state VARCHAR(100),
    rating DECIMAL(3,2) DEFAULT 0,
    verified BOOLEAN DEFAULT FALSE,
    description TEXT,
    base_price DECIMAL(10,2),
    price_per_hour DECIMAL(10,2),
    membership_type VARCHAR(20) DEFAULT 'free' CHECK (membership_type IN ('free', 'premium')),
    profile_photo_url VARCHAR(500),
    availability_schedule JSONB,
    kyc_verified BOOLEAN DEFAULT FALSE,
    kyc_documents JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bookings table
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(20),
    provider_id INTEGER REFERENCES providers(id),
    service_type VARCHAR(100),
    booking_date DATE,
    booking_time VARCHAR(50),
    address TEXT,
    additional_details TEXT,
    payment_method VARCHAR(50),
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Reviews table
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    booking_id INTEGER REFERENCES bookings(id),
    provider_id INTEGER REFERENCES providers(id),
    customer_name VARCHAR(255),
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Locations table for Indian states, districts, cities, villages
CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    state VARCHAR(100) NOT NULL,
    district VARCHAR(100),
    city VARCHAR(100),
    village VARCHAR(100),
    pincode VARCHAR(10),
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Users table (for authentication)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255),
    user_type VARCHAR(50) CHECK (user_type IN ('customer', 'provider', 'admin')),
    verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert sample services data
INSERT INTO services (name, description, category, icon) VALUES
('Home Repairs', 'Plumbers, electricians, carpenters, and more for all your home repair needs.', 'home', 'fa-wrench'),
('Automotive', 'Car mechanics, drivers, and vehicle maintenance services.', 'automotive', 'fa-car'),
('Education', 'Tutors, teachers, and educational services for all age groups.', 'education', 'fa-graduation-cap'),
('Domestic Help', 'Cooks, cleaners, and household assistance services.', 'domestic', 'fa-utensils'),
('Health & Wellness', 'Nurses, physiotherapists, and wellness services.', 'health', 'fa-heartbeat'),
('Tech Support', 'Computer repair, software installation, and IT services.', 'tech', 'fa-laptop'),
('Events & Photography', 'Photographers, event planners, and entertainment services.', 'events', 'fa-camera'),
('Gardening', 'Gardeners, landscapers, and plant care services.', 'gardening', 'fa-leaf');

-- Insert sample providers data
INSERT INTO providers (name, email, phone, service_category, experience_years, city, state, rating, verified, description, base_price, price_per_hour, membership_type, kyc_verified) VALUES
('Rajesh Kumar', 'rajesh@example.com', '+91 98765-43210', 'Plumber', 8, 'Delhi', 'Delhi', 4.8, true, 'Experienced Plumber with 8+ years', 500.00, 300.00, 'premium', true),
('Priya Sharma', 'priya@example.com', '+91 87654-32109', 'Tutor', 5, 'Mumbai', 'Maharashtra', 5.0, true, 'Certified Math Tutor', 800.00, 400.00, 'premium', true),
('Amit Singh', 'amit@example.com', '+91 76543-21098', 'Electrician', 6, 'Bangalore', 'Karnataka', 4.9, true, 'Professional Electrician', 600.00, 350.00, 'free', true);

-- Insert sample locations data (comprehensive Indian locations would be added here in production)
-- Note: In production, populate with complete Indian location data from official sources
INSERT INTO locations (state, district, city, village) VALUES
-- Delhi
('Delhi', 'New Delhi', 'New Delhi', NULL),
('Delhi', 'New Delhi', 'Delhi NCR', NULL),
('Delhi', 'Gurgaon', 'Gurgaon', NULL),
('Delhi', 'Noida', 'Noida', NULL),
('Delhi', 'Faridabad', 'Faridabad', NULL),
('Delhi', 'Ghaziabad', 'Ghaziabad', NULL),
('Delhi', 'Greater Noida', 'Greater Noida', NULL),
('Delhi', 'Sonipat', 'Sonipat', NULL),
('Delhi', 'Bahadurgarh', 'Bahadurgarh', NULL),
('Delhi', 'Rohtak', 'Rohtak', NULL),
-- Maharashtra
('Maharashtra', 'Mumbai', 'Mumbai', NULL),
('Maharashtra', 'Pune', 'Pune', NULL),
('Maharashtra', 'Nagpur', 'Nagpur', NULL),
('Maharashtra', 'Thane', 'Thane', NULL),
('Maharashtra', 'Nashik', 'Nashik', NULL),
('Maharashtra', 'Aurangabad', 'Aurangabad', NULL),
('Maharashtra', 'Solapur', 'Solapur', NULL),
('Maharashtra', 'Kolhapur', 'Kolhapur', NULL),
('Maharashtra', 'Amravati', 'Amravati', NULL),
('Maharashtra', 'Nanded', 'Nanded', NULL),
-- Karnataka
('Karnataka', 'Bangalore', 'Bangalore', NULL),
('Karnataka', 'Mysore', 'Mysore', NULL),
('Karnataka', 'Hubli', 'Hubli', NULL),
('Karnataka', 'Mangalore', 'Mangalore', NULL),
('Karnataka', 'Belgaum', 'Belgaum', NULL),
('Karnataka', 'Gulbarga', 'Gulbarga', NULL),
('Karnataka', 'Davangere', 'Davangere', NULL),
('Karnataka', 'Bellary', 'Bellary', NULL),
('Karnataka', 'Bijapur', 'Bijapur', NULL),
('Karnataka', 'Shimoga', 'Shimoga', NULL),
-- Tamil Nadu
('Tamil Nadu', 'Chennai', 'Chennai', NULL),
('Tamil Nadu', 'Coimbatore', 'Coimbatore', NULL),
('Tamil Nadu', 'Madurai', 'Madurai', NULL),
('Tamil Nadu', 'Tiruchirappalli', 'Tiruchirappalli', NULL),
('Tamil Nadu', 'Salem', 'Salem', NULL),
('Tamil Nadu', 'Tirunelveli', 'Tirunelveli', NULL),
('Tamil Nadu', 'Tiruppur', 'Tiruppur', NULL),
('Tamil Nadu', 'Vellore', 'Vellore', NULL),
('Tamil Nadu', 'Erode', 'Erode', NULL),
('Tamil Nadu', 'Thoothukudi', 'Thoothukudi', NULL),
-- Uttar Pradesh
('Uttar Pradesh', 'Lucknow', 'Lucknow', NULL),
('Uttar Pradesh', 'Kanpur', 'Kanpur', NULL),
('Uttar Pradesh', 'Ghaziabad', 'Ghaziabad', NULL),
('Uttar Pradesh', 'Agra', 'Agra', NULL),
('Uttar Pradesh', 'Meerut', 'Meerut', NULL),
('Uttar Pradesh', 'Varanasi', 'Varanasi', NULL),
('Uttar Pradesh', 'Allahabad', 'Allahabad', NULL),
('Uttar Pradesh', 'Bareilly', 'Bareilly', NULL),
('Uttar Pradesh', 'Aligarh', 'Aligarh', NULL),
('Uttar Pradesh', 'Moradabad', 'Moradabad', NULL),
-- West Bengal
('West Bengal', 'Kolkata', 'Kolkata', NULL),
('West Bengal', 'Howrah', 'Howrah', NULL),
('West Bengal', 'Durgapur', 'Durgapur', NULL),
('West Bengal', 'Asansol', 'Asansol', NULL),
('West Bengal', 'Siliguri', 'Siliguri', NULL),
('West Bengal', 'Kharagpur', 'Kharagpur', NULL),
('West Bengal', 'Bardhaman', 'Bardhaman', NULL),
('West Bengal', 'Malda', 'Malda', NULL),
('West Bengal', 'Haldia', 'Haldia', NULL),
('West Bengal', 'Berhampore', 'Berhampore', NULL),
-- Gujarat
('Gujarat', 'Ahmedabad', 'Ahmedabad', NULL),
('Gujarat', 'Surat', 'Surat', NULL),
('Gujarat', 'Vadodara', 'Vadodara', NULL),
('Gujarat', 'Rajkot', 'Rajkot', NULL),
('Gujarat', 'Bhavnagar', 'Bhavnagar', NULL),
('Gujarat', 'Jamnagar', 'Jamnagar', NULL),
('Gujarat', 'Junagadh', 'Junagadh', NULL),
('Gujarat', 'Gandhinagar', 'Gandhinagar', NULL),
('Gujarat', 'Anand', 'Anand', NULL),
('Gujarat', 'Bharuch', 'Bharuch', NULL),
-- Rajasthan
('Rajasthan', 'Jaipur', 'Jaipur', NULL),
('Rajasthan', 'Jodhpur', 'Jodhpur', NULL),
('Rajasthan', 'Udaipur', 'Udaipur', NULL),
('Rajasthan', 'Kota', 'Kota', NULL),
('Rajasthan', 'Bikaner', 'Bikaner', NULL),
('Rajasthan', 'Ajmer', 'Ajmer', NULL),
('Rajasthan', 'Bhilwara', 'Bhilwara', NULL),
('Rajasthan', 'Alwar', 'Alwar', NULL),
('Rajasthan', 'Sikar', 'Sikar', NULL),
('Rajasthan', 'Churu', 'Churu', NULL),
-- Punjab
('Punjab', 'Ludhiana', 'Ludhiana', NULL),
('Punjab', 'Amritsar', 'Amritsar', NULL),
('Punjab', 'Jalandhar', 'Jalandhar', NULL),
('Punjab', 'Patiala', 'Patiala', NULL),
('Punjab', 'Bathinda', 'Bathinda', NULL),
('Punjab', 'Mohali', 'Mohali', NULL),
('Punjab', 'Hoshiarpur', 'Hoshiarpur', NULL),
('Punjab', 'Batala', 'Batala', NULL),
('Punjab', 'Pathankot', 'Pathankot', NULL),
('Punjab', 'Moga', 'Moga', NULL),
-- Haryana
('Haryana', 'Chandigarh', 'Chandigarh', NULL),
('Haryana', 'Faridabad', 'Faridabad', NULL),
('Haryana', 'Gurgaon', 'Gurgaon', NULL),
('Haryana', 'Panipat', 'Panipat', NULL),
('Haryana', 'Ambala', 'Ambala', NULL),
('Haryana', 'Yamunanagar', 'Yamunanagar', NULL),
('Haryana', 'Rohtak', 'Rohtak', NULL),
('Haryana', 'Hisar', 'Hisar', NULL),
('Haryana', 'Karnal', 'Karnal', NULL),
('Haryana', 'Sonipat', 'Sonipat', NULL),
-- Madhya Pradesh
('Madhya Pradesh', 'Indore', 'Indore', NULL),
('Madhya Pradesh', 'Bhopal', 'Bhopal', NULL),
('Madhya Pradesh', 'Jabalpur', 'Jabalpur', NULL),
('Madhya Pradesh', 'Gwalior', 'Gwalior', NULL),
('Madhya Pradesh', 'Ujjain', 'Ujjain', NULL),
('Madhya Pradesh', 'Sagar', 'Sagar', NULL),
('Madhya Pradesh', 'Dewas', 'Dewas', NULL),
('Madhya Pradesh', 'Satna', 'Satna', NULL),
('Madhya Pradesh', 'Ratlam', 'Ratlam', NULL),
('Madhya Pradesh', 'Rewa', 'Rewa', NULL),
-- Bihar
('Bihar', 'Patna', 'Patna', NULL),
('Bihar', 'Gaya', 'Gaya', NULL),
('Bihar', 'Bhagalpur', 'Bhagalpur', NULL),
('Bihar', 'Muzaffarpur', 'Muzaffarpur', NULL),
('Bihar', 'Darbhanga', 'Darbhanga', NULL),
('Bihar', 'Bihar Sharif', 'Bihar Sharif', NULL),
('Bihar', 'Arrah', 'Arrah', NULL),
('Bihar', 'Begusarai', 'Begusarai', NULL),
('Bihar', 'Katihar', 'Katihar', NULL),
('Bihar', 'Munger', 'Munger', NULL),
-- Andhra Pradesh
('Andhra Pradesh', 'Visakhapatnam', 'Visakhapatnam', NULL),
('Andhra Pradesh', 'Vijayawada', 'Vijayawada', NULL),
('Andhra Pradesh', 'Guntur', 'Guntur', NULL),
('Andhra Pradesh', 'Nellore', 'Nellore', NULL),
('Andhra Pradesh', 'Kurnool', 'Kurnool', NULL),
('Andhra Pradesh', 'Rajahmundry', 'Rajahmundry', NULL),
('Andhra Pradesh', 'Tirupati', 'Tirupati', NULL),
('Andhra Pradesh', 'Kadapa', 'Kadapa', NULL),
('Andhra Pradesh', 'Anantapur', 'Anantapur', NULL),
('Andhra Pradesh', 'Vizianagaram', 'Vizianagaram', NULL),
-- Telangana
('Telangana', 'Hyderabad', 'Hyderabad', NULL),
('Telangana', 'Warangal', 'Warangal', NULL),
('Telangana', 'Nizamabad', 'Nizamabad', NULL),
('Telangana', 'Karimnagar', 'Karimnagar', NULL),
('Telangana', 'Ramagundam', 'Ramagundam', NULL),
('Telangana', 'Khammam', 'Khammam', NULL),
('Telangana', 'Mahbubnagar', 'Mahbubnagar', NULL),
('Telangana', 'Nalgonda', 'Nalgonda', NULL),
('Telangana', 'Adilabad', 'Adilabad', NULL),
('Telangana', 'Suryapet', 'Suryapet', NULL),
-- Kerala
('Kerala', 'Thiruvananthapuram', 'Thiruvananthapuram', NULL),
('Kerala', 'Kochi', 'Kochi', NULL),
('Kerala', 'Kozhikode', 'Kozhikode', NULL),
('Kerala', 'Thrissur', 'Thrissur', NULL),
('Kerala', 'Kollam', 'Kollam', NULL),
('Kerala', 'Palakkad', 'Palakkad', NULL),
('Kerala', 'Alappuzha', 'Alappuzha', NULL),
('Kerala', 'Kottayam', 'Kottayam', NULL),
('Kerala', 'Kannur', 'Kannur', NULL),
('Kerala', 'Malappuram', 'Malappuram', NULL),
-- Odisha
('Odisha', 'Bhubaneswar', 'Bhubaneswar', NULL),
('Odisha', 'Cuttack', 'Cuttack', NULL),
('Odisha', 'Rourkela', 'Rourkela', NULL),
('Odisha', 'Berhampur', 'Berhampur', NULL),
('Odisha', 'Sambalpur', 'Sambalpur', NULL),
('Odisha', 'Puri', 'Puri', NULL),
('Odisha', 'Balasore', 'Balasore', NULL),
('Odisha', 'Bhadrak', 'Bhadrak', NULL),
('Odisha', 'Baripada', 'Baripada', NULL),
('Odisha', 'Jharsuguda', 'Jharsuguda', NULL),
-- Jharkhand
('Jharkhand', 'Ranchi', 'Ranchi', NULL),
('Jharkhand', 'Jamshedpur', 'Jamshedpur', NULL),
('Jharkhand', 'Dhanbad', 'Dhanbad', NULL),
('Jharkhand', 'Bokaro', 'Bokaro', NULL),
('Jharkhand', 'Deoghar', 'Deoghar', NULL),
('Jharkhand', 'Hazaribagh', 'Hazaribagh', NULL),
('Jharkhand', 'Giridih', 'Giridih', NULL),
('Jharkhand', 'Ramgarh', 'Ramgarh', NULL),
('Jharkhand', 'Medininagar', 'Medininagar', NULL),
('Jharkhand', 'Chirkunda', 'Chirkunda', NULL),
-- Chhattisgarh
('Chhattisgarh', 'Raipur', 'Raipur', NULL),
('Chhattisgarh', 'Bhilai', 'Bhilai', NULL),
('Chhattisgarh', 'Bilaspur', 'Bilaspur', NULL),
('Chhattisgarh', 'Korba', 'Korba', NULL),
('Chhattisgarh', 'Raigarh', 'Raigarh', NULL),
('Chhattisgarh', 'Jagdalpur', 'Jagdalpur', NULL),
('Chhattisgarh', 'Ambikapur', 'Ambikapur', NULL),
('Chhattisgarh', 'Durg', 'Durg', NULL),
('Chhattisgarh', 'Rajnandgaon', 'Rajnandgaon', NULL),
('Chhattisgarh', 'Chirmiri', 'Chirmiri', NULL),
-- Uttarakhand
('Uttarakhand', 'Dehradun', 'Dehradun', NULL),
('Uttarakhand', 'Haridwar', 'Haridwar', NULL),
('Uttarakhand', 'Roorkee', 'Roorkee', NULL),
('Uttarakhand', 'Haldwani', 'Haldwani', NULL),
('Uttarakhand', 'Rudrapur', 'Rudrapur', NULL),
('Uttarakhand', 'Kashipur', 'Kashipur', NULL),
('Uttarakhand', 'Rishikesh', 'Rishikesh', NULL),
('Uttarakhand', 'Pithoragarh', 'Pithoragarh', NULL),
('Uttarakhand', 'Almora', 'Almora', NULL),
('Uttarakhand', 'Nainital', 'Nainital', NULL),
-- Himachal Pradesh
('Himachal Pradesh', 'Shimla', 'Shimla', NULL),
('Himachal Pradesh', 'Mandi', 'Mandi', NULL),
('Himachal Pradesh', 'Dharamshala', 'Dharamshala', NULL),
('Himachal Pradesh', 'Solan', 'Solan', NULL),
('Himachal Pradesh', 'Nahan', 'Nahan', NULL),
('Himachal Pradesh', 'Hamirpur', 'Hamirpur', NULL),
('Himachal Pradesh', 'Una', 'Una', NULL),
('Himachal Pradesh', 'Palampur', 'Palampur', NULL),
('Himachal Pradesh', 'Kullu', 'Kullu', NULL),
('Himachal Pradesh', 'Chamba', 'Chamba', NULL),
-- Jammu & Kashmir
('Jammu & Kashmir', 'Srinagar', 'Srinagar', NULL),
('Jammu & Kashmir', 'Jammu', 'Jammu', NULL),
('Jammu & Kashmir', 'Anantnag', 'Anantnag', NULL),
('Jammu & Kashmir', 'Baramulla', 'Baramulla', NULL),
('Jammu & Kashmir', 'Udhampur', 'Udhampur', NULL),
('Jammu & Kashmir', 'Sopore', 'Sopore', NULL),
('Jammu & Kashmir', 'Bandipore', 'Bandipore', NULL),
('Jammu & Kashmir', 'Pulwama', 'Pulwama', NULL),
('Jammu & Kashmir', 'Kupwara', 'Kupwara', NULL),
('Jammu & Kashmir', 'Rajouri', 'Rajouri', NULL),
-- Goa
('Goa', 'Panaji', 'Panaji', NULL),
('Goa', 'Margao', 'Margao', NULL),
('Goa', 'Vasco da Gama', 'Vasco da Gama', NULL),
('Goa', 'Mapusa', 'Mapusa', NULL),
('Goa', 'Ponda', 'Ponda', NULL),
('Goa', 'Bicholim', 'Bicholim', NULL),
('Goa', 'Curchorem', 'Curchorem', NULL),
('Goa', 'Sanguem', 'Sanguem', NULL),
('Goa', 'Canacona', 'Canacona', NULL),
('Goa', 'Quepem', 'Quepem', NULL),
-- Puducherry
('Puducherry', 'Puducherry', 'Puducherry', NULL),
('Puducherry', 'Karaikal', 'Karaikal', NULL),
('Puducherry', 'Mahe', 'Mahe', NULL),
('Puducherry', 'Yanam', 'Yanam', NULL),
-- Chandigarh
('Chandigarh', 'Chandigarh', 'Chandigarh', NULL),
-- Dadra & Nagar Haveli
('Dadra & Nagar Haveli', 'Silvassa', 'Silvassa', NULL),
('Dadra & Nagar Haveli', 'Dadar', 'Dadar', NULL),
('Dadra & Nagar Haveli', 'Naroli', 'Naroli', NULL),
-- Daman & Diu
('Daman & Diu', 'Daman', 'Daman', NULL),
('Daman & Diu', 'Diu', 'Diu', NULL),
-- Lakshadweep
('Lakshadweep', 'Kavaratti', 'Kavaratti', NULL),
('Lakshadweep', 'Agatti', 'Agatti', NULL),
('Lakshadweep', 'Amini', 'Amini', NULL),
('Lakshadweep', 'Kadmat', 'Kadmat', NULL),
-- Andaman & Nicobar Islands
('Andaman & Nicobar Islands', 'Port Blair', 'Port Blair', NULL),
('Andaman & Nicobar Islands', 'Havelock Island', 'Havelock Island', NULL),
('Andaman & Nicobar Islands', 'Neil Island', 'Neil Island', NULL),
('Andaman & Nicobar Islands', 'Diglipur', 'Diglipur', NULL);

-- Enable Row Level Security (RLS)
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE providers ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE locations ENABLE ROW LEVEL SECURITY;

-- Create policies (adjust as needed for your security requirements)
CREATE POLICY "Services are viewable by everyone" ON services FOR SELECT USING (true);
CREATE POLICY "Providers are viewable by everyone" ON providers FOR SELECT USING (true);
CREATE POLICY "Bookings are insertable by authenticated users" ON bookings FOR INSERT WITH CHECK (true);
CREATE POLICY "Reviews are viewable by everyone" ON reviews FOR SELECT USING (true);
CREATE POLICY "Locations are viewable by everyone" ON locations FOR SELECT USING (true);