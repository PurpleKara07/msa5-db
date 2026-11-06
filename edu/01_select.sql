-- select절
SELECT 
	 	 emp_id
	  , `name`	-- 백틱(``)으로 감싸면 컬럼으로 인식
	  , gender
  FROM       
       employees;
       
-- Asterrisk(*)
SELECT 
	 	 *       
  FROM   	 
       employees;

-- where절
SELECT 
       *
  FROM     
       employees
 WHERE      
       emp_id = 10009; 
       
SELECT 
       *
  FROM     
       employees
 WHERE      
       `name` = "박보람";        
       
SELECT       
       *
  FROM employees
 WHERE 
       birth >= "2000-01-01"; 
       
SELECT 
       *
  FROM employees
 WHERE 
       fire_at IS NULL;        
       
SELECT 
       *
  FROM employees
 WHERE 
       fire_at IS NOT NULL;               

       
-- 1990년생인 사원을 조회
SELECT 
       *
  FROM employees
 WHERE 
       birth >= '1990-01-01 00:00:00'
   AND birth <= '1990-12-31 23:59:59';   

SELECT 
       *
  FROM employees
 WHERE 
       `name` = '박보람'
    OR `name` = '정유리';   
    

SELECT 
       *
  FROM employees
 WHERE 
       `name` IN ('박보람', '정유리');
       
    
-- 1990년생이거나 이름이 정유리인 사원으로 조회    
SELECT 
       *
  FROM employees
 WHERE 
   (
	    birth >= '1990-01-01 00:00:00'
   AND birth <= '1990-12-31 23:59:59'
	) 
   OR `name` = '정유리';   
     
-- BETWEEN   
SELECT
       *
  FROM employees
 WHERE 
 birth BETWEEN '1990-01-01'
           AND '1990-12-31';		     		  

-- 사번 10001, 10005, 10006
SELECT 
       *
  FROM employees
 WHERE 
       emp_id IN (10001, 10005, 10006);         

-- like절
-- % : 글자수와 상관없이 조회
-- 이름이 '우'로 끝나는 사원 조회
SELECT 
       *
  FROM employees
 WHERE 
--        `name` LIKE '%우'; 		         
--        `name` LIKE '우%'; 		         
       `name` LIKE '%우%'; 		         
       
-- _ : 언더바의 개수만큼 글자수 조회 
-- 이름이 가운데가 '우'로 사원 조회
SELECT 
       *
  FROM employees
 WHERE 
       `name` LIKE '_우%'; 		         
       
-- SELECT 
--        *
--   FROM employees
--  WHERE 
--  MATCH (`name`) AGAINST ('우 ' IN NATURAL LANGUAGE MODE);  		                
 

--  ALTER TABLE employees
--  ADD FULLTEXT INDEX fi_employees_name (`name`);
 
 
 -- ORDER BY절: default는 ASC(오름차순)
 SELECT 
        *
   FROM employees
  ORDER by    
        `name`, birth; 
 
 -- LIMIT 절, OFFSET 절  
 SELECT 
        *
   FROM employees
  LIMIT 5 OFFSET 5;	-- 6부터 5개

 SELECT 
        *
   FROM employees
  LIMIT 10, 5;			-- 11부터 5개
  
-- 집계함수
-- SUM() / MAX() / MAX() / MIN() / AVG() / COUNT()
SELECT 
       emp_id
     , SUM(salary) sum_sal
  FROM salaries
 WHERE 
       end_at IS null 
 GROUP BY 
       emp_id;  


SELECT        
       MAX(salary) max_sal
  FROM salaries
 WHERE 
       end_at IS NULL; 


SELECT        
       MIN(salary) min_sal
  FROM salaries
 WHERE 
       end_at IS NULL;        
       

SELECT        
       AVG(salary) avg_sal
  FROM salaries
 WHERE 
       end_at IS NULL;               
       
SELECT 
       COUNT(*)  cnt
  FROM  	           
       employees 
 WHERE 
       fire_at IS NULL;       


SELECT 
       DISTINCT `name`
  FROM employees
 ORDER BY 
       `name`;       

-- GROUP BY, HAVING 절
SELECT 
	 	 dept_code
	  , COUNT(dept_emp_id) cnt_emps
  FROM 
       department_emps	 	
 WHERE end_at IS NULL        
 GROUP by     
 	    dept_code;
 	    
-- 사원직급별 사원수가 10000명이상인 직급을 조회해 주세요 	    
SELECT 
       title_code          AS title_code
     , COUNT(title_emp_id) AS cnt 
  FROM title_emps
 WHERE end_at IS NULL  
 GROUP BY 
       title_code
HAVING cnt >= 10000;

 
















        
      


		 
		 
		      