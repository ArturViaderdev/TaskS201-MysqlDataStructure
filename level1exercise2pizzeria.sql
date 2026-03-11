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
    type ENUM('pizza','burguer','drink') NOT NULL,
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
