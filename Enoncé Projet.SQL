Objectif : Créer une DB où vs indiquer ds 1 table task ts sujets appris sur SQL (CREATE, ALTER, UPDATE...)

-- Pour suppr 1DB :

DROP DATABASE [IF EXISTS] database_name;
DROP SCHEMA [IF EXISTS] database_name;
-- Les 2 Qry sont équivalentes

-- Pour créer 1DB :

CREATE DATABASE [IF NOT EXISTS] database_name
[CHARACTER SET charset_name]
[COLLATE collation_name]

-- Si le CHARCTER SET / COLLATE ne sont pas renseignés, MySQL créera la DB par défaut (latin1).

-- Pr retrouver le code de création, on lance SHOW :

SHOW CREATE DATABASE testdb; -- Par défaut : latin1

+----------+-------------------------------------------------------------------+
| Database | Create Database                                                   |
+----------+-------------------------------------------------------------------+
| testdb   | CREATE DATABASE `testdb` /*!40100 DEFAULT CHARACTER SET latin1 */ |
+----------+-------------------------------------------------------------------+

-- Q : Créer 2DB testdb1 (avec du code) et testdb2 (avec MySQLWorkBench ou HeidiSQL) et supp la testdb2 (avec du code).

CREATE DATABASE testdb /* !40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ ;

-- Demo workbench/HeidiSQL pr la création de testdb2


-- Créer 1table

CREATE TABLE [IF NOT EXISTS] table_name(
    column_name data_type(length) [NOT NULL] [DEFAULT value] [AUTO_INCREMENT],
    PRIMARY KEY (col1,col2,...) -- Déclarer une PK
) ENGINE=storage_engine ;  -- Par défaut : InnoDB (gère les FK, transactions, ...)

-- Q : Créer 1table tasks dans la DB testdb ?

CREATE TABLE IF NOT EXISTS tasks (
    task_id INT ,
    title VARCHAR(255) NOT NULL,
    start_date DATETIME,
    end_date DATETIME,
    -- status TINYINT NOT NULL,
    -- priority TINYINT NOT NULL,
    description TEXT,
    PRIMARY KEY (task_id)
)  ENGINE=INNODB;

-- ALTER TABLE
-- Q : Modifier task_id en AUTO_INCREMENT ?

ALTER TABLE tasks
CHANGE COLUMN task_id task_id INT(11) AUTO_INCREMENT;

-- Insérer des données pr le vérifier ?

INSERT INTO tasks(title, start_date, end_date, description)
VALUES('Learn MySQL CREATE TABLE',
       Now(),
       Now(),
      'Practicing MySQL CREATE TABLE statement');

INSERT INTO tasks(title, start_date, end_date, description)
VALUES('Learn MySQL ALTER TABLE',
       Now(),
       Now(),
      'Practicing MySQL ALTER TABLE statement');

SELECT * FROM tasks ;

-- Cmnt fonctionne AUTO_INCREMENT ?
-- Q : Créer 1table employees(emp_no, first_name, last_name) ?

CREATE TABLE employees (
    emp_no INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Q : Inserer les valeurs suivantes ?
INSERT INTO employees(first_name,last_name)
VALUES('John','Doe'),
      ('Mary','Jane');

SELECT * FROM employees ;

-- Q : Supp l'employé dont emp_no = 2 ?
DELETE FROM employees
WHERE
    emp_no = 2;

SELECT * FROM employees ;

-- Q : Inserer un nouvel employé  ?

INSERT INTO employees(first_name,last_name)
VALUES('Jack','Lee');

SELECT * FROM employees ;
-- On passe à emp_no = 3 (pas de recyclage des ID ; parc qu'on pense que MySQL lui passera emp_no = 2)

-- Q : Faire en sorte que emp_no = 3 prennent l'ID de emp_no = 1
-- R : MySQL est garante de la fiabilité et la cohérence de la PK.
-- S : ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
UPDATE employees
SET
    first_name = 'Joe',
    emp_no = 1
WHERE
    emp_no = 3;

-- Q : MAJ emp_no = 3 à 10 ?
-- C'est possible de changer la valeur

UPDATE employees
SET
    first_name = 'Joe',
    emp_no = 10
WHERE
    emp_no = 2;

-- Q : Inserer un nouvel employe ?
-- R : On vérifie que MySQL garde le bon ordre des PK.

INSERT INTO employees(first_name,last_name)
VALUES('Wang','Lee');

-- Pr vérifier le dernier emp_no renseigné :
SELECT LAST_INSERT_ID() ;

-- Gestion des NULL
-- Bonne pratique : Déclarer le plus svt cols en NOT NULL en affectant aussi une valeur par défaut.
-- La gestion des NULL rend les Qry plus complexes (donc plus d'effort de votre part).

Exemple :

CREATE TABLE inventory (
    material_no VARCHAR(18),
    warehouse_no VARCHAR(10),
    quantity DECIMAL(19 , 2 ) NOT NULL DEFAULT 0,
    base_unit VARCHAR(10) NOT NULL,
    PRIMARY KEY (material_no , warehouse_no)
);

-- Q : Inserer ds la table 'tasks' ?

INSERT INTO tasks(title ,start_date, end_date)
VALUES('Learn MySQL NOT NULL constraint', Now(), Now()),
      ('Check and update NOT NULL constraint to your database', NOW(), NULL);

-- Ds l'exemple, la valeur par defaut pr la colonne 'quantity' est 0. Parce qu'au moment où vs ajouter une ligne ds la table 'inventory', la valeur de la quantity est 0, mais not NULL.

-- Q : Quelles sont les tasks dont la date de fin est manquantes ?

SELECT * FROM tasks WHERE end_date IS NULL;

-- Q : Remplir la date de fin (par ex  + 24H) ?

UPDATE tasks SET end_date = start_date + INTERVAL 1 DAY WHERE end_date IS NULL;

-- Q : Changer le type de la colonne "end_date" en NOT NULL  ?

ALTER TABLE tasks
CHANGE end_date end_date DATETIME NOT NULL;

DESC tasks ;

-- ALTER TABLE : ajouter/supp/renommer une colonne
-- Q : Ajouter une colonne "complete" apres "description" ?

ALTER TABLE tasks
ADD COLUMN complete DECIMAL(2,1) NULL
AFTER description;

ALTER TABLE tasks
DROP COLUMN description;

ALTER TABLE tasks
RENAME TO work_items;


-- Les PK, les FK en profondeur

CREATE TABLE users(
   user_id INT AUTO_INCREMENT PRIMARY KEY, -- la PK est déclaré au début
   username VARCHAR(40),
   password VARCHAR(255),
   email VARCHAR(255)
);

CREATE TABLE roles(
   role_id INT AUTO_INCREMENT,
   role_name VARCHAR(50),
   PRIMARY KEY(role_id) 	-- la PK est déclaré à la fin
);

-- Table de jointure : relation many-to-many
CREATE TABLE user_roles(
   user_id INT NOT NULL,
   role_id INT NOT NULL,
   PRIMARY KEY(user_id, role_id), 	-- PK composite
   FOREIGN KEY(user_id) REFERENCES users(user_id),
   FOREIGN KEY(role_id) REFERENCES roles(role_id)
);

-- définir la PK avec ALTER TABLE

CREATE TABLE t1(
   id INT,
   title VARCHAR(255) NOT NULL
);

ALTER TABLE t1
ADD PRIMARY KEY(id);


-- FK en profondeur

-- sans ALTER TABLE

CREATE TABLE categories(
   cat_id int not null auto_increment primary key,
   cat_name varchar(255) not null,
   cat_description text
) ENGINE=InnoDB;

CREATE TABLE products(
   prd_id int not null auto_increment primary key,
   prd_name varchar(355) not null,
   prd_price decimal,
   cat_id int not null,
   FOREIGN KEY fk_cat(cat_id)
   REFERENCES categories(cat_id)
   ON UPDATE CASCADE
   ON DELETE RESTRICT 	-- Rejet de tte suppression
)ENGINE=InnoDB;


-- Avec ALTER TABLE

-- Q : Créer une nouvelle table vendors ?

CREATE TABLE vendors(
    vdr_id int not null auto_increment primary key,
    vdr_name varchar(255)
)ENGINE=InnoDB;

-- Q : Ajouter à la table products le vendor_id
ALTER TABLE products
ADD COLUMN vdr_id int not null AFTER cat_id;

-- Q : Déclarer la FK ?

ALTER TABLE products
ADD FOREIGN KEY fk_vendor(vdr_id)
REFERENCES vendors(vdr_id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

-- Maintenant, la table "products" possède 2 FK, la 1è refere vers "categories" table et la 2è refere vers la table "vendors".

-- Q : Supp une FK ?

ALTER TABLE products
DROP FOREIGN KEY products_ibfk_1;

ALTER TABLE products
DROP FOREIGN KEY products_ibfk_2;

-- Q : Désactiver la FK ?

SET foreign_key_checks = 0;


-- Ajouter une contrainte d'Unicité

-- On souhaite ajouter une contrainte : username et email soient uniques

ALTER TABLE users
ADD UNIQUE INDEX username_unique (username ASC) ;

ALTER TABLE users
ADD UNIQUE INDEX  email_unique (email ASC) ;

-- Autre exemple d'unicité

CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(12) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT uc_name_address UNIQUE (name , address)
);

-- S : Chq suppliers a un num de tél unique !
-- S : 2 suppliers ne peuvent pas avoir le même nom et la même à la fois !

-- 1è insertion pr tester les contraintes
INSERT INTO suppliers(name, phone, address)
VALUES('ABC Inc', '408-908-2476','4000 North 1st Street, San Jose, CA, USA');

-- 2è insertion avec le même num de tél
INSERT INTO suppliers(name, phone, address)
VALUES('XYZ Corporation', '408-908-2476','4001 North 1st Street, San Jose, CA, USA');

error :
Error Code: 1062. Duplicate entry '408-908-2476' for key 'phone'

-- Corrigeons le Pb :

INSERT INTO suppliers(name, phone, address)
VALUES('XYZ Corporation', '408-908-2567','400 North 1st Street, San Jose, CA, USA');

-- Test sur la 2è contrainte : nom et adresse (unique)

INSERT INTO suppliers(name, phone, address)
VALUES('XYZ Corporation', '408-908-102','400 North 1st Street, San Jose, CA, USA');

-- Violation de la contrainte d'unicité
Error Code: 1062. Duplicate entry 'XYZ Corporation-400 North 1st Street, San Jose, CA, USA' for key 'name'

Q : Supp un INDEX ?

DROP INDEX uc_name_address ON suppliers;


SHOW INDEX FROM suppliers;

-- Instaurer une conrainte avec ALTER TABLE

ALTER TABLE suppliers
ADD CONSTRAINT uc_name_address UNIQUE (name,address);


-- Cmnt valider vos données (CHECK) ?

CREATE TABLE IF NOT EXISTS parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10 , 2 ) NOT NULL CHECK(cost > 0), -- cost doit être positif
    price DECIMAL (10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10 , 2 ) NOT NULL CHECK (cost > 0),
    price DECIMAL(10 , 2 ) NOT NULL CHECK (price > 0),
    CHECK (price >= cost) 	-- prix doit être sup ou égal au coût
);



