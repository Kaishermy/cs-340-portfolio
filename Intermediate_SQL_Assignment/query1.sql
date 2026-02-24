-- Write the query to create the 4 tables below.
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS client;
CREATE TABLE client(
    id int AUTO_INCREMENT,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT full_name UNIQUE (first_name, last_name)
);

DROP TABLE IF EXISTS employee;
CREATE TABLE employee(
    id int AUTO_INCREMENT,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    start_date date NOT NULL,
    email varchar(255) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT full_name UNIQUE (first_name, last_name)
);

DROP TABLE IF EXISTS project;
CREATE TABLE project(
    id int AUTO_INCREMENT,
    title varchar(255) NOT NULL,
    comments text,
    cid int,
    PRIMARY KEY (id),
    FOREIGN KEY (cid) REFERENCES client(id),
    UNIQUE (title)
);

DROP TABLE IF EXISTS works_on;
CREATE TABLE works_on(
    pid int,
    eid int,
    due_date date NOT NULL,
    FOREIGN KEY (pid) REFERENCES project(id),
    FOREIGN KEY (eid) REFERENCES employee(id),
    CONSTRAINT PRIMARY KEY (eid, pid)
);

SET FOREIGN_KEY_CHECKS = 1;