DROP DATABASE IF EXISTS optics;
CREATE DATABASE optics CHARACTER SET utf8mb4;
USE optics;

CREATE TABLE suppliers (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  street VARCHAR(100) NOT NULL,
  num INT NOT NULL,
  door VARCHAR(4) NOT NULL,
  floor_house VARCHAR(4) NOT NULL,
  city VARCHAR(100) NOT NULL,
  postal_code VARCHAR(5) NOT NULL,
  country VARCHAR(100),
  telephone VARCHAR(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  nif VARCHAR(9) NOT NULL UNIQUE
);

CREATE TABLE brands (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    supplier INT UNSIGNED NOT NULL,
    FOREIGN KEY (supplier) REFERENCES suppliers(id)
);

CREATE TABLE glasses (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    brand INT UNSIGNED NOT NULL,
    model VARCHAR(100) NOT NULL UNIQUE,
    left_lens_prescription DECIMAL(4,2) NOT NULL,
    right_lens_prescription DECIMAL(4,2) NOT NULL,
    frametype ENUM('RIMLEESS','PLASTIC','METAL')NOT NULL,
    framecolor VARCHAR(10) NOT NULL,
    left_lens_color VARCHAR(10) NOT NULL,
    right_lens_color VARCHAR(10) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (brand) REFERENCES brands(id)
);

CREATE TABLE clients (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    postal_code VARCHAR(5) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL,
    recommended_by VARCHAR(100) NULL
);

CREATE TABLE employees(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE sales(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    glass INT UNSIGNED,
    client INT UNSIGNED NOT NULL,
    sold_date DATE NOT NULL,
    employee INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    FOREIGN KEY (glass) REFERENCES glasses(id),
    FOREIGN KEY (client) REFERENCES clients(id),
    FOREIGN KEY (employee) REFERENCES employees(id)
);

INSERT INTO suppliers(name,street,num,door,floor_house,city,postal_code,country,telephone,fax,NIF) VALUES('General óptica','calle de la calle',10,'1',"2",'Barcelona',08911,'spain','933333333','934444444','34467543E');

INSERT INTO suppliers(name,street,num,door,floor_house,city,postal_code,country,telephone,fax,NIF) VALUES('Óptica martinez','calle de la calle',10,'1','2','Barcelona',08911,'spain','933333333','934444444','34467543B');

INSERT INTO brands(name,supplier) VALUES('Rayban',1);

INSERT INTO brands(name,supplier) VALUES('Martinez',1);

INSERT INTO glasses(brand,model,left_lens_prescription,right_lens_prescription,frametype,framecolor,left_lens_color,right_lens_color,price) VALUES(1,'Classicglass',2,2,'PLASTIC','red','red','red',100);

INSERT INTO glasses(brand,model,left_lens_prescription,right_lens_prescription,frametype,framecolor,left_lens_color,right_lens_color,price) VALUES(2,'ModernGlass',2,2,'PLASTIC','blue','blue','blue',100);


INSERT INTO clients(name,postal_code,phone,email,registration_date,recommended_by) VALUES('Pedro Reyes','09999','933333333','pedro@gmail.com','2024-01-01',null);

INSERT INTO employees(name) VALUES('Juan Costa');

INSERT INTO sales(glass,client,sold_date,employee,quantity) VALUES(1,1,'2025-01-01',1,1);
INSERT INTO sales(glass,client,sold_date,employee,quantity) VALUES(1,1,'2026-01-01',1,1);
INSERT INTO sales(glass,client,sold_date,employee,quantity) VALUES(1,1,'2027-01-01',1,1);

SELECT g.brand,g.model,s.sold_date,s.quantity FROM sales s JOIN glasses g ON s.glass = g.id JOIN clients c ON s.client = c.id WHERE s.sold_date BETWEEN '2025-01-01' AND '2026-01-01' AND c.name="Pedro Reyes";

SELECT DISTINCT b.name,g.model FROM glasses AS g JOIN brands AS b ON g.brand = b.id JOIN sales AS s ON s.glass = g.id JOIN employees AS e ON s.employee = e.id WHERE e.name ='Juan Costa';

SELECT DISTINCT s.name FROM suppliers AS s JOIN brands AS b ON b.supplier = s.id JOIN glasses as g ON g.brand = b.id JOIN sales AS sa ON sa.glass = g.id;
