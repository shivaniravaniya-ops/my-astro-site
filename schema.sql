-- TankGarage 用户表
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    created_at TEXT DEFAULT (datetime('now'))
);

-- TankGarage 商品表
CREATE TABLE IF NOT EXISTS products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    series TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    price REAL NOT NULL,
    image TEXT,
    stock INTEGER DEFAULT 0,
    category TEXT,
    oem TEXT,
    material TEXT,
    finish TEXT,
    fitment TEXT,
    weight TEXT,
    created_at TEXT DEFAULT (datetime('now'))
);

-- TankGarage 购物车表
CREATE TABLE IF NOT EXISTS cart_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id TEXT,
    session_id TEXT,
    product_id INTEGER NOT NULL,
    quantity INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now'))
);

-- 插入 Tank 产品数据
INSERT INTO products (series, name, description, price, image, stock, category, oem, material, finish, fitment, weight) VALUES
('300', 'Front Bumper', 'Our most popular front bumper for the Tank 300. Precision-engineered for a perfect fit, transforms the front end with an aggressive, off-road ready look. Made from high-quality FRP for durability and easy painting.', 649, '/images/products/tank-300-front-bumper.jpg', 50, 'Bumpers', 'TG-FB300-001', 'FRP (Fiberglass Reinforced Plastic)', 'Gel coat (ready to paint)', 'GWM Tank 300 (2021–Present)', '8.5 kg');

INSERT INTO products (series, name, description, price, image, stock, category, oem, material, finish, fitment, weight) VALUES
('400', 'Side Skirt Set', 'Complete side skirt set for the Tank 400. Adds a sleek, lowered appearance while providing basic underbody airflow management. Includes all mounting hardware.', 499, '/images/products/tank-400-side-skirt.jpg', 35, 'Side Skirts', 'TG-SS400-001', 'ABS Plastic', 'Primer coat (ready to paint)', 'GWM Tank 400 (2022–Present)', '6.2 kg');

INSERT INTO products (series, name, description, price, image, stock, category, oem, material, finish, fitment, weight) VALUES
('500', 'Rear Bumper', 'Aggressive rear bumper design for the Tank 500. Features integrated tow points and a diffuser-style lower section. Perfect for completing the rugged look.', 729, '/images/products/tank-500-rear-bumper.jpg', 28, 'Bumpers', 'TG-RB500-001', 'FRP', 'Gel coat (ready to paint)', 'GWM Tank 500 (2022–Present)', '9.8 kg');

INSERT INTO products (series, name, description, price, image, stock, category, oem, material, finish, fitment, weight) VALUES
('300', 'Rear Spoiler', 'A subtle rear spoiler that adds a sporty touch without being too aggressive. Improves rear-end aesthetics while maintaining a clean, factory-plus appearance.', 399, '/images/products/tank-300-spoiler.jpg', 42, 'Spoilers', 'TG-RS300-001', 'ABS Plastic', 'Gloss black (premium finish)', 'GWM Tank 300 (2021–Present)', '3.1 kg');

INSERT INTO products (series, name, description, price, image, stock, category, oem, material, finish, fitment, weight) VALUES
('400', 'Wide Body Kit', 'Complete wide body kit for the Tank 400. Includes front bumper, rear bumper, side skirts, and fender flares. Transforms your Tank 400 into a true wide-body beast.', 2499, '/images/products/tank-400-widebody.jpg', 12, 'Body Kits', 'TG-WBK400-001', 'FRP / ABS mix', 'Gel coat (ready to paint)', 'GWM Tank 400 (2022–Present)', '42 kg (full kit)');

INSERT INTO products (series, name, description, price, image, stock, category, oem, material, finish, fitment, weight) VALUES
('500', 'Carbon Hood', 'Lightweight carbon fiber hood for the Tank 500. Reduces hood weight by 60% compared to stock while adding aggressive vent styling for improved engine bay cooling.', 1199, '/images/products/tank-500-carbon-hood.jpg', 18, 'Hoods', 'TG-CH500-001', '2x2 Carbon Fiber weave', 'Gloss clear coat', 'GWM Tank 500 (2022–Present)', '4.2 kg');
