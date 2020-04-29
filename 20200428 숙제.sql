//8
SELECT *
FROM countries;

SELECT *
FROM employees;

SELECT cid, cnm, pid, day, cnt
FROM customer NATURAL JOIN cycle
WHERE region_name = Europe;

//8
SELECT regions.region_id, regions.region_name, countries.country_name
FROM countries JOIN regions ON (countries.region_id = regions.region_id)
AND regions.region_name = 'Europe';

//9
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city
FROM regions JOIN countries ON(regions.region_id = countries.region_id)
             JOIN locations ON(countries.country_id = locations.country_id)
AND regions.region_name = 'Europe';

//10
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city, departments.department_name
FROM regions JOIN countries ON(regions.region_id = countries.region_id)
             JOIN locations ON(countries.country_id = locations.country_id)
             JOIN departments ON(locations.location_id = departments.location_id)
AND regions.region_name = 'Europe';


//11 
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city, departments.department_name, 
employees.first_name || employees.last_name
FROM regions JOIN countries ON(regions.region_id = countries.region_id)
             JOIN locations ON(countries.country_id = locations.country_id)
             JOIN departments ON(locations.location_id = departments.location_id)
             JOIN employees ON(departments.department_id = employees.department_id)
AND regions.region_name = 'Europe';

//12 





//13 
SELECT e.manager_id mgr_id, m.first_name || m.last_name mgr_name, 
       e.employee_id, e.first_name || e.last_name, 
       e.job_id, jobs.job_title
FROM employees.e, jobs, employees m
WHERE e.job_id = jobs.job_id
  AND e.manager_id = m.employee_id
  AND e.manager_id = 100;

