CREATE DATABASE airline_reservation_system;
USE airline_reservation_system;

CREATE TABLE city (
    city_id    INT PRIMARY KEY AUTO_INCREMENT,
    city_name  VARCHAR(100) NOT NULL,
    country    VARCHAR(100) NOT NULL
);

CREATE TABLE airport (
    airport_id  INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    city_id     INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE aircraft (
    aircraft_id  INT PRIMARY KEY AUTO_INCREMENT,
    model   VARCHAR(100) NOT NULL,
    capacity     INT NOT NULL,
    CHECK (capacity > 0)
);

CREATE TABLE seat_class (
    seat_type      VARCHAR(20)   PRIMARY KEY,
    baggage_limit  DECIMAL(5,2)  NOT NULL,
    base_price     DECIMAL(10,2) NOT NULL,
    CHECK (seat_type     IN ('economy', 'business', 'first')),
    CHECK (baggage_limit  > 0),
    CHECK (base_price     > 0)
);

CREATE TABLE seat (
    s_id         INT PRIMARY KEY AUTO_INCREMENT,
    s_no         VARCHAR(10) NOT NULL,
    aircraft_id  INT NOT NULL,
    seat_type    VARCHAR(20) NOT NULL,
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id),
    FOREIGN KEY (seat_type)   REFERENCES seat_class(seat_type),
    UNIQUE (s_no, aircraft_id)
);

CREATE TABLE passenger (
    p_id    INT PRIMARY KEY AUTO_INCREMENT,
    F_name  VARCHAR(50)  NOT NULL,
    L_name  VARCHAR(50)  NOT NULL,
    cnic    CHAR(13)     NOT NULL,
    DOB     DATE         NOT NULL,
    phone   VARCHAR(20)  NOT NULL,
    email   VARCHAR(100) NOT NULL,
    UNIQUE (cnic),
    UNIQUE (phone),
    UNIQUE (email)
);

CREATE TABLE flight (
    f_id            INT PRIMARY KEY AUTO_INCREMENT,
    f_no            VARCHAR(20) NOT NULL,
    dep_time        DATETIME    NOT NULL,
    arr_time        DATETIME    NOT NULL,
    status          VARCHAR(20) NOT NULL DEFAULT 'scheduled',
    dep_airport_id  INT NOT NULL,
    arr_airport_id  INT NOT NULL,
    aircraft_id     INT NOT NULL,
    FOREIGN KEY (dep_airport_id) REFERENCES airport(airport_id),
    FOREIGN KEY (arr_airport_id) REFERENCES airport(airport_id),
    FOREIGN KEY (aircraft_id)    REFERENCES aircraft(aircraft_id),
    CHECK (status IN ('scheduled', 'delayed', 'boarding',
                      'departed', 'landed', 'cancelled')),
    CHECK (arr_time > dep_time),
    CHECK (dep_airport_id != arr_airport_id)
);

CREATE TABLE booking (
    b_id    INT PRIMARY KEY AUTO_INCREMENT,
    p_id    INT         NOT NULL,
    f_id    INT         NOT NULL,
    s_id    INT         NOT NULL,
    date    DATE        NOT NULL,
    status  VARCHAR(20) NOT NULL DEFAULT 'pending',
    FOREIGN KEY (p_id) REFERENCES passenger(p_id),
    FOREIGN KEY (f_id) REFERENCES flight(f_id),
    FOREIGN KEY (s_id) REFERENCES seat(s_id),
    CHECK (status IN ('pending', 'confirmed',
                      'cancelled', 'completed')),
    UNIQUE (f_id, s_id)
);

CREATE TABLE ticket (
    t_id        INT PRIMARY KEY AUTO_INCREMENT,
    issue_date  DATE          NOT NULL,
    price       DECIMAL(10,2) NOT NULL,
    pay_method  VARCHAR(30)   NOT NULL,
    b_id        INT           NOT NULL,
    FOREIGN KEY (b_id) REFERENCES booking(b_id),
    UNIQUE (b_id),
    CHECK (price > 0),
    CHECK (pay_method IN ('cash', 'card', 'online'))
);

CREATE TABLE cancellation (
    booking_id     INT           NOT NULL,
    cancel_date    DATE          NOT NULL,
    cancelled_by   VARCHAR(20)   NOT NULL,
    refund_amount  DECIMAL(10,2) NOT NULL,
    refund_status  VARCHAR(20)   NOT NULL DEFAULT 'pending',
    PRIMARY KEY (booking_id),
    FOREIGN KEY (booking_id) REFERENCES booking(b_id),
    CHECK (cancelled_by  IN ('passenger', 'airline')),
    CHECK (refund_status IN ('pending', 'processed', 'denied')),
    CHECK (refund_amount >= 0)
);


INSERT INTO city (city_name, country) VALUES
('Karachi', 'Pakistan'),
('Lahore', 'Pakistan'),
('Islamabad', 'Pakistan'),
('Dubai', 'UAE');

select* from seat_class;

INSERT INTO airport (name, city_id) VALUES
('Jinnah International Airport', 1),
('Allama Iqbal International Airport', 2),
('Islamabad International Airport', 3),
('Dubai International Airport', 4);

INSERT INTO aircraft (model, capacity) VALUES
('Boeing 737', 150),
('Airbus A320', 180);

UPDATE aircraft SET capacity = 6 WHERE aircraft_id = 1;
UPDATE aircraft SET capacity = 6 WHERE aircraft_id = 2;

INSERT INTO seat_class VALUES
('economy', 20.00, 12000.00),
('business', 30.00, 40000.00),
('first', 40.00, 80000.00);

INSERT INTO seat (s_no, aircraft_id, seat_type) VALUES
('1A',1,'first'),
('1B',1,'first'),
('2A',1,'business'),
('2B',1,'business'),
('3A',1,'economy'),
('3B',1,'economy'),
('1A',2,'first'),
('1B',2,'first'),
('2A',2,'business'),
('2B',2,'business'),
('3A',2,'economy'),
('3B',2,'economy');

INSERT INTO passenger (F_name, L_name, cnic, DOB, phone, email) VALUES
('Ahmed','Khan','3520211111111','1990-05-15','03001111111','ahmed@gmail.com'),
('Sara','Ali','3520222222222','1995-08-22','03002222222','sara@gmail.com'),
('Usman','Malik','3520233333333','1988-03-10','03003333333','usman@gmail.com'),  
('Ayesha','Raza','3520244444444','2000-11-30','03004444444','ayesha@gmail.com'),
('Bilal','Hassan','3520255555555','1992-07-18','03005555555','bilal@gmail.com');

insert into passenger(F_name,L_name,cnic,DOB,phone,email)
values
('Zara','Noor','3740560487926','2003-12-12','03228777098','zara@gmail.com'),
('Bilal','Khan','3730570988927','2000-11-12','03329002509','bilal1@gmail.com');

INSERT INTO flight (f_no, dep_time, arr_time, status, dep_airport_id, arr_airport_id, aircraft_id) VALUES
('PK-101','2025-06-01 08:00:00','2025-06-01 10:00:00','scheduled',1,2,1),
('PK-102','2025-06-01 12:00:00','2025-06-01 14:30:00','scheduled',2,3,2),
('PK-103','2025-06-02 09:00:00','2025-06-02 13:00:00','delayed',3,4,1);

INSERT INTO booking (p_id, f_id, s_id, date, status) VALUES
(1,1,1,'2025-05-01','confirmed'),
(2,1,3,'2025-05-01','confirmed'),
(3,2,7,'2025-05-02','confirmed'),
(4,2,10,'2025-05-02','pending'),  -- when booking is pending its ticket is not genrated if its cancelled only status changed
(5,3,5,'2025-05-03','cancelled');

insert into booking(p_id,f_id,s_id,date,status) values
(6,3,4,'2025-05-04','pending'),
(7,3,6,'2025-05-04','pending');

 insert into booking(p_id,f_id,s_id,date,status) values
(7,2,11,'2025-05-04','pending');

INSERT INTO ticket (issue_date, price, pay_method, b_id) VALUES
('2025-05-01',80000.00,'card',1),
('2025-05-01',12000.00,'online',2),
('2025-05-02',40000.00,'cash',3);
INSERT INTO ticket (issue_date, price, pay_method, b_id) 
VALUES ('2025-05-03', 12000.00, 'cash', 5);  -- booking cancel ha par phla thi to ticket genrate hoa tha
insert into ticket(issue_date,price,pay_method,b_id)
values('2025-05-04',40000.00,'card',6); 
insert into ticket(issue_date,price,pay_method,b_id)
values('2025-05-06',12000.00,'online',14);

update booking set status='confirmed' where b_id=6;
update booking set status='confirmed' where b_id=14;

show tables;

select count(b_id) from booking where p_id=4;
-- truncate table cancellation;  to delete only data of table

update booking set status='cancelled' where b_id=6;

select status from  booking where b_id=5;
select s_id from booking where b_id=5;

INSERT INTO cancellation (booking_id, cancel_date, cancelled_by, refund_amount, refund_status) -- if flight cancelled by passenger
VALUES (
    5,
    '2025-05-04',
    'passenger',
    (SELECT price * 0.50 FROM ticket WHERE b_id = 5),
    'pending'
);
insert into cancellation(booking_id,cancel_date,cancelled_by,refund_amount,refund_status) values -- if airline cancels flight maybe due to invalid docs
(6,'2025-05-08','airline',
(select price*1.0 from ticket where b_id=6),'processed');

-- START TRANSACTION;
-- INSERT INTO booking(p_id,f_id,s_id,date,status)
-- VALUES(7,2,12,'2025-05-04','confirmed');
-- INSERT INTO ticket(issue_date,price,pay_method,b_id)
-- VALUES('2025-05-06',12000.00,'online',14);
-- COMMIT;

-- for calculating passengers age
SELECT F_name, L_name,
YEAR(NOW()) - YEAR(DOB) AS age
FROM passenger
WHERE p_id = 1;

-- for calculating available sets in flights
SELECT f.f_id, f.f_no, 
COUNT(s.s_id) - COUNT(b.b_id) AS available_seats
FROM flight f
JOIN seat s ON s.aircraft_id = f.aircraft_id
LEFT JOIN booking b ON b.s_id = s.s_id 
AND b.f_id = f.f_id 
AND b.status = 'confirmed'
GROUP BY f.f_id, f.f_no;

-- for calculating available sets in  aircrafts
select (a.capacity-count(b.s_id)) as available_seats,a.model
 from aircraft a join seat s on a.aircraft_id=s.aircraft_id 
 left join booking b on b.s_id=s.s_id and  b.status!='cancelled'
 group by a.model,a.capacity;

select timestampdiff(hour,(select dep_time from flight where f_id=1),  -- find the hour difference between flights
 (select dep_time from flight where f_id=3)) as hour_diff;
 
  SELECT DATEDIFF('2025-06-10', '2025-06-01') AS days; -- days difference
  select s.id 