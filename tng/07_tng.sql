-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT 
       emp.emp_id
	  , emp.`name`
	  , tit.title_code
  FROM employees emp
  	JOIN title_emps tit
  	  ON emp.emp_id = tit.emp_id 
  	 AND emp.fire_at IS NULL
	 AND tit.end_at IS NULL;

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT 
       emp.emp_id
     , emp.gender
	  , sal.salary 
  FROM employees emp
  	JOIN salaries sal
	  ON emp.emp_id = sal.emp_id      
	 AND emp.fire_at IS NULL
	 AND sal.end_at IS NULL; 

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT 
       emp.`name`
     , sal.salary  
     , sal.end_at
  FROM employees emp
   JOIN salaries sal
	  ON emp.emp_id = sal.emp_id
	 AND emp.emp_id = 10010
  ORDER BY sal.end_at IS NULL, sal.end_at ASC; 	 

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
       emp.emp_id
     , emp.`name`
	  , dept.dept_name  
  FROM employees emp
	 JOIN department_emps depe
	       ON emp.emp_id = depe.emp_id
		  	AND emp.fire_at IS NULL 
		  	AND depe.end_at IS NULL 
	 JOIN departments dept
	       ON depe.dept_code = dept.dept_code;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
   SELECT
			emp.emp_id
			,emp.`name`
			,tmp_sal.salary
		FROM employees emp
			JOIN (
				SELECT
					sal.emp_id
					,sal.salary
				FROM salaries sal
				WHERE
					sal.end_at IS NULL
				ORDER BY sal.salary DESC
				LIMIT 10
			) tmp_sal
				ON emp.emp_id = tmp_sal.emp_id
					AND emp.fire_at IS NULL
		ORDER BY tmp_sal.salary DESC;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.

 	SELECT 
 	       dept.dept_name
 	     , emp.`name`
		  , emp.hire_at	  
 	 FROM employees emp
 	  JOIN department_managers depm
 	    ON emp.emp_id = depm.emp_id
 	   AND emp.fire_at IS NULL
  		AND depm.end_at IS NULL		   
	  JOIN departments dept
	    ON depm.dept_code = dept.dept_code
		AND dept.end_at IS NULL;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
	SELECT 
	       t.emp_id    	  AS emp_id
	     , AVG(sal.salary) AS avg_sal
     FROM salaries sal 
		JOIN (SELECT 
			        tite.emp_id		AS emp_id
			      , tite.title_code AS title_code
					, titl.title  		AS title
			   FROM title_emps tite
		   	JOIN titles titl
			     ON tite.title_code = titl.title_code
				 AND tite.title_code = 'T005'
				 AND tite.end_at IS NULL 
			  ) t 
			ON sal.emp_id = t.emp_id
	  GROUP BY 
	       	t.emp_id
	  ORDER BY 			 
	        emp_id ASC;
			  	   

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
	
	SELECT
			tite.emp_id
			, emp.`name`
			, AVG(sal.salary) avg_sal
		FROM title_emps tite
			JOIN titles tit
				ON tite.title_code = tit.title_code
					AND tit.title = '부장'
					AND tite.end_at IS NULL
			JOIN salaries sal
				ON tite.emp_id = sal.emp_id
			JOIN employees emp
				ON emp.emp_id = tite.emp_id
					AND emp.fire_at IS NULL
		GROUP BY tite.emp_id
		ORDER BY tite.emp_id;	    
		  
-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
		 SELECT 
		        emp.`name`
		      , emp.hire_at
				, emp.emp_id
				, depm.dept_code  
		   FROM employees emp
			 JOIN department_managers depm
			   ON emp.emp_id = depm.emp_id
			  AND emp.fire_at IS NULL;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
		  
		-- SELECT 
-- 		       t2.title_code  	AS title_code
-- 		     , t2.title  			AS title
-- 		     , CEIL(AVG(t1.salary))	AS avg_salary  
-- 		  FROM
-- 		      (SELECT 
-- 		              emp.emp_id  AS emp_id
-- 		            , sal.salary  AS salary
-- 		         FROM employees emp
-- 		          JOIN salaries sal
--                   ON emp.emp_id = sal.emp_id
--                  AND emp.fire_at IS NULL
--                  AND sal.end_at IS NULL 
-- 		      ) t1  
-- 		   LEFT JOIN       
-- 			  (SELECT
-- 			         titm.emp_id     AS emp_id
-- 			       , titm.title_code AS title_code
-- 			       , titl.title  	 AS title
-- 			    FROM title_emps titm
-- 			     JOIN titles titl
-- 				    ON titm.title_code = titl.title_code
-- 					AND titm.end_at IS NULL
-- 				) t2  
-- 			ON t1.emp_id = t2.emp_id
-- 		GROUP by	
-- 		      t2.title_code
-- 		    , t2.title
-- 			HAVING CEIL(AVG(t1.salary)) >= 60000000
-- 		ORDER BY avg_salary DESC;

	SELECT
	       tit.title
	     , CEIL(AVG(sal.salary)) avg_sal  
	  FROM title_emps tite
	   JOIN titles tit
	     ON tite.title_code = tit.title_code
		JOIN salaries sal
		  ON sal.emp_id = tite.emp_id
		 AND sal.end_at IS NULL 
		 AND tite.end_at IS NULL
	  GROUP BY 
	  	     tite.title_code
			, tit.title
		HAVING AVG(sal.salary) >= 60000000			  
	  ORDER BY 	
		     avg_sal DESC;  
		   
-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
		SELECT 
		       titm.title_code	 AS title_code
		     , COUNT(emp.emp_id) AS cnt_emp   
		  FROM employees emp
		   JOIN title_emps titm
		     ON emp.emp_id = titm.emp_id
			 AND emp.gender = 'F'   
			 AND emp.fire_at IS NULL 
			 AND titm.end_at IS NULL 
		  GROUP BY 	 
		  		  titm.title_code
		 ORDER BY titm.title_code;
			
-- ------------------------------
-- 전체 평균 급여보다 높은 급여를 받는 사원의 사번, 이름, 현재급여를 조회
	  SELECT 
	         emp.emp_id
	       , emp.`name`  
	       , sal.salary
	 	 FROM 
	 	       employees emp  
		  JOIN salaries sal 
		    ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS NULL
			AND sal.end_at IS NULL    
		 WHERE  
		      CEIL(sal.salary) >= (SELECT 		        
									      		CEIL(AVG(dumy.salary)) AS avg_sal	
						  		        	 FROM salaries dumy  
						  		        	WHERE dumy.end_at IS NULL  
							     		 )
		ORDER BY 
		      sal.salary;

-- 가장 높은 급여를 받은 이력이있는 사원의 사번과 급여를 조회
		SELECT 
		       sal.emp_id
		     , sal.salary 
		  FROM 
		 		 salaries sal
		 WHERE sal.salary = (SELECT 
								          MAX(dumy.salary) AS MAX_sal  
							        FROM salaries dumy
								  );					 			

		  
        
