-- USERS TABLE
CREATE TABLE users (
    mobile_number TEXT PRIMARY KEY,
    full_name TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    staff_type TEXT,
    level INTEGER,
    zone TEXT,
    zone_manager_name TEXT,
    is_active BOOLEAN DEFAULT 1
);

-- OUTLETS TABLE
CREATE TABLE outlets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    location TEXT,
    route TEXT,
    zone TEXT,
    contact TEXT,
    pan TEXT,
    category TEXT,
    class TEXT,
    address TEXT,
    contact_person TEXT,
    alt_mobile TEXT,
    remarks TEXT,
    assigned_to INTEGER,
    latitude REAL,
    longitude REAL,
    contact_person_updated BOOLEAN DEFAULT 0,
    mobile_updated BOOLEAN DEFAULT 0,
    alt_mobile_updated BOOLEAN DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assigned_to) REFERENCES users(id)
);

-- PJP PLANS TABLE
CREATE TABLE pjp_plans (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    date DATE NOT NULL,
    route TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- PJP PLAN OUTLETS TABLE
CREATE TABLE pjp_plan_outlets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pjp_plan_id INTEGER NOT NULL,
    outlet_id INTEGER NOT NULL,
    FOREIGN KEY (pjp_plan_id) REFERENCES pjp_plans(id),
    FOREIGN KEY (outlet_id) REFERENCES outlets(id)
);

-- ATTENDANCE TABLE
CREATE TABLE attendance (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    date DATE NOT NULL,
    check_in_time DATETIME,
    check_in_lat REAL,
    check_in_lng REAL,
    check_out_time DATETIME,
    check_out_lat REAL,
    check_out_lng REAL,
    remarks TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- OUTLET VISITS TABLE
CREATE TABLE outlet_visits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    outlet_id INTEGER NOT NULL,
    date DATE NOT NULL,
    check_in_time DATETIME,
    on_location BOOLEAN,
    not_there_reason TEXT,
    remarks TEXT,
    payment_collected DECIMAL(12,2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (outlet_id) REFERENCES outlets(id)
);

-- VISIT IMAGES TABLE
CREATE TABLE visit_images (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    outlet_visit_id INTEGER NOT NULL,
    image_url TEXT NOT NULL,
    FOREIGN KEY (outlet_visit_id) REFERENCES outlet_visits(id)
);

-- STOCK COUNTS TABLE
CREATE TABLE stock_counts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    outlet_visit_id INTEGER NOT NULL,
    product TEXT NOT NULL,
    size TEXT NOT NULL,
    cases INTEGER,
    bottles INTEGER,
    FOREIGN KEY (outlet_visit_id) REFERENCES outlet_visits(id)
);

-- ORDERS TABLE
CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    outlet_visit_id INTEGER NOT NULL,
    product TEXT NOT NULL,
    size TEXT NOT NULL,
    cases INTEGER,
    bottles INTEGER,
    FOREIGN KEY (outlet_visit_id) REFERENCES outlet_visits(id)
);

-- RETURNS TABLE
CREATE TABLE returns (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    outlet_visit_id INTEGER NOT NULL,
    product TEXT NOT NULL,
    size TEXT NOT NULL,
    cases INTEGER,
    bottles INTEGER,
    FOREIGN KEY (outlet_visit_id) REFERENCES outlet_visits(id)
); 