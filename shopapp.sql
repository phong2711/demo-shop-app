CREATE DATABASE shopapp;

CREATE TABLE users (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fullname VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(10) NOT NULL,
    address VARCHAR(200) DEFAULT '',
    password VARCHAR(100) NOT NULL DEFAULT '',
    is_active BOOLEAN DEFAULT TRUE,
    date_of_birth DATE,
    facebook_account_id INTEGER DEFAULT 0,
    google_account_id INTEGER DEFAULT 0,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

ALTER TABLE users ADD COLUMN role_id INT;

CREATE TABLE roles(
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL 
);
ALTER TABLE users ADD FOREIGN KEY (role_id) REFERENCES roles (id);

CREATE TABLE tokens (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    token VARCHAR(255) UNIQUE NOT NULL,
    token_type VARCHAR(50) NOT NULL,
    expiration_date TIMESTAMP,
    revoked BOOLEAN NOT NULL DEFAULT FALSE,
    expired BOOLEAN NOT NULL DEFAULT FALSE,
    user_id INTEGER,
    CONSTRAINT fk_tokens_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
);


--hỗ trợ đăng nhập từ Facebook và Google
CREATE TABLE social_accounts (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    provider VARCHAR(20) NOT NULL,
    provider_id VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL,
    name VARCHAR(100) NOT NULL,
    user_id INTEGER,
    CONSTRAINT fk_social_accounts_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
);

COMMENT ON COLUMN social_accounts.provider IS 'Tên nhà social network';
COMMENT ON COLUMN social_accounts.email IS 'Email tài khoản';
COMMENT ON COLUMN social_accounts.name IS 'Tên người dùng';

-- Bảng danh mục sản phẩm (Category)
CREATE TABLE categories (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL DEFAULT ''
);

COMMENT ON COLUMN categories.name IS 'Tên danh mục, vd: đồ điện tử';

-- Bảng chứa sản phẩm (Product)
CREATE TABLE products (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(350),
    price DOUBLE PRECISION NOT NULL CHECK (price >= 0),
    thumbnail VARCHAR(300) DEFAULT '',
    description TEXT DEFAULT '',
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    category_id INTEGER,
    CONSTRAINT fk_products_categories
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
);

COMMENT ON COLUMN products.name IS 'Tên sản phẩm';

-- Tạo kiểu ENUM cho trạng thái đơn hàng
CREATE TYPE order_status AS ENUM (
    'pending',
    'processing',
    'shipped',
    'delivered',
    'cancelled'
);

-- Bảng orders
CREATE TABLE orders (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INTEGER,
    fullname VARCHAR(100) DEFAULT '',
    email VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT NULL,
    note VARCHAR(100) DEFAULT '',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status order_status,
    total_money NUMERIC(12,2) NOT NULL CHECK (total_money >= 0),

    shipping_method VARCHAR(100),
    shipping_address VARCHAR(200),
    shipping_date DATE,
    tracking_number VARCHAR(100),
    payment_method VARCHAR(100),
    active BOOLEAN DEFAULT TRUE,

    CONSTRAINT fk_orders_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
);

COMMENT ON COLUMN orders.status IS 'Trạng thái đơn hàng';

CREATE TABLE order_details (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    price NUMERIC(12,2) NOT NULL CHECK (price >= 0),
    number_of_products INTEGER NOT NULL CHECK (number_of_products > 0),
    total_money NUMERIC(12,2) NOT NULL CHECK (total_money >= 0),
    color VARCHAR(20) DEFAULT '',

    CONSTRAINT fk_order_details_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(id),

    CONSTRAINT fk_order_details_products
        FOREIGN KEY (product_id)
        REFERENCES products(id)
);

