SELECT * FROM hr;

ALTER TABLE hr
RENAME COLUMN id TO emp_id;

ALTER TABLE hr
ALTER COLUMN emp_id TYPE VARCHAR(20),
ALTER COLUMN emp_id DROP NOT NULL;

SELECT * FROM hr;

UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN to_char(to_date(birthdate, '%m/%d/%Y'), 'YYYY-MM-DD')
	WHEN birthdate LIKE '%-%' THEN to_char(to_date(birthdate, '%m-%d-%Y'), 'YYYY-MM-DD')
END;

SELECT birthdate FROM hr;

ALTER TABLE hr
ALTER COLUMN birthdate TYPE DATE USING birthdate::DATE;

UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN to_char(to_date(hire_date, '%m/%d/%Y'), 'YYYY-MM-DD')
	WHEN hire_date LIKE '%-%' THEN to_char(to_date(hire_date, '%m-%d-%Y'), 'YYYY-MM-DD')
END;

ALTER TABLE hr
ALTER COLUMN hire_date TYPE DATE USING hire_date::DATE;

UPDATE hr
SET termdate = date(termdate)
WHERE termdate IS NOT NULL AND termdate !='';

SELECT termdate FROM hr;

ALTER TABLE hr
ALTER COLUMN termdate TYPE DATE USING termdate::DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = DATE_PART('year', AGE(birthdate));

SELECT age FROM hr;

SELECT
	min(age) AS youngest,
	max(age) AS oldest
	FROM hr;
	
SELECT count(*) FROM hr WHERE age<18;

SELECT * FROM hr WHERE age<18;

DELETE FROM hr
WHERE age < 18;

SELECT * FROM hr;