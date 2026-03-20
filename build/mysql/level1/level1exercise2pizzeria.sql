DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

 CREATE TABLE provinces (
   id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(100) NOT NULL
 );

CREATE TABLE cities (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    province INT UNSIGNED,
    FOREIGN KEY (province) REFERENCES provinces(id)
 );

CREATE TABLE customers (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    postal_code VARCHAR(5) NOT NULL,
    city INT UNSIGNED NOT NULL,
    phone_number VARCHAR(12) NOT NULL,
    FOREIGN KEY (city) REFERENCES cities(id)
);

CREATE TABLE shops (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(100) NOT NULL,
    postal_code VARCHAR(5) NOT NULL,
    city INT UNSIGNED,
    FOREIGN KEY (city) REFERENCES cities(id)
);

CREATE TABLE employees (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surnames VARCHAR(100) NOT NULL,
    nif VARCHAR(9) NOT NULL,
    phone VARCHAR(12) NOT NULL,
    shop INT UNSIGNED,
    delivery_driver BOOL NOT NULL,
    FOREIGN KEY(shop) REFERENCES shops(id)
);

CREATE TABLE orders (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer INT UNSIGNED NOT NULL,
    order_date DATETIME NOT NULL,
    delivery BOOL NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    shop INT UNSIGNED NOT NULL,
    delivered_by INT UNSIGNED NULL,
    FOREIGN KEY (customer) REFERENCES customers(id),
    FOREIGN KEY (shop) REFERENCES shops(id),
    FOREIGN KEY (delivered_by) REFERENCES employees(id)
);

CREATE TABLE pizza_categories (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(256) NOT NULL,
    photo VARCHAR(256) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    product_type ENUM('PIZZA','BURGER','DRINK') NOT NULL,
    pizza_category INT UNSIGNED NULL,
    FOREIGN KEY (pizza_category) REFERENCES pizza_categories(id)
);

CREATE TABLE products_from_orders (
    the_order INT UNSIGNED NOT NULL,
    product INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    FOREIGN KEY (product) REFERENCES products(id),
    FOREIGN KEY (the_order) REFERENCES orders(id),
    PRIMARY KEY (the_order,product)
);



INSERT INTO provinces (name) VALUES ('Barcelona'),('Madrid');

INSERT INTO cities (name, province) VALUES ('Barcelona', 1),('Madrid', 2);

INSERT INTO customers ( first_name,last_name,address,postal_code,city,phone_number)
VALUES('Pedro','Reyes','calle de la calle',09999,1,'933333333');

INSERT INTO shops (address, postal_code, city) VALUES("Calle calle", '08888', 1);

INSERT INTO employees (name, surnames, nif, phone, shop, delivery_driver) VALUES("Paco","Torras Garcia",'48473637E','933444334',1,false);

INSERT INTO orders (customer,order_date,delivery,total_price,shop,delivered_by)
VALUES(1, '2025-01-01', false, 20, 1, null), (1,'2025-07-01',true,10,1,1);

INSERT INTO pizza_categories(name) VALUES('Italiana');

INSERT INTO products(name,description,photo,price,product_type,pizza_category) VALUES('Cuatro quesos','Pizza con cuatro quesos','cuatro.jpg',10,'PIZZA',1),
                                                                                    ('Cocacola','Botella de cocacola de 100cl','cocacola.jpg',10,'DRINK',null);

INSERT INTO products_from_orders(the_order,product,quantity) VALUES(1,1,1),(1,2,1);

SELECT SUM(pr.quantity) as 'Begudes_venudes_a_Barcelona' FROM products_from_orders AS pr JOIN products AS p ON pr.product = p.id JOIN orders AS o ON o.id = pr.the_order JOIN shops AS s ON o.shop = s.id JOIN cities AS c ON c.id = s.city WHERE p.product_type = 'DRINK' AND c.name='Barcelona';

SELECT COUNT (o.id) AS 'Comandes que ha realitzat el empleat' FROM orders AS o JOIN employees AS e ON e.id = o.delivered_by WHERE e.nif ='48473637E';

