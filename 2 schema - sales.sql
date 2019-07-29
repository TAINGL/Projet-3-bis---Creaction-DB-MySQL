-- CREATE SCHEMA

DROP SCHEMA IF EXISTS sales;
CREATE SCHEMA sales;
USE sales;

-- CREATE TABLES

CREATE TABLE customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(50),
    email VARCHAR(100),
    street VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code INT);


CREATE TABLE staffs(
	staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(50),
    actif ENUM('yes','no'),
    store_id INT,
    manager_id INT
-- FOREIGN KEY (store_id) REFERENCES stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
-- FOREIGN KEY (manager_id) REFERENCES managers (manager_id) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE stores(
	store_id INT AUTO_INCREMENT PRIMARY KEY,
	store_name VARCHAR(255),
    phone VARCHAR(50),
    email VARCHAR(255),
    street VARCHAR(255),
    city VARCHAR(150),
    state VARCHAR(150),
    zip_code INT
-- 	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
);


CREATE TABLE order_items(
	order_id INT,
    item_id INT,
    product_id INT,
    quantity INT,
    list_price DECIMAL (10,2),
    discount DECIMAL (10,2),
	PRIMARY KEY (order_id, item_id)
-- FOREIGN KEY (order_id) REFERENCES orders (order_items) ON DELETE CASCADE ON UPDATE CASCADE,
-- FOREIGN KEY (store_id) REFERENCES production.products (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE orders(
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_status INT,
    order_date VARCHAR(20),
    required_date VARCHAR(20),
    shipped_date VARCHAR(20),
    store_id INT,
    staff_id INT
-- FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
-- FOREIGN KEY (staff_id) REFERENCES staffs (staff_id),
-- FOREIGN KEY (store_id) REFERENCES stores (store_id)
);


CREATE TABLE managers(
manager_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR (255) NOT NULL,
last_name VARCHAR (255) NOT NULL,
email VARCHAR (50),
phone VARCHAR(50),
actif ENUM('yes','no')NOT NULL,
store_id INT
);