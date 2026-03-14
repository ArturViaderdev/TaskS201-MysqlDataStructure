DROP DATABASE IF EXISTS optics;
CREATE DATABASE optics CHARACTER SET utf8mb4;
USE optics;

CREATE TABLE supplier (
  name VARCHAR(100) NOT NULL,
  street VARCHAR(100) NOT NULL,
  num INT NOT NULL,
  door INT NOT NULL,
  floorhouse INT NOT NULL,
  city VARCHAR(100) NOT NULL,
  postalcode VARCHAR(5) NOT NULL,
  country VARCHAR(100),
  telephone VARCHAR(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  NIF VARCHAR(9) NOT NULL PRIMARY KEY
);

CREATE TABLE brand (
    name VARCHAR(100) NOT NULL PRIMARY KEY,
    supplier VARCHAR(9) NOT NULL,
    FOREIGN KEY (supplier) REFERENCES supplier(NIF)
);

CREATE TABLE glass (
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    leftlenprescription DECIMAL NOT NULL,
    rightlenprescription DECIMAL NOT NULL,
    frametype ENUM('RIMLEESS','PLASTIC','METAL')NOT NULL,
    framecolor VARCHAR(10) NOT NULL,
    leftlencolor VARCHAR(10) NOT NULL,
    rightlencolor VARCHAR(10) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (brand,model),
    FOREIGN KEY (brand) REFERENCES brand(name)

);

CREATE TABLE client (
    name VARCHAR(100) NOT NULL,
    postalcode VARCHAR(5) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    registrationdate DATE NOT NULL,
    recommendedby VARCHAR(100) NULL,
    PRIMARY KEY (name)
);

CREATE TABLE employee(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE sell(
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    client VARCHAR(100) NOT NULL,
    solddate DATE NOT NULL,
    employee INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    PRIMARY KEY(brand,model,client,solddate),
    FOREIGN KEY (brand,model) REFERENCES glass(brand,model),
    FOREIGN KEY (client) REFERENCES client(name),
    FOREIGN KEY (employee) REFERENCES employee(id)
);

INSERT INTO supplier(name,street,num,door,floorhouse,city,postalcode,country,telephone,fax,NIF) VALUES('General óptica','calle de la calle',10,1,2,'Barcelona',08911,'spain','933333333','934444444','34467543E');

INSERT INTO brand(name,supplier) VALUES('Rayban','34467543E');

INSERT INTO glass(brand,model,leftlenprescription,rightlenprescription,frametype,framecolor,leftlencolor,rightlencolor,price) VALUES('Rayban','Classicglass',2,2,'PLASTIC','red','red','red',100);

INSERT INTO client(name,postalcode,phone,email,registrationdate,recommendedby) VALUES('Pedro Reyes','09999','933333333','pedro@gmail.com','2024-01-01',null);

INSERT INTO employee(name) VALUES('Juan Costa');

INSERT INTO sell(brand,model,client,solddate,employee,quantity) VALUES('Rayban','Classicglass','Pedro Reyes','2025-01-01',1,1);
INSERT INTO sell(brand,model,client,solddate,employee,quantity) VALUES('Rayban','Classicglass','Pedro Reyes','2026-01-01',1,1);
INSERT INTO sell(brand,model,client,solddate,employee,quantity) VALUES('Rayban','Classicglass','Pedro Reyes','2027-01-01',1,1);
SELECT brand,model,client,solddate,employee,quantity FROM sell WHERE solddate BETWEEN '2025-01-01' AND '2026-01-01';
SELECT DISTINCT s.brand,s.model FROM sell AS s JOIN employee as e ON s.employee = e.id WHERE e.name='Juan Costa';

SELECT DISTINCT s.name, s.NIF FROM supplier s
WHERE EXISTS (
SELECT 1 FROM sell se JOIN glass g
ON se.brand = g.brand AND se.model = g.model
JOIN brand b ON g.brand = b.name
WHERE b.supplier = s.NIF
);
