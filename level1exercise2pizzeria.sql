DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

 CREATE TABLE province (
   id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(100) NOT NULL
 );

CREATE TABLE city (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    province INT UNSIGNED,
    FOREIGN KEY (province) REFERENCES province(id)
 );

CREATE TABLE customer (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    postalCode VARCHAR(5) NOT NULL,
    city INT UNSIGNED NOT NULL,
    phoneNumber VARCHAR(12) NOT NULL,
    FOREIGN KEY (city) REFERENCES city(id)
);

CREATE TABLE shop (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(100) NOT NULL,
    postalcode VARCHAR(5) NOT NULL,
    city INT UNSIGNED,
    FOREIGN KEY (city) REFERENCES city(id)
);

CREATE TABLE employee (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surnames VARCHAR(100) NOT NULL,
    nif VARCHAR(9) NOT NULL,
    phone VARCHAR(12) NOT NULL,
    shop INT UNSIGNED,
    deliverydriver BOOL NOT NULL,
    FOREIGN KEY(shop) REFERENCES shop(id)
);

CREATE TABLE ordered (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer INT UNSIGNED NOT NULL,
    orderdate DATETIME NOT NULL,
    delivery BOOL NOT NULL,
    totalprice DECIMAL(10,2) NOT NULL,
    totalpizzas INT NOT NULL,
    totalburgers INT NOT NULL,
    totaldrinks INT NOT NULL,
    shop INT UNSIGNED NOT NULL,
    deliveredby INT UNSIGNED NULL,
    FOREIGN KEY (customer) REFERENCES customer(id),
    FOREIGN KEY (shop) REFERENCES shop(id),
    FOREIGN KEY (deliveredby) REFERENCES employee(id)
);

CREATE TABLE pizzacategory (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE product (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(256) NOT NULL,
    photo VARCHAR(256) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    producttype ENUM('PIZZA','BURGER','DRINK') NOT NULL,
    pizzacategory INT UNSIGNED NULL,
    FOREIGN KEY (pizzacategory) REFERENCES pizzacategory(id)
);

CREATE TABLE orderproducts (
    ordered INT UNSIGNED NOT NULL,
    product INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    FOREIGN KEY (product) REFERENCES product(id),
    FOREIGN KEY (ordered) REFERENCES ordered(id),
    PRIMARY KEY (ordered,product)
);



INSERT INTO province (name) VALUES ('Barcelona'),('Madrid');

INSERT INTO city (name, province) VALUES ('Barcelona', 1),('Madrid', 2);

INSERT INTO customer ( firstName,lastName,address,postalCode,city,phoneNumber)
VALUES('Pedro','Reyes','calle de la calle',09999,1,'933333333');

INSERT INTO shop (address, postalCode, city) VALUES("Calle calle", '08888', 1);

INSERT INTO employee (name, surnames, nif, phone, shop, deliverydriver) VALUES("Paco","Torras Garcia",'48473637E','933444334',1,false);

INSERT INTO ordered (customer,orderdate,delivery,totalprice,totalpizzas,totalburgers,totaldrinks,shop,deliveredby)
VALUES(1, '2025-01-01', false, 20, 1, 0, 1, 1, null), (1,'2025-07-01',true,10,1,0,0,1,1);

INSERT INTO pizzacategory(name) VALUES('Italiana');

INSERT INTO product(name,description,photo,price,producttype,pizzacategory) VALUES('Cuatro quesos','Pizza con cuatro quesos','cuatro.jpg',10,'PIZZA',1),
                                                                                    ('Cocacola','Botella de cocacola de 100cl','cocacola.jpg',10,'DRINK',null);

INSERT INTO orderproducts(ordered,product,quantity) VALUES(1,1,1),(1,2,1);

SELECT c.name as ciudad, SUM(o.totaldrinks) AS totaldrinksvendidos FROM ordered o JOIN shop s ON o.shop = s.id JOIN city c ON s.city = c.id WHERE c.name='Barcelona' GROUP BY c.id, c.name;

SELECT COUNT(o.deliveredby) AS totalrepartos FROM employee e JOIN ordered o ON o.deliveredby  = e.id WHERE e.id=1;
