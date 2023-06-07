// 1. Вывести список сотрудников, получающих заработную плату большую чем у непосредственного руководителя

SELECT *
FROM EMPLOYEE AS employees, EMPLOYEE AS chieves
WHERE chieves.ID = employees.CHIEF_ID AND employees.SALARY > chieves.SALARY

// 2. Вывести список сотрудников, получающих максимальную заработную плату в своем отделе

SELECT *
FROM EMPLOYEE AS employees
WHERE employees.SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE AS max WHERE max.DEPARTMENT_ID = employees.DEPARTMENT_ID)

// 3. Вывести список ID отделов, количество сотрудников в которых не превышает 3 человек 

SELECT DEPARTMENT_ID 
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) <= 3;

// 4. Вывести список сотрудников, не имеющих назначенного руководителя, работающего в том-же отделе

SELECT * 
FROM EMPLOYEE AS employees
LEFT JOIN EMPLOYEE AS chieves ON (employees.CHIEF_ID = chieves.ID AND employees.DEPARTMENT_ID = chieves.DEPARTMENT_ID)
WHERE chieves.ID IS NULL;

// 5. Найти список ID отделов с максимальной суммарной зарплатой сотрудников

WITH department_salary AS 
	(SELECT DEPARTMENT_ID, SUM(SALARY) AS salary
	FROM EMPLOYEE
	GROUP BY DEPARTMENT_ID)
SELECT DEPARTMENT_ID
FROM department_salary
WHERE department_salary.SALARY = (SELECT MAX(SALARY) FROM departmnet_salary);
