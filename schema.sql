-- Cloudflare D1 数据库初始化脚本
-- 商品表 products

CREATE TABLE IF NOT EXISTS products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    price REAL NOT NULL,
    image TEXT,
    stock INTEGER DEFAULT 0,
    category TEXT,
    oem_number TEXT,
    vehicle_model TEXT,
    created_at TEXT DEFAULT (datetime('now'))
);

-- 插入测试数据：汽配商品
INSERT INTO products (name, description, price, image, stock, category, oem_number, vehicle_model) VALUES
(
    '前刹车片套装（陶瓷配方）',
    '高品质陶瓷配方刹车片，低噪音、低粉尘、制动灵敏。适用于日常城市驾驶和高速巡航。符合欧盟ECE R90认证标准。',
    12.80,
    'https://placehold.co/400x300/e8ecf1/1a3a5c?text=Brake+Pad',
    5000,
    '制动系统',
    'BP-8850',
    '丰田凯美瑞 2018-2024'
);

INSERT INTO products (name, description, price, image, stock, category, oem_number, vehicle_model) VALUES
(
    '前保险杠总成 带支架',
    '原厂品质前保险杠总成，配套水箱框架和安装支架。PP材质，喷漆前处理，适合后市场改装和维修替换。',
    68.50,
    'https://placehold.co/400x300/e8ecf1/1a3a5c?text=Bumper+Assembly',
    1200,
    '车身外观件',
    'FB-2230',
    '本田雅阁 2016-2021'
);

INSERT INTO products (name, description, price, image, stock, category, oem_number, vehicle_model) VALUES
(
    '水泵总成（铝合金）',
    '铝合金材质水泵总成，散热性能优异，密封可靠。使用进口机械密封圈，使用寿命超50000小时。',
    28.00,
    'https://placehold.co/400x300/e8ecf1/1a3a5c?text=Water+Pump',
    3200,
    '发动机件',
    'WP-4400',
    '大众帕萨特 2015-2022'
);
