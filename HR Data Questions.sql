-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?

SELECT gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate ISNULL
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT race, COUNT(*) AS count
FROM hr
WHERE termdate ISNULL
GROUP BY race
ORDER BY count(*) DESC;

-- 3. What is the age distribution of employees in the company?

SELECT
	CASE
		WHEN age >= 18 AND age <= 24 THEN '18-24'
		WHEN age >= 25 AND age <= 34 THEN '25-34'
		WHEN age >= 35 AND age <= 44 THEN '35-44'
		WHEN age >= 45 AND age <= 54 THEN '45-54'
		WHEN age >= 55 AND age <= 64 THEN '55-64'
		ELSE '65+'
	END AS age_group,
	COUNT(*) as count
FROM hr
WHERE age>=18 AND termdate ISNULL
GROUP BY age_group
ORDER BY age_group;

SELECT
	CASE
		WHEN age >= 18 AND age <= 24 THEN '18-24'
		WHEN age >= 25 AND age <= 34 THEN '25-34'
		WHEN age >= 35 AND age <= 44 THEN '35-44'
		WHEN age >= 45 AND age <= 54 THEN '45-54'
		WHEN age >= 55 AND age <= 64 THEN '55-64'
		ELSE '65+'
	END AS age_group, gender,
	COUNT(*) as count
FROM hr
WHERE age>=18 AND termdate ISNULL
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?

SELECT location, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate ISNULL
GROUP BY location
ORDER BY location;

-- 5. What is the average length of employment for employees who have been terminated?


-- 6. How does the gender distribution vary across departments and job titles?

SELECT department, gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate ISNULL
GROUP BY department, gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?

SELECT jobtitle, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate ISNULL
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate?

SELECT department,
	total_count,
	terminated_count,
	ROUND(CAST(terminated_count AS decimal)/total_count,2) AS termination_rate
FROM (
	SELECT department,
	COUNT(*) AS total_count,
	SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) AS terminated_count
	FROM hr
	WHERE age >=18
	GROUP BY department
	) AS subquery
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by city and state?

SELECT location_state, COUNT(*) AS count
FROM hr
WHERE age >=18 AND termdate ISNULL
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT
	year,
	hires,
	terminations,
	hires - terminations AS net_change,
	ROUND((CAST(hires AS decimal) - terminations)/hires*100,2) AS net_change_percent
FROM(
	SELECT
	EXTRACT(YEAR FROM hire_date) AS year,
	COUNT(*) AS hires,
	SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) AS terminations
	FROM hr
	WHERE age >=18 AND EXTRACT(YEAR FROM hire_date) < 2024
	GROUP BY year
	)AS subquery
ORDER BY year ASC;

-- 11. What is the tenure distribution for each department?

SELECT department, ROUND(AVG(CAST(DATE_PART('year', age(termdate, hire_date)) AS numeric)),1) AS avg_tenure
FROM hr
WHERE termdate <= CURRENT_DATE AND age >= 18 AND termdate IS NOT NULL
GROUP BY department;

