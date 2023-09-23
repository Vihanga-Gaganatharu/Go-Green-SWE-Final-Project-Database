DROP DATABASE GoGreen;
CREATE DATABASE GoGreen;
USE GoGreen;

CREATE TABLE IF NOT EXISTS employee
(
    nic       VARCHAR(15) PRIMARY KEY,
    fist_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    city      VARCHAR(45),
    lane      VARCHAR(45),
    street    VARCHAR(45),
    home_no   VARCHAR(45),
    email     VARCHAR(45) UNIQUE,
    mobile_no VARCHAR(45) UNIQUE

);
CREATE TABLE IF NOT EXISTS attendance
(
    date        DATE,
    in_time     TIME,
    out_time    TIME,
    employee_id VARCHAR(45),
    CONSTRAINT FOREIGN KEY attendance (employee_id) REFERENCES employee (nic) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS salary
(
    salary      DOUBLE,
    date        DATE,
    employee_id VARCHAR(45),
    CONSTRAINT FOREIGN KEY salary (employee_id) REFERENCES employee (nic) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS plant
(
    plant_id              VARCHAR(15) PRIMARY KEY,
    plant                 VARCHAR(45),
    min_soil_moisture     DECIMAL,
    max_soil_moisture     DECIMAL,
    avg_soil_moisture     DECIMAL,
    min_temp              DECIMAL,
    max_temp              DECIMAL,
    avg_temp              DECIMAL,
    harvest_time          int,
    life_time             int,
    water_per_day         int,
    water_liter_per_day   decimal,
    time_paired_for_water DECIMAL,
    description           TEXT
);
# to be continue dru & fre
CREATE TABLE IF NOT EXISTS `group`
(
    group_id    VARCHAR(15) PRIMARY KEY,
    qty         int,
    date        DATE,
    description TEXT,
    status      ENUM ('On Live','Dead'),
    Damage      int,
    plant_id    VARCHAR(15),
    CONSTRAINT FOREIGN KEY `group` (plant_id) REFERENCES plant (plant_id) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS green_house
(
    green_house_id VARCHAR(15) PRIMARY KEY,
    date           DATE,
    location       TEXT,
    apply_to_water ENUM ('MANUAL','AUTO') DEFAULT 'AUTO'
);
CREATE TABLE IF NOT EXISTS green_house_details
(
    green_house_id VARCHAR(15),
    group_id VARCHAR(15),
    CONSTRAINT FOREIGN KEY  (group_id) REFERENCES `group` (group_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY  (green_house_id) REFERENCES green_house (green_house_id) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS green_house_section
(
    green_house_section_id VARCHAR(15) PRIMARY KEY,
    section_id             VARCHAR(45),
    plant int ,
    plant_limit int ,
    CONSTRAINT FOREIGN KEY green_house_section (section_id) REFERENCES green_house (green_house_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS water
(

    water_id      VARCHAR(45) PRIMARY KEY,
    time          TIME    not null,
    date          DATE    not null,
    states        ENUM ('auto','manual'),
    temp          DECIMAL not null,
    soil_moisture DECIMAL not null

);
CREATE TABLE IF NOT EXISTS water_apply_section
(
    water_id               VARCHAR(45),
    green_house_section_id VARCHAR(15),
    CONSTRAINT FOREIGN KEY (green_house_section_id) REFERENCES green_house_section (green_house_section_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (water_id) REFERENCES water (water_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS maintenance
(
    employee_nic     VARCHAR(15),
    group_id         VARCHAR(15),
    date             DATE not null,
    start_time       TIME not null,
    end_time         TIME not null,
    maintenance_type TEXT not null,
    description      TEXT,
    CONSTRAINT FOREIGN KEY (employee_nic) REFERENCES employee (nic) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (group_id) REFERENCES `group` (group_id) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Fertilizer_drugs
(
    fd_id       VARCHAR(15) PRIMARY KEY,
    fd          VARCHAR(45) not null,
    category    ENUM ('fertilizer','drugs'),
    qty         DECIMAL,
    description TEXT

);

CREATE TABLE IF NOT EXISTS Fertilizer_drugs_supply
(
    employee_nic VARCHAR(15),
    fd_id        VARCHAR(15),
    qty          DECIMAL,
    date         DATE,
    time         TIME,
    description  TEXT,
    made_date    DATE,
    expire_date  DATE,
    CONSTRAINT FOREIGN KEY (employee_nic) REFERENCES employee (nic) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (fd_id) REFERENCES Fertilizer_drugs (fd_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Fertilizer_drugs_maintenance
(
    Fertilizer_drugs_maintenance_id VARCHAR(15),
    group_id                        VARCHAR(15),
    fd_id                           VARCHAR(15),
    date                            DATE not null,
    start_time                      TIME not null,
    end_time                        TIME not null,
    maintenance                     TEXT,
    description                     TEXT,
    CONSTRAINT FOREIGN KEY (fd_id) REFERENCES Fertilizer_drugs (fd_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (group_id) REFERENCES `group` (group_id) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Fertilizer_drugs_maintenance_empower
(
    employee_nic VARCHAR(15),
    description  TEXT,
    CONSTRAINT FOREIGN KEY (employee_nic) REFERENCES employee (nic) ON UPDATE CASCADE ON DELETE CASCADE
);