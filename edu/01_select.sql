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

       

       

		 
		 
		      