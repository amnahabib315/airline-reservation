select concat(f_name ," ",l_name) as full_name,email from passenger;
select sum(price),pay_method from ticket group by pay_method;
select*from booking where status in("confirmed" ,"pending");
select count(b_id) as total_bookings ,f_id from booking group by f_id having total_bookings>1;
select*from passenger order by DOB ;  -- in dob oldest dob are always smallest
select price+500 as new_price from ticket;
select*from passenger where f_name like '%A';
select*from passenger where p_id in(select p_id from booking);

select*from flight where f_id in (select f_id from booking where status="confirmed");

select*from passenger where p_id 
in(select p_id from booking where b_id 
in (select b_id from ticket where price=
 (select max(price) from ticket)));
 
select*from ticket where b_id in 
(select b_id from booking where s_id in
(select s_id from seat where seat_type =
 (select seat_type from seat_class where base_price=
 (select max(base_price) from seat_class))));
 
 select*from booking inner join passenger on booking.p_id=passenger.p_id;
 
 select*from seat left join seat_class on seat.seat_type=seat_class.seat_type;
 
select f_name,price,status from passenger 
inner join booking on booking.p_id=passenger.p_id 
inner join ticket on booking.b_id=ticket.b_id where status="confirmed";
select*from passenger join  booking on booking.p_id=passenger.p_id;
select*from passenger p join booking b on b.p_id=p.p_id join cancellation c on b.b_id=c.booking_id;

select f.f_no,dep.name as departure,arr.name as arrival
 from flight f join airport dep on dep.airport_id=f.dep_airport_id
 join airport arr on arr.airport_id=f.arr_airport_id;
 
 desc booking;
 
select now(); -- returns current date and time
SELECT CURDATE();

select timestampdiff(hour,(select dep_time from flight where f_id=1),  -- find the hour difference between flights
 (select dep_time from flight where f_id=3)) as hour_diff;
 
 SELECT DATEDIFF('2025-06-10', '2025-06-01') AS days; -- days difference
 select datediff((select date from booking where b_id=1),
 (select dep_time from flight where f_id=1)) as days;
 
 select date(issue_date) from ticket;
 
 select*from booking;
 
 select*from flight where status='scheduled';
 select*from passenger where F_name like 'A%';
 select*from passenger where cnic like '%22%';
 select*from flight where dep_airport_id=1 OR arr_airport_id=4;
 select*from flight order by dep_time;
 select*from ticket order by price desc limit 3;
 select count(p_id) as total_passengers from passenger;
 select avg(price) from ticket;
 select sum(price)-sum(refund_amount) from ticket t left join cancellation c on t.b_id=c.booking_id;
select count(b_id),f_id from booking group by f_id;
select count(b_id),p_id from booking group by p_id;

select count(t_id),pay_method from ticket group by pay_method;
select*from seat_class;

select b.*,p.F_name from -- gives complete one table
 booking b join passenger p on b.p_id=p.p_id;
 
 select p.F_name,b.b_id,f.f_no from
 passenger p join booking b 
 on b.p_id=p.p_id join flight f on b.f_id=f.f_id;
 
 select t.price,b.status from ticket t join booking b on t.b_id=b.b_id;
 select p.F_name,f.f_no from passenger p join booking b on b.p_id=p.p_id join flight f on b.f_id=f.f_id; 
 select*from booking where f_id in(select f_id from flight where status='delayed');
 select*from passenger where p_id in(select p_id from booking where status='confirmed');
 select*from flight where dep_time>'2025-06-01 10:00:00';
 select year(now())-year(DOB) as age from passenger;
 select f_id,f_no,timestampdiff(hour,dep_time,arr_time)as flight_duration from flight;
 -- timestampdiff ma do dates da to wo khud hours ka difference nikal leta

select (a.capacity-count(b.s_id)) as available_seats,a.model
 from aircraft a join seat s on a.aircraft_id=s.aircraft_id 
 left join booking b on b.s_id=s.s_id and  b.status!='cancelled'
 group by a.model,a.capacity;
 select*from flight;
 
 select (a.capacity-count(b.s_id)) as available_seats,f.f_id
 from flight f join seat s on a.aircraft_id=s.aircraft_id 
 left join booking b on b.s_id=s.s_id and  b.status!='cancelled'
 group by a.model,a.capacity;
 
 select c.city_name,count(a.airport_id) 
 from city c join airport a on a.city_id=c.city_id
 group by c.city_name;
 
 select F_name  from passenger where p_id in
 (select p_id from booking where b_id in
 (select b_id from ticket where pay_method='card'));
 
 select distinct L_name from passenger;
 SELECT F_name || ' booked a flight'
FROM passenger;
desc flight;
select f_no,status from flight;
select distinct status from booking;
select price+1000 as new_price from ticket;
select price*0.5 as if_refunded from ticket;

select concat(F_name, " booked a ticket") from passenger;
select* from passenger where f_name="Ahmed";
select*from passenger where year(DOB) between 1990 and 2000;
select*from flight where dep_airport_id in (1,2);
select*from passenger where F_name like "A%";
select*from passenger where email like "%gmail.com";

select*from flight where status="Scheduled" and aircraft_id=1;
select*from ticket order by price;
select*from passenger order by DOB desc;
select*from flight order by dep_time;
desc flight;
select*from ticket order by pay_method,price desc;
select* from passenger where F_name like"A%" and year(DOB)>1995;
select*from booking where status!="cancelled";

select*from ticket where pay_method="online" and price>10000;
SELECT SUBSTR(email,1,5)
FROM passenger;

SELECT LPAD(F_name,10,'*')
FROM passenger;

SELECT DATE_FORMAT(dep_time,'%d-%m-%Y')
FROM flight;

SELECT UPPER(SUBSTR(F_name,1,3))
FROM passenger;

select upper(concat(F_name," ",L_name)) from passenger;
select substr(email,1,4) from passenger;
select length(concat(F_name," ",L_name)) from passenger;
select instr(email,'@') from passenger;
select lpad(F_name,12,'*') from passenger;
select round(price,-3) from ticket;
select mod(price,1000) from ticket;
select truncate(price,1) from ticket;
select curdate();
select*from flight where dep_time=curdate()+adddate(curdate(),5);
select last_day(curdate());
select year(curdate())-year(DOB) as age from passenger;
select date_format(date(dep_time),'%d-%m-%y') from flight;
select str_to_date('2025-06-01','%Y-%m-%d');

select ifnull (refund_amount,0) from cancellation;

select case
when status="confirmed"  then "booking is confirmed"
when status="pending"  then "pay for ticket to confirm"
when status="cancelled"  then "collect your refund"
else "no problem"
end from booking;
select upper(substr(F_name,1,3)) from passenger;
select lower(concat(F_name," ",L_name)),length(concat(F_name," ",L_name)) from passenger;
select* from passenger where email like '%gmail.com';
select*from flight where f_no like"%10%";
select length(concat(F_name," ",L_name)) as n_l from passenger where length(concat(F_name," ",L_name))>5;
select price+(price*0.15) as tax_apply from ticket;
select*from booking where year(date)=2025 and month(date)=05;
SELECT*
FROM passenger
CROSS JOIN flight;

select p.f_name,f.f_no,t.price from
 passenger p join booking b on p.p_id=b.b_id join flight f on b.f_id=f.f_id 
 join ticket t on t.b_id=b.b_id;
 
select p.f_name,t.price from passenger p 
join booking b on p.p_id=b.p_id 
join ticket t on b.b_id=t.t_id;

select f.f_no,a.model from flight f join aircraft a on f.aircraft_id=a.aircraft_id;

select s.s_no,a.model from seat s join aircraft a on s.aircraft_id=a.aircraft_id;

select f.f_no,dep.name as dep_airport,arr.name as arrival_airport from flight f 
join airport dep on f.dep_airport_id=dep.airport_id 
join airport arr on f.arr_airport_id=arr.airport_id ;

select p.*,b.* from passenger p left join booking b on p.p_id=b.b_id;

select b.b_id,f.* from booking b join flight f on f.f_id=b.f_id;
select * from passenger cross join flight;

select f.*,t.pay_method from flight f 
join booking b on b.f_id=f.f_id 
join ticket t on t.b_id=b.b_id where pay_method='online';

select p.*,s.seat_type from passenger p 
join booking b on p.p_id=b.p_id
join seat s on s.s_id=b.s_id where seat_type='economy';

select booking_id,refund_amount from cancellation;

select count(b.b_id),f.f_no from booking b join flight f on b.f_id=f.f_id group by f_no;

select sum(t.price) as revenue ,f.f_no from ticket t
join booking b on t.b_id=b.b_id 
join flight f on f.f_id=b.f_id group by f_no;

select count(b.b_id) as total,f.f_no from booking b join flight f on b.f_id=f.f_id group by f_no having total>1;

select p.* from passenger p join booking b on
p.p_id=b.b_id where b.status="pending";

SELECT STDDEV(price),VARIANCE(price) FROM ticket;

select count(b_id),status from booking group by status;

select f.f_no,sum(price) as revenue_per_flight from flight f join booking b
on f.f_id=b.f_id join ticket t on t.b_id=b.b_id group by f_no;

select concat(p.F_name, " ", p.L_name) as name, count(b.b_id) as total from passenger p
 join booking b on p.p_id=b.p_id group by name;
 
 select concat(F_name, " ", L_name) 
 from passenger where p_id in
 (select p_id from booking where b_id in
 (select b_id from ticket where price in
 (select max(price) from ticket)));
 
select f_id from flight f where 
(select count(b_id) as booking_count from booking b where f.f_id=b.f_id)>
(select avg(cnt) from 
(select count(b_id) as cnt from booking group by f_id) as flight_count);

select * from passenger where p_id in 
(select p_id from booking where f_id in
(select f_id from flight where dep_airport_id in
(select airport_id from airport where city_id in
(select city_id from city where city_name="Karachi"))));

select model from aircraft where aircraft_id in
(select aircraft_id from flight where status='delayed');

select*from ticket where price=(select max(price) from ticket where pay_method='cash');

select* from passenger where P_id in(select p_id from booking where status='pending');

select city_name from city where city_id not in 
(select city_id from airport where airport_id in
(select dep_airport_id from flight));

select s_no from seat where s_id in 
(select s_id from booking where status='cancelled');

select pay_method,sum(price) from ticket group by pay_method order by sum(price) desc limit 1;

CREATE VIEW passenger_booking_view AS
SELECT p.F_name, p.L_name, b.b_id, b.status
FROM passenger p
JOIN booking b
ON p.p_id = b.p_id;

CREATE VIEW passenger_info AS
SELECT F_name,L_name, phone
FROM passenger;

SELECT * FROM passenger_booking_view;

create view flight_revenue_22 as
select f.f_no,sum(t.price) from flight f 
join booking b on f.f_id=b.f_id  join ticket t on t.b_id=b.b_id group by f.f_no;

select*from flight_revenue_22;
create or replace view passenger_booking_view AS
select concat(p.F_name,' ' ,p.L_name),b.status from passenger p join booking b on p.p_id=b.p_id;
CREATE VIEW flight_info AS
SELECT f_no, status, dep_time
FROM flight;

select*from flight_info;

create view confirmed as 
select*from booking where status='confirmed'
with check option;
select*from confirmed;

CREATE OR REPLACE VIEW flight_info AS
SELECT f_no, status, dep_time, arr_time
FROM flight;

CREATE VIEW confirmed_bookings AS
SELECT *
FROM booking
WHERE status='confirmed'
WITH CHECK OPTION;

CREATE INDEX idx_cnic
ON passenger(cnic);
SHOW INDEX FROM passenger;

DROP INDEX idx_cnic
ON passenger;

