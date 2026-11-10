-- 1. 직급테이블의 모든 정보를 조회해주세요.
	SELECT 
	       *
	  FROM     
	       titles;	       

-- 2. 현재 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요.
   SELECT 
	       sal.emp_id
	  FROM 
	       salaries sal
	 WHERE 
	       sal.salary <= 60000000     
	   AND sal.end_at IS NULL;     

-- 3. 현재 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요.
	SELECT 
	       sal.emp_id
	  FROM 
	       salaries sal
	 WHERE 
	       sal.salary
  BETWEEN 60000000 AND 70000000 
	 	AND sal.end_at IS NULL;     	 

-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
	SELECT 
	       emp.*	
	  FROM employees emp
	 WHERE 
	       emp.emp_id IN('10001', '10005');      

-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
	SELECT 
	       title.title_code
	     , title.title
	  FROM     
          titles title
    WHERE title.title LIKE '%사%';  
	     
-- 6. 사원(퇴사자 포함) 이름 오름차순으로 정렬해서 조회해 주세요.
	SELECT 
	       emp.*
	  FROM 
	       employees emp    
	  ORDER BY emp.`name` ASC;      

-- 7. 사원별(퇴사자 포함) 전체 급여의 평균을 조회해 주세요.
	 SELECT 
	        sal.emp_id AS emp_id
	      , AVG(sal.salary) AS avg_salary  
	  	FROM salaries sal
	  GROUP BY 	
           emp_id;
           
-- 8. 사원(퇴사자 포함)별 전체 급여의 평균이 30,000,000 ~ 50,000,000인,
--   사원번호와 평균급여를 조회해 주세요.
	SELECT 
	       T.emp_id 				  AS emp_id 
	     , ROUND(T.avg_salary,0) AS avg_salary	 
	  FROM    
			 (SELECT 
			 		  sal.emp_id 		AS emp_id		  	
			 		, AVG(sal.salary) AS avg_salary 	
			   FROM  
				     salaries sal    
			  GROUP BY      
			        sal.emp_id
			 ) T
	 WHERE 		 
	        T.avg_salary 
  BETWEEN  30000000 AND 50000000;

-- 9. 사원별(재직중) 전체 급여 평균이 70,000,000이상인,
--   사원의 사번, 이름, 성별을 조회해 주세요.
	SELECT 
	       emp.emp_id		  AS emp_id	
	     , emp.`name` 	  AS `name`			
	     , IF(emp.gender = 'M', '남', IF(emp.gender = 'F', '여','기타')) AS gender
	     , ROUND(AVG(sal.salary), 0)  AS avg_salary
	FROM employees emp
	  	JOIN salaries sal     
	   	ON emp.emp_id = sal.emp_id
	WHERE 
	   emp.fire_at IS NULL    
	GROUP by
	   emp.emp_id
		, emp.`name` 				       
	   , emp.gender  	
		HAVING 
	      avg_salary >= 70000000;
	   
-- 10. 현재 직급이 'T005'인,
--   사원(재직중) 의 사원번호와 이름을 조회해 주세요.
	SELECT 
	       emp.emp_id    	AS emp_id
	     , emp.`name` 		AS `name` 
	     , title.title_code AS title_code
   FROM employees  emp
	  JOIN title_emps title		 	
	    ON emp.emp_id = title.emp_id		 	      
	WHERE 
	   title.title_code = 'T005'
	   AND emp.fire_at IS NULL	        
	   AND title.end_at IS NULL 
	GROUP BY 		 
	    emp.emp_id
	    , emp.`name`  
	    , title.title_code;


   
