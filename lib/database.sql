SHOW DATABASES;
DROP DATABASE IF EXISTS chronos;
CREATE DATABASE chronos;
USE chronos;

CREATE TABLE datas(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    datas DATE NOT NULL UNIQUE
);

CREATE TABLE professor (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    cpf CHAR(11) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    registration VARCHAR(15) NOT NULL,
    knowledge VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(75) NOT NULL,
    admRec BOOL NOT NULL,
    admGeneral BOOL NOT NULL
);

CREATE TABLE typeresources (
    id INTEGER AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(300) NOT NULL,
    quantity INTEGER NOT NULL,
    idProfessor INTEGER NOT NULL,
    shelfLife BOOL NOT NULL,
    CONSTRAINT PRIMARY KEY(id, idProfessor),
    CONSTRAINT fk_typeresources FOREIGN KEY (idProfessor) REFERENCES professor(id)
);

CREATE TABLE resources (
    id INTEGER AUTO_INCREMENT,
    number VARCHAR(11) NOT NULL,
    capacity INTEGER NOT NULL,
    information VARCHAR(200) NOT NULL,
    idTyperesources INTEGER NOT NULL,
    shelfLife BOOL NOT NULL,
    CONSTRAINT PRIMARY KEY (id, idTyperesources),
    CONSTRAINT fk_resources FOREIGN KEY (idTyperesources) REFERENCES typeresources(id)
);

CREATE TABLE dateresources(
    idDatas INTEGER NOT NULL,
    idResources INTEGER NOT NULL,
    CONSTRAINT PRIMARY KEY (idDatas, idResources),
    CONSTRAINT fk_dateresources1 FOREIGN KEY (idDatas) REFERENCES datas(id),
    CONSTRAINT fk_dateresources2 FOREIGN KEY (idResources) REFERENCES resources(id)
);

CREATE TABLE schedule(
    id INTEGER NOT NULL AUTO_INCREMENT,
    schedule TIME NOT NULL,
    idDatas INTEGER NOT NULL,
    idResources INTEGER NOT NULL,
    CONSTRAINT PRIMARY KEY (id, idDatas,idResources),
    CONSTRAINT fk_schedule1 FOREIGN KEY (idDatas) REFERENCES dateresources(idDatas),
    CONSTRAINT fk_schedule2 FOREIGN KEY (idResources) REFERENCES dateresources(idResources)
);

CREATE TABLE professorSchedule(
    idProfessor INTEGER NOT NULL,
    idSchedule INTEGER NOT NULL,
    schedule TIME NOT NULL UNIQUE,
    status BOOL NOT NULL,
    reason VARCHAR(300) NOT NULL,
    first BOOL NOT NULL,
    quantity INTEGER NOT NULL,
    end TIME NOT NULL,
    CONSTRAINT PRIMARY KEY (schedule, idProfessor, idSchedule),
    CONSTRAINT fk_professorSchedule1 FOREIGN KEY (idProfessor) REFERENCES professor(id),
    CONSTRAINT fk_professorSchedule2 FOREIGN KEY (idSchedule) REFERENCES schedule(id)
);