-- 1. Таблица категорий
CREATE TABLE categories (
    id       SERIAL PRIMARY KEY,
    name     TEXT NOT NULL,
    parent_id INTEGER REFERENCES categories(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE INDEX idx_categories_parent ON categories(parent_id);

-- 2. Таблица номенклатуры
CREATE TABLE products (
    id       SERIAL PRIMARY KEY,
    name     TEXT NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    price    NUMERIC(12,2) NOT NULL, 
    category_id INTEGER REFERENCES categories(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE INDEX idx_products_category ON products(category_id);

-- 3. Клиенты
CREATE TABLE clients (
    id       SERIAL PRIMARY KEY,
    name     TEXT NOT NULL,
    address  TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- 4. Заказы
CREATE TABLE orders (
    id        SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    order_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
    status    TEXT,
    total_cached NUMERIC(14,2)
);
CREATE INDEX idx_orders_client ON orders(client_id);

-- 5. Позиции заказа (заказ содержит набор товаров)
CREATE TABLE order_items (
    id         SERIAL PRIMARY KEY,
    order_id   INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity   INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12,2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);


-- === КАТЕГОРИИ ===
INSERT INTO categories (name, parent_id) VALUES
('Продукты питания', NULL),             
('Молочные продукты', 1),               
('Мясные продукты', 1),                 
('Овощи', 1),                           
('Напитки', NULL),                      
('Безалкогольные', 5),                 
('Алкогольные', 5);                     

-- === ТОВАРЫ ===
INSERT INTO products (name, quantity, price, category_id) VALUES
('Молоко 1л', 100, 65.00, 2),
('Кефир 1л', 80, 70.00, 2),
('Сыр российский 200г', 50, 150.00, 2),
('Говядина 1кг', 40, 450.00, 3),
('Свинина 1кг', 60, 420.00, 3),
('Картофель 1кг', 200, 40.00, 4),
('Морковь 1кг', 150, 35.00, 4),
('Сок яблочный 1л', 120, 90.00, 6),
('Минеральная вода 1.5л', 200, 60.00, 6),
('Пиво светлое 0.5л', 180, 95.00, 7);

-- === КЛИЕНТЫ ===
INSERT INTO clients (name, address) VALUES
('ООО "Альфа"', 'г. Москва, ул. Центральная, д.1'),
('ООО "Бета"', 'г. Санкт-Петербург, Невский пр., д.22'),
('ИП Иванов И.И.', 'г. Казань, ул. Ленина, д.15'),
('ООО "Гамма"', 'г. Новосибирск, пр. Мира, д.9');

-- === ЗАКАЗЫ ===
INSERT INTO orders (client_id, order_date, status) VALUES
(1, '2025-10-20', 'completed'),  
(1, '2025-10-25', 'pending'),    
(2, '2025-10-22', 'completed'),  
(3, '2025-10-21', 'completed'),  
(4, '2025-10-23', 'completed');  

-- === ПОЗИЦИИ ЗАКАЗОВ ===
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- заказ 1 (Альфа)
(1, 1, 10, 65.00),   
(1, 3, 5, 150.00),   
(1, 6, 10, 40.00),  

-- заказ 2 (Альфа)
(2, 2, 8, 70.00),   
(2, 9, 5, 60.00),    

-- заказ 3 (Бета)
(3, 4, 3, 450.00),  
(3, 8, 6, 90.00),   
(3, 10, 12, 95.00),  

-- заказ 4 (Иванов)
(4, 5, 2, 420.00),   
(4, 6, 5, 40.00),   
(4, 7, 5, 35.00),   

-- заказ 5 (Гамма)
(5, 1, 5, 65.00),    
(5, 8, 5, 90.00);    