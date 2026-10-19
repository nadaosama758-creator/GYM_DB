drop table members; 
drop table membership_plan;
drop table membership;
drop table trainers;
drop table fitness_classes;
drop table class_booking;
drop table payments;


--Part A — ERD Design
--Part B — Database Implementation
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>  1) Create Tables >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
create table members (
    member_id number constraint pk_members primary key,
    full_name varchar2(50) not null,
    email varchar2(100) constraint uq_email_members unique,
    phone varchar2(50),
    join_date date,
    city varchar2(50)
);
create table membership_plan(
    plan_id number constraint pk_membership_plan primary key,
    plan_name varchar2(100) not null,
    duration_months number,
    price number(8,2) 
);
create table memberships(
    membership_id number constraint pk_memberships primary key, 
    member_id number ,
    plan_id number ,
    start_date date,
    end_date date,
    membership_status varchar2(50),

    constraint fk_memberships_members foreign key (member_id) references members (member_id),
    constraint fk_memberships_membership_plan foreign key (plan_id) references membership_plan (plan_id)
);
create table trainers(
    trainer_id number constraint pk_trainers primary key, 
    full_name varchar2(100) not null, 
    specialization varchar2(100),
    hire_date date
);
create table fitness_classes(
    class_id number constraint pk_class primary key, 
    class_name varchar2(100) not null, 
    trainer_id number, 
    capacity number, 
    scheduled_at date,

    constraint fk_Fclass_trainers foreign key (trainer_id) references trainers (trainer_id)

);
create table class_booking(
    booking_id number constraint pk_booking primary key, 
    member_id number, 
    class_id number, 
    booking_date date, 
    attendance_status varchar2(50),

    constraint fk_Cbooking_members foreign key (member_id) references members (member_id),
    constraint fk_Cbooking_Fclass foreign key (class_id) references fitness_classes (class_id)

);
create table payments(
    payment_id number constraint pk_payments primary key, 
    membership_id number,
    payment_date date, 
    amount number constraint ck_payments_amount check (amount>0), 
    payment_method varchar2(50),
    payment_status varchar2(50),

    constraint fk_payments_memberships foreign key (membership_id) references memberships (membership_id)

);
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>  2) Insert Realistic Data >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- ==========================================
-- 1. Insert into members
-- ==========================================
INSERT INTO members VALUES (1, 'Ahmed Mahmoud', 'ahmed.m@email.com', '01012345678', TO_DATE('2026-01-10', 'YYYY-MM-DD'), 'Cairo');
INSERT INTO members VALUES (2, 'Fatma Omar', 'fatma.o@email.com', '01198765432', TO_DATE('2026-02-15', 'YYYY-MM-DD'), 'Alexandria');
INSERT INTO members VALUES (3, 'Youssef Tarek', 'youssef.t@email.com', '01233344455', TO_DATE('2026-03-01', 'YYYY-MM-DD'), 'Giza');
INSERT INTO members VALUES (4, 'Reem Fouad', 'reem.f@email.com', '01566677788', TO_DATE('2026-03-10', 'YYYY-MM-DD'), 'Aswan'); -- member with no memberships

-- ==========================================
-- 2. Insert into membership_plan
-- ==========================================
INSERT INTO membership_plan VALUES (10, 'Basic Monthly Plan', 1, 500.00);
INSERT INTO membership_plan VALUES (20, 'Quarterly Plan', 3, 1350.00);
INSERT INTO membership_plan VALUES (30, 'VIP Annual Plan', 12, 4500.00);
INSERT INTO membership_plan VALUES (40, 'Free Trial Plan', 0, 0.00); -- plan with no memberships

-- ==========================================
-- 3. Insert into trainers
-- ==========================================
INSERT INTO trainers VALUES (101, 'Amr Ibrahim', 'Bodybuilding', TO_DATE('2024-05-10', 'YYYY-MM-DD'));
INSERT INTO trainers VALUES (102, 'Sara Ali', 'Yoga & Fitness', TO_DATE('2024-08-15', 'YYYY-MM-DD'));
INSERT INTO trainers VALUES (103, 'Khaled Hassan', 'Cardio & Weight Loss', TO_DATE('2025-01-20', 'YYYY-MM-DD'));
INSERT INTO trainers VALUES (104, 'Mona Ibrahim', 'Zumba', TO_DATE('2025-06-01', 'YYYY-MM-DD')); -- trainer with no assigned classes
select * from TRAINERS;
delete from TRAINERS;
-- ==========================================
-- 4. Insert into fitness_classes  
-- ==========================================
INSERT INTO fitness_classes VALUES (1, 'Morning Yoga Class', 102, 20, TO_DATE('2026-03-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO fitness_classes VALUES (2, 'Full Body Cardio', 103, 15, TO_DATE('2026-03-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO fitness_classes VALUES (3, 'Iron Strength Training', 101, 10, TO_DATE('2026-03-21 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO fitness_classes VALUES (4, 'Evening Zumba Class', 102, 25, TO_DATE('2026-03-22 17:00:00', 'YYYY-MM-DD HH24:MI:SS')); -- class with no bookings

-- ==========================================
-- 5. Insert into memberships Table
-- ==========================================
INSERT INTO memberships VALUES (1, 1, 10, TO_DATE('2026-02-01', 'YYYY-MM-DD'), TO_DATE('2026-03-01', 'YYYY-MM-DD'), 'Active');
INSERT INTO memberships VALUES (2, 2, 20, TO_DATE('2026-02-15', 'YYYY-MM-DD'), TO_DATE('2026-05-15', 'YYYY-MM-DD'), 'Active');
INSERT INTO memberships VALUES (3, 3, 30, TO_DATE('2026-03-01', 'YYYY-MM-DD'), TO_DATE('2027-03-01', 'YYYY-MM-DD'), 'Active');
INSERT INTO memberships VALUES (4, 1, 20, TO_DATE('2026-03-10', 'YYYY-MM-DD'), TO_DATE('2026-06-10', 'YYYY-MM-DD'), 'Pending'); -- membership with no payments

-- ==========================================
-- 6. Insert into class_booking Table
-- ==========================================
INSERT INTO class_booking VALUES (1, 1, 1, TO_DATE('2026-03-18', 'YYYY-MM-DD'), 'Attended');
INSERT INTO class_booking VALUES (2, 2, 2, TO_DATE('2026-03-18', 'YYYY-MM-DD'), 'Confirmed');
INSERT INTO class_booking VALUES (3, 3, 3, TO_DATE('2026-03-19', 'YYYY-MM-DD'), 'Confirmed');

-- ==========================================
-- 7. Insert into payments
-- ==========================================
INSERT INTO payments VALUES (1, 1, TO_DATE('2026-02-01', 'YYYY-MM-DD'), 500.00, 'Credit Card', 'Completed');
INSERT INTO payments VALUES (2, 2, TO_DATE('2026-02-15', 'YYYY-MM-DD'), 1350.00, 'Cash', 'Completed');
INSERT INTO payments VALUES (3, 3, TO_DATE('2026-03-01', 'YYYY-MM-DD'), 4500.00, 'Bank Transfer', 'Pending');
INSERT INTO payments VALUES (4, 1, TO_DATE('2026-02-05', 'YYYY-MM-DD'), 150.00, 'Credit Card', 'Failed');

-- Commit changes to database
COMMIT;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>  3) SQL Queries >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/*1. Membership details. Display each membership ID, member name, plan name, start date, and membership status.
Include only memberships with matching member and plan records. Use INNER JOIN.*/

select ms.membership_id as "Membership ID",m.full_name as "Member Name",mp.plan_name as "Plan Name", ms.start_date as "Start Date" ,
 ms.membership_status as"Membership Status" 
 from MEMBERSHIPS ms inner join members m on ms.MEMBER_ID = m.MEMBER_ID 
 join MEMBERSHIP_PLAN mp on ms.PLAN_ID = mp.PLAN_ID; 

--==================================================================================
/*2. Members and memberships. List every member and any membership they have. Members who have never had a
membership must still appear. Use LEFT JOIN.*/

select  m.member_id ,ms.membership_id , m.full_name, ms.start_date , ms.end_date , ms.membership_status 
from members m left join memberships ms 
on m.member_id = ms.member_id
order by m.member_id;


--==================================================================================
/*3. Classes and bookings. List every fitness class and any booking made for it. Classes with no bookings must still
appear. Write the query using RIGHT JOIN by arranging the tables appropriately.*/

select fc.class_id , fc.class_name,  cb.booking_id , cb.booking_date 
from CLASS_BOOKING cb right join FITNESS_CLASSES fc 
on cb.CLASS_ID = fc.CLASS_ID;

--==================================================================================
/*4. Trainers and classes. Display every trainer and the classes they teach, including trainers who have no classes. Use
LEFT JOIN.*/

select t.trainer_id , full_name,SPECIALIZATION, class_id , class_name
from trainers t left join fitness_classes fc
on t.trainer_id = fc.trainer_id
order by t.trainer_id;

--==================================================================================
/*5. Plans summary. For each membership plan that has at least one membership, show the plan name, number of
memberships, and average plan price. Sort by average plan price from highest to lowest.*/

select mp.plan_name as "Plan Name", count(ms.membership_id) as "Number Of Memberships", avg(mp.price) as "Average"
from membership_plan mp inner join memberships ms on mp.plan_id = ms.plan_id
group by mp.plan_name , mp.PLAN_ID
order by avg(mp.price) desc;

--==================================================================================
/*6. Member booking counts. Display every member's name and total number of class bookings, including members with
zero bookings. Sort by booking count descending, then member name ascending.*/

select m.member_id, m.full_name as "member name", count(cb.class_id) as "total number of class bookings" 
from members m left join class_booking cb 
on m.MEMBER_ID = cb.MEMBER_ID
group by m.member_id, m.full_name
order by count(cb.class_id) desc, m.full_name asc;

--==================================================================================
/*7. Successful revenue by plan. For each membership plan with successful payments, calculate the total revenue
collected. Display the plan name and total revenue, sorted from highest to lowest.*/

select plan_name , sum(p.amount) as "total revenue" 
from MEMBERSHIP_PLAN mp inner join MEMBERSHIPS ms on mp.PLAN_ID = ms.PLAN_ID
join PAYMENTS p on p.MEMBERSHIP_ID = ms.MEMBERSHIP_ID
where p.payment_status='Completed'
group by plan_name 
order by sum(p.amount) desc;

--==================================================================================
/*8. Class booking counts. Show each fitness class and its number of bookings, including classes with zero bookings. Sort
from most booked to least booked.*/

select fc.class_id, fc.class_name, count(cb.booking_id) as "total_bookings"
from fitness_classes fc 
left join class_booking cb on fc.class_id = cb.class_id
group by fc.class_id, fc.class_name
order by count(cb.booking_id) desc;

--==================================================================================
/*9. Membership status label. Display each membership ID and its status label using CASE: 'Active Membership' for
Active, 'Expired Membership' for Expired, and 'Pending Membership' for Pending. Sort by membership ID.*/

select membership_id, 
       membership_status,
       case membership_status
           when 'Active' then 'Active Membership'
           when 'Expired' then 'Expired Membership'
           when 'Pending' then 'Pending Membership'
           else 'Unknown Status'
       end as "status_label"
from memberships
order by membership_id;

--==================================================================================
/*10. Member contact value. Display each member's name and a contact value: phone if available, otherwise email,
otherwise 'No contact details'. Use NVL or an equivalent Oracle-compatible expression.*/

INSERT INTO members (member_id,full_name,email,join_date,city) VALUES 
                    (5, 'Nada Osama', 'n.o@email.com', TO_DATE('2026-03-10', 'YYYY-MM-DD'), 'cairo'); --for test
--delete from members where full_name ='Nada Osama';

select full_name as "Name", coalesce (phone,email,'No contact details') as contact from members;

--==================================================================================
/*11. Amount paid per membership. Display every membership ID and the total amount paid against it. Memberships with
no payment records must show 0. Use NVL to handle a missing aggregate result.*/

select ms.membership_id, 
       nvl(sum(p.amount), 0) as "total_amount_paid"
from memberships ms
left join payments p on ms.membership_id = p.membership_id
group by ms.membership_id
order by ms.membership_id;

--==================================================================================
/*12. Trainer class totals. Display every trainer's name and the number of classes assigned to them, including trainers with
zero classes. Sort by class count descending.*/

select t.full_name as "Trainer Name", 
       count(fc.class_id) as "Total Classes"
from trainers t
left join fitness_classes fc on t.trainer_id = fc.trainer_id
group by t.trainer_id, t.full_name
order by count(fc.class_id) desc;

--==================================================================================
/*13. Payment status label. Display payment ID, membership ID, payment method, amount, payment date, and a CASE
label: 'Completed' for Successful, 'Pending' for Pending, and 'Not completed' for Failed. Sort by payment date newest
first.*/

select payment_id, 
       membership_id, 
       payment_method, 
       amount, 
       payment_date,
       case payment_status
           when 'Completed' then 'Completed'
           when 'Pending' then 'Pending'
           when 'Failed' then 'Not completed'
           else 'Unknown'
       end as "payment_status_label"
from payments
order by payment_date desc;

--==================================================================================
/*14. Payment statistics. For each payment method, show the total amount, average amount, minimum amount, maximum
amount, and number of payments.*/

select payment_method as "Payment Method",
       sum(amount) as "Total Amount",
       avg(amount) as "Average Amount",
       min(amount) as "Minimum Amount",
       max(amount) as "Maximum Amount",
       count(payment_id) as "Number of Payments"
from payments
group by payment_method;

--==================================================================================
/*15. Members with multiple successful payments. Display each member's name, number of successful payments, and
total amount paid from successful payments. Include only members with at least two successful payments, and sort by
total amount paid descending.*/

insert into payments (payment_id, membership_id, amount, payment_date, payment_method, payment_status)
values (10, 1, 500.00, to_date('2026-03-20', 'YYYY-MM-DD'), 'Cash', 'Completed');

--delete from payments where payment_id=10;

select m.full_name as "Member Name",
       count(p.payment_id) as "Successful Payments Count",
       sum(p.amount) as "Total Successful Amount"
from members m
join memberships ms on m.member_id = ms.member_id
join payments p on ms.membership_id = p.membership_id
where p.payment_status = 'Completed'
group by m.member_id, m.full_name
having count(p.payment_id) >= 2
order by sum(p.amount) desc;