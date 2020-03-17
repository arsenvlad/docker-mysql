# -- Create 3 simple databases with test tables and views

CREATE DATABASE db1;
USE db1;

CREATE TABLE table1 (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    date_created DATETIME NULL);

INSERT INTO table1 (first_name, date_created) VALUES ('John db1', '2020-03-13');
INSERT INTO table1 (first_name, date_created) VALUES ('Mary db1', '2020-03-12');

CREATE TABLE table2 (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    total INTEGER NULL);

INSERT INTO table2 (city, total) VALUES ('Chicago db1', 100);
INSERT INTO table2 (city, total) VALUES ('Seattle db1', 200);

CREATE TABLE table3 (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(50) NOT NULL,
    total DECIMAL(18,4) NULL);

INSERT INTO table3 (country, total) VALUES ('United States of America db1', 5.9999);
INSERT INTO table3 (country, total) VALUES ('Australia db1', 1000.1234);

CREATE VIEW view1 AS
SELECT * FROM table1;

CREATE VIEW view2 AS
SELECT * FROM table2;

CREATE VIEW view3 AS
SELECT * FROM table3;

# ---------------------------------------------------------------------

CREATE DATABASE db2;
USE db2;

CREATE TABLE table1 (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    date_created DATETIME NULL);

INSERT INTO table1 (first_name, date_created) VALUES ('John db2', '2020-03-13');
INSERT INTO table1 (first_name, date_created) VALUES ('Mary db2', '2020-03-12');

CREATE TABLE table2 (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    total INTEGER NULL);

INSERT INTO table2 (city, total) VALUES ('Chicago db2', 100);
INSERT INTO table2 (city, total) VALUES ('Seattle db2', 200);

CREATE VIEW view1 AS
SELECT * FROM table1;

CREATE VIEW view2 AS
SELECT * FROM table2;

# ---------------------------------------------------------------------

CREATE DATABASE db3;
USE db3;

CREATE TABLE table1 (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    date_created DATETIME NULL);

INSERT INTO table1 (first_name, date_created) VALUES ('John db3', '2020-03-13');
INSERT INTO table1 (first_name, date_created) VALUES ('Mary db3', '2020-03-12');

CREATE VIEW view1 AS
SELECT * FROM table1;

# -- Create non-root users and grant access

CREATE USER 'db1user'@'%' IDENTIFIED BY 'my-secure-pw';
GRANT SELECT ON db1.* TO 'db1user'@'%';

CREATE USER 'db2user'@'%' IDENTIFIED BY 'my-secure-pw';
GRANT SELECT ON db2.* TO 'db2user'@'%';

CREATE USER 'db3user'@'%' IDENTIFIED BY 'my-secure-pw';
GRANT SELECT ON db3.* TO 'db3user'@'%';

