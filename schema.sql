 -- 1. DROP EXISTING TABLES (RESTART FRESH)
DROP TABLE order_items CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE products CASCADE CONSTRAINTS;
DROP TABLE customers CASCADE CONSTRAINTS;

-- 2. CREATE TABLES
CREATE TABLE customers (
  customer_id NUMBER PRIMARY KEY,
  customer_name VARCHAR2(100),
  email VARCHAR2(100),
  city VARCHAR2(50)
);

CREATE TABLE products (
  product_id NUMBER PRIMARY KEY,
  product_name VARCHAR2(100),
  category VARCHAR2(50),
  price NUMBER(10,2)
);

CREATE TABLE orders (
  order_id NUMBER PRIMARY KEY,
  customer_id NUMBER REFERENCES customers(customer_id),
  order_date DATE
);

CREATE TABLE order_items (
  order_item_id NUMBER PRIMARY KEY,
  order_id NUMBER REFERENCES orders(order_id),
  product_id NUMBER REFERENCES products(product_id),
  quantity NUMBER
);

-- 3. INSERT CUSTOMERS (5)
INSERT INTO customers VALUES (101, 'Alice Smith', 'alice@gmail.com', 'Kigali');
INSERT INTO customers VALUES (102, 'Bob Jones', 'bob@yahoo.com', 'Musanze');
INSERT INTO customers VALUES (103, 'Charlie Brown', 'charlie@outlook.com', 'Rubavu');
INSERT INTO customers VALUES (104, 'Diana Prince', 'diana@gmail.com', 'Kigali');
INSERT INTO customers VALUES (105, 'Evan Wright', 'evan@gmail.com', 'Huye');

-- 4. INSERT PRODUCTS (8)
INSERT INTO products VALUES (1, 'Fresh Milk 1L', 'Dairy', 2.50);
INSERT INTO products VALUES (2, 'Cheddar Cheese 250g', 'Dairy', 4.00);
INSERT INTO products VALUES (3, 'Whole Wheat Bread', 'Bakery', 1.80);
INSERT INTO products VALUES (4, 'Chocolate Chip Cookies', 'Bakery', 3.20);
INSERT INTO products VALUES (5, 'Organic Apples 1kg', 'Produce', 3.00);
INSERT INTO products VALUES (6, 'Ripe Bananas 1kg', 'Produce', 1.50);
INSERT INTO products VALUES (7, 'Orange Juice 1L', 'Beverages', 2.80);
INSERT INTO products VALUES (8, 'Greek Yogurt 500g', 'Dairy', 3.50);

-- 5. INSERT ORDERS (15)
INSERT INTO orders VALUES (1001, 101, TO_DATE('2026-01-05', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1002, 102, TO_DATE('2026-01-07', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1003, 101, TO_DATE('2026-01-12', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1004, 103, TO_DATE('2026-01-15', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1005, 104, TO_DATE('2026-01-18', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1006, 101, TO_DATE('2026-01-22', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1007, 102, TO_DATE('2026-01-25', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1008, 104, TO_DATE('2026-02-01', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1009, 103, TO_DATE('2026-02-05', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1010, 101, TO_DATE('2026-02-10', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1011, 102, TO_DATE('2026-02-14', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1012, 104, TO_DATE('2026-02-18', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1013, 101, TO_DATE('2026-02-22', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1014, 103, TO_DATE('2026-02-25', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1015, 104, TO_DATE('2026-03-01', 'YYYY-MM-DD'));

-- 6. INSERT ORDER ITEMS (25)
INSERT INTO order_items VALUES (1, 1001, 1, 2);
INSERT INTO order_items VALUES (2, 1001, 3, 1);
INSERT INTO order_items VALUES (3, 1002, 5, 3);
INSERT INTO order_items VALUES (4, 1002, 7, 2);
INSERT INTO order_items VALUES (5, 1003, 2, 2);
INSERT INTO order_items VALUES (6, 1003, 8, 1);
INSERT INTO order_items VALUES (7, 1004, 4, 4);
INSERT INTO order_items VALUES (8, 1004, 1, 2);
INSERT INTO order_items VALUES (9, 1005, 6, 5);
INSERT INTO order_items VALUES (10, 1005, 3, 2);
INSERT INTO order_items VALUES (11, 1006, 2, 1);
INSERT INTO order_items VALUES (12, 1006, 5, 2);
INSERT INTO order_items VALUES (13, 1007, 7, 1);
INSERT INTO order_items VALUES (14, 1007, 8, 3);
INSERT INTO order_items VALUES (15, 1008, 1, 4);
INSERT INTO order_items VALUES (16, 1009, 2, 2);
INSERT INTO order_items VALUES (17, 1009, 3, 3);
INSERT INTO order_items VALUES (18, 1010, 4, 2);
INSERT INTO order_items VALUES (19, 1011, 5, 1);
INSERT INTO order_items VALUES (20, 1011, 6, 4);
INSERT INTO order_items VALUES (21, 1012, 7, 2);
INSERT INTO order_items VALUES (22, 1013, 8, 2);
INSERT INTO order_items VALUES (23, 1014, 1, 1);
INSERT INTO order_items VALUES (24, 1014, 2, 1);
INSERT INTO order_items VALUES (25, 1015, 3, 5);

-- 7. SAVE PERMANENTLY
COMMIT;