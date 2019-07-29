DROP SCHEMA IF EXISTS Diagram_Projet_4;
CREATE SCHEMA Diagram_Projet_4;
USE Diagram_Projet_4;

-- CREATE TABLES

CREATE TABLE productlines (
	productLine INT AUTO_INCREMENT PRIMARY KEY,
    textDescription VARCHAR(250),
    htmlDescription VARCHAR(250),
    image BLOB
    );
    
    
    CREATE TABLE products (
	productCode VARCHAR(15) AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(70) NOT NULL,
    productLine VARCHAR(50) NOT NULL,
    productScale VARCHAR(10) NOT NULL,
    productVendor VARCHAR(50) NOT NULL,
    productDescription TEXT NOT NULL,
    quantityInStock SMALLINT(6) NOT NULL,
    buyPrice DECIMAL(10,2) NOT NULL,
    MSRP DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (productCode)
    );
    
    
    CREATE TABLE orderdetails (
	orderNumber INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(15) NOT NULL,
    quantityOrdered INT(11) NOT NULL,
    priceEach DECIMAL(10,2) NOT NULL,
    orderLineNumber SMALLINT(6) NOT NULL
    );
    
    
    CREATE TABLE orders (
	orderNumber INT(11) AUTO_INCREMENT PRIMARY KEY,
    orderDate DATE NOT NULL,
    requiredDate DATE NOT NULL,
    shippedDate DATE DEFAULT NULL,
    status VARCHAR(15) NOT NULL,
    comments TEXT,
    customerNumber INT(11) NOT NULL
    );


    CREATE TABLE payments (
	customerNumber INT(11) NOT NULL,
    checkNumber VARCHAR(50) NOT NULL,
    paymentDate DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (customerNumber,checkNumber)
    );
    
   CREATE TABLE customers (
	customerNumber INT(11) AUTO_INCREMENT PRIMARY KEY,
    custumerName VARCHAR(50) NOT NULL,
    contactLastName VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postalCode VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    salesRepEmployeeNumber INT(11) DEFAULT NULL,
    creditLimit DECIMAL(10,2) DEFAULT NULL); 
    
    
    CREATE TABLE offices (
	officeCode VARCHAR(10) AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    postalCode VARCHAR(15) NOT NULL,
    territory VARCHAR(10) NOT NULL
    );
    
    
	CREATE TABLE employees (
	employeeNumber INT(11) AUTO_INCREMENT PRIMARY KEY,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    extension VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    officeCode VARCHAR(50) NOT NULL,
    reportsTo INT(11) NOT NULL,
    jobTitle VARCHAR(50) NOT NULL
    );
    
    
    
    
    