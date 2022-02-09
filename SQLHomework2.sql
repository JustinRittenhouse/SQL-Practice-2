-- SQL PRACTICE HOMEWORK #2 February 9, 2022
-- 1. List all customers who live in Texas (use JOINs)
select customer.customer_id, address.district
from customer
join address on customer.address_id = address.address_id 
where district = 'Texas'
-- There are 5 customers who live in Texas.

-- 2. Get all payments above $6.99 with the Customer's Full Name
select count(*)
from payment
where amount > 6.99
-- There are 1,406 payments above $6.99.

-- 3. Show all customers names who have made payments over $175 (Use Subqueries)
select *
from (
select concat(customer.first_name, ' ', customer.last_name) as "full_name", sum(amount)
from payment 
join customer on customer.customer_id = payment.customer_id 
group by customer.customer_id 
) as "match name to total amount"
where sum > 175
-- Here are the customers who have paid over $175:
--Clara Shaw	189.60
--Karl Seal	208.58
--Marion Snyder	194.61
--Tommy Collazo	183.63
--Rhonda Kennedy	191.62
--Eleanor Hunt	211.55

-- 4. List all customers that live in Nepal (use the city table)
select concat(customer.first_name, ' ', customer.last_name) as "full_name", country.country
from customer
join address on customer.address_id = address.address_id 
join city on address.city_id = city.city_id 
join country on city.country_id = country.country_id 
where country = 'Nepal'
-- There is only one customer in Nepal: Kevin Schuler

-- 5. Which staff member had the most transactions?
select concat(staff.first_name, ' ', staff.last_name) as "staff", payment.staff_id, count(payment.staff_id)
from payment
join staff on payment.staff_id = staff.staff_id 
group by staff.first_name, staff.last_name, payment.staff_id 
order by count 
desc 
-- Jon Stephens had more transactions with 7,304 transactions verses Mike Hillyer's 7,292.

-- 6. How many movies of each rating are there?
select rating, count(rating)
from film
group by rating
order by rating
-- There are 178 rated G, 194 rated PG, 223 rated PG-13, 195 rated R, and 210 rated NC-17

-- 7. Show all customers who have made a single payment above $6.99 (Use Subquereies)
select *
from (
select concat(customer.first_name, ' ', customer.last_name) as "name", count(payment.customer_id), payment.amount 
from payment
join customer on customer.customer_id = payment.customer_id 
where payment.amount > 6.99
group by customer.first_name, customer.last_name, payment.amount
) as "above 6.99"
where count = 1
-- Obviously this would be too long to list here, but the code works!

-- 8. How many free rentals did our stores give away?
select count(*)
from payment
where amount = 0
-- There were 24 free rentals.