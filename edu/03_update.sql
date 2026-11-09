-- UPDATE문
-- 100006 사원의 이름을 변경
UPDATE 
       employees
   SET 
	    `name` = '미어캣'
	  , gender = 'F'  
 WHERE 
       emp_id = 100006;

-- 100006 사원의 이름을 마이콜 
-- 생일 '2020-01-01' 변경
UPDATE 
       employees
   SET 
	    `name` = '마이콜'
	  , birth  = '2020-01-01'  
 WHERE 
       emp_id = 100006;


       