-- -----------------------------------
-- SubQuery
-- -----------------------------------
-- Where절
-- 단일행 서브쿼리
-- D001 부서장의 사번과 이름을 출력
-- 서브 쿼리가 단일행 비교 연산자와 함께 상용할때는
-- 반드시 결과가 1건
-- EXPLAIN 
	SELECT 
	       emp.emp_id 
	     , emp.`name`  
	  FROM 
	       employees emp     
	 WHERE 
	       emp.emp_id = (SELECT 
									    depm.emp_id
								  FROM 		        
								       department_managers depm
								 WHERE 
								       dept_code = 'D001'
									AND end_at IS NULL
								); 	       
								
-- 다중행 서브쿼리(IN, ALL, ANY, SOME, EXISTS)								
-- 현재 부서장인 사원의 사번과 이름을 출력
	SELECT 
	       emp.emp_id 
	     , emp.`name`  
	  FROM 
	       employees emp     								
	 WHERE 
       	 emp.emp_id IN (SELECT 
								        depm.emp_id
								   FROM 
									     department_managers depm
								  WHERE        
								        depm.end_at IS NULL
								);  

-- 다중열 서브쿼리       
-- 현재 'D002' 부서장이 해당 부서에 소속된 날짜를 출력
	SELECT 
	       depe.emp_id
	     , depe.dept_code  
	     , depe.start_at
	  FROM department_emps depe
	 WHERE 
	      (depe.emp_id, depe.dept_code) IN (SELECT 
														        depm.emp_id
															   , depm.dept_code	    
														   FROM 
														        department_managers depm
 														  WHERE 
														        depm.dept_code = 'D002'
															 AND depm.end_at IS NULL
														); 	       


-- 연관 서브쿼리
-- 서브쿼리내에서 메인쿼리의 컬럼이 사용된 서브 쿼리
-- 부서장직을 지냈던 경력이 있는 사원의 정보를 출력
	SELECT 
	       emp.*
	  FROM 		 
	       employees emp
	 WHERE 
	       emp.emp_id IN (SELECT   
	                             depm.emp_id   
									FROM 
									     department_managers depm
								  WHERE 
								        depm.emp_id = emp.emp_id
							    ); 		  
	
-- -----------------------------------
-- Select절
-- -----------------------------------
-- 사원별 역대 전체 급여 평균
	SELECT 
	       emp.emp_id
	     , (SELECT 
		            AVG(sal.salary) 
	          FROM 
	               salaries sal 
	         WHERE 
				      sal.emp_id = emp.emp_id      
		  	  ) avg_sal 
	  FROM 
	        employees emp;
	
-- -----------------------------------
-- From절
-- -----------------------------------          
	SELECT 
	       tmp.*
	  FROM 
	  		 (SELECT 
	  		          emp.emp_id
	  		        , emp.`name`  
			    FROM  employees emp
			   WHERE  fire_at IS NOT NULL  
			  ) tmp;  
			  
-- -----------------------------------
-- Insert
-- -----------------------------------			  
		INSERT INTO 
				employees(					
				 	emp_id
				 , `name`
				 , birth
				 , gender
				 , hire_at
				)
		 		VALUES(
					(SELECT 
					        MAX(emp.emp_id) +1
					   FROM 
						     employees emp
					)		       
				 , '둘리'
				 , '1980-01-01'
				 , 'M'
				 , NOW()
				); 
		 
-- -----------------------------------
-- Update
-- -----------------------------------
-- 퇴사한 사원의 퇴사일로 직급 테이블의 직급 종료일 갱신			 		 
		UPDATE title_emps
		   SET title_emps.end_at = (SELECT 
		                                   emp.fire_at
											   FROM 	
											        employees emp
											  WHERE 
											        emp.emp_id = 100009     
											)
		 WHERE 
		       title_emps.emp_id = 100009
		   AND title_emps.end_at IS NULL;    
			
			 