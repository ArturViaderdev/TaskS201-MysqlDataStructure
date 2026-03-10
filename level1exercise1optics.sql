DROP DATABASE IF EXISTS optics;
CREATE DATABASE optics CHARACTER SET utf8mb4;
USE optics;

CREATE TABLE Supplier (
  name VARCHAR(100) NOT NULL,
  street VARCHAR(100) NOT NULL,
  number INT NOT NULL,
  door INT NOT NULL,
  floor INT NOT NULL,
  city VARCHAR(100) NOT NULL,
  postalcode VARCHAR(5) NOT NULL,
  country VARCHAR(100),
  telephone VARCHAR(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  NIF VARCHAR(9) NOT NULL PRIMARY KEY
);

CREATE TABLE Brand (
    name VARCHAR(100) NOT NULL PRIMARY KEY,
    supplier VARCHAR(100) NOT NULL
);

CREATE TABLE Glasses (
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    leftlenprescription DECIMAL NOT NULL,
    rightlenprescription DECIMAL NOT NULL,
    frametype INT NOT NULL,
    framecolor VARCHAR(10) NOT NULL,
    leftlencolor VARCHAR(10) NOT NULL,
    rightlencolor VARCHAR(10) NOT NULL,
    price DECIMAL NOT NULL,
    employeenamesoldby VARCHAR(100),
    PRIMARY KEY (brand,model)
);

CREATE TABLE Client (
    name VARCHAR(100) NOT NULL,
    postalcode VARCHAR(5) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    registrationdate DATE NOT NULL,
    recommendedby VARCHAR(100),
    PRIMARY KEY (name)
);
