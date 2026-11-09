-- 내장함수(Function)
-- ----------------------
-- 데이터 타입 변환함수
-- ----------------------
SELECT 
       CAST(1234 AS CHAR(6))
     , CONVERT(1234, CHAR(6)); 
     
SELECT 
       CONVERT(emp_id, CHAR(20))       
  FROM employees
 WHERE emp_id = 100007; 

-- ----------------------
-- 제어 흐름 함수
-- ----------------------
-- if(수식, 참일경우 값, 거짓일경우 값)
SELECT 
        `name`
      , gender
      , IF(gender = 'M', '남자', '여자')  ko_gender
  FROM  employees;

-- IFNULL(수식1, 수식2)
-- 수식1이 NULL이면  수식2 반환, 아니면 수식1을 반환      
SELECT 
       IFNULL(fire_at, '재직중') fire_state
     , fire_at  
  FROM 		  
       employees;
       
-- NULLIF(수식1, 수식2)
-- 수식1과 수식2를 비교해서 같으면 NULL반환 
-- 다르면 수식1을 반환
SELECT 
       NULLIF(gender, 'M')
  FROM 	        
       employees;
       
-- CASE ~WHEN ~ELSE ~END
SELECT 
  CASE gender 
  		 WHEN 'M' THEN '남자'
		 WHEN 'F' THEN '여자' 	 	
		 ELSE '기타'
   END AS ko_gender         
  FROM employees;

-- -----------------------------------------  
-- 문자열 함수              
-- -----------------------------------------
-- 문자열 연결
SELECT 
       CONCAT('안녕',' ','하세요.'); 
SELECT 
       CONCAT(`name`, ' ' , gender)
  FROM 
       employees;       
-- 구분자로 문자열 연결		  
SELECT 
       CONCAT_WS(', ','자바','JS','HTML');  
       
-- 숫자에 자릿수(,) 및 소수점 자리수 표시       
SELECT 
       FORMAT(salary, 0) 
  FROM 
       salaries;     
       
-- 문자열 왼쪽 / 오른쪽 부터 길이만큼 잘라 반환
SELECT 
       LEFT('123456', 2)        
     , RIGHT('123456', 2);               
     
-- 문자열의 좌/우에 문자열 길이만큼채울 문자열 삽입     
SELECT 
        LPAD('123',6,'0') 
	   , RPAD('123',6,'0');   

-- 문자열의 좌/우 공백을 제거
SELECT 
       '     test  '
     , TRIM('     test  ')
     , LTRIM('     test  ')
     , RTRIM('     test  ');
     
SELECT TRIM(BOTH 'a' FROM  'abcdefa');    	-- 앞뒤 
SELECT TRIM(LEADING  'a' FROM  'abcdefa');   -- 왼쪽  	
SELECT TRIM(TRAILING  'a' FROM  'abcdefa');  -- 오른쪽   

-- 문자열을 시작위치에서 길이만큼 잘라서 반환
SELECT SUBSTRING('123456',3,2);
SELECT SUBSTR('123456',3,2);

-- 왼쪽부터 구분자가 n번째 만큼 나오면 그 이후를 버림
SELECT SUBSTRING_INDEX('abc_test_123.txt', '_', 2) AS txt; 
SELECT SUBSTRING_INDEX('abc.test.123.txt', '.', -1) AS txt; 

-- 영어 대/소문자
SELECT 
       UPPER('aaaDADSAaada')
	  , LOWER('aaaDADSAaada');   	     

-- ----------------------------------------------------
-- 수학함수
-- ----------------------------------------------------
SELECT 
        CEIL(3.14)
	  ,  FLOOR(3.14)
	  ,  ROUND(3.14);              
		
SELECT 
        ABS(-1)
	  ,  ABS(1);	   		

-- 소수점을 기준으로 특정 자리수까지 구하고 나머지는 버럼       
SELECT 
        TRUNCATE(1.19, 1);    
 
-- ----------------------------------------------------       
-- 날짜 및 시간함수
-- ----------------------------------------------------
SELECT 
       NOW();     

-- 연월일만 반환(yyyy-mm-dd)		   
SELECT 
       DATE(created_at) 
  FROM 	
       employees;       

-- 날짜의 단위 기간에 따라 더한 날짜 / 시간을 반환
SELECT 
       ADDDATE(NOW(), INTERVAL -1 YEAR)
	  , ADDDATE(NOW(), INTERVAL -1 MONTH)
	  , ADDDATE(NOW(), INTERVAL -1 DAY)
	  , ADDDATE(NOW(), INTERVAL -1 HOUR)
 	  , ADDDATE(NOW(), INTERVAL -1 MINUTE)
  	  , ADDDATE(NOW(), INTERVAL -1 SECOND)
     , ADDDATE(NOW(), INTERVAL -1 MICROSECOND)
     , ADDTIME(NOW(), '01:30:00'); 

       
-- ----------------------------------------------------       
-- 순차 함수
-- ----------------------------------------------------
-- RANK() OVER(ORDER BY 컬럼 ASC/DESC)
-- 순위를 매겨 반환 : 동일한 값이 있는경우 동일한 순위 부여
SELECT 
        emp_id
     ,  salary
     ,  RANK() OVER(ORDER BY salary DESC) `rank`
 FROM  salaries
WHERE  	   
       end_at IS NULL; 
       


SELECT 
        emp_id
     ,  salary
     ,  DENSE_RANK() OVER(ORDER BY salary DESC, emp_id) `rank`
 FROM  salaries
WHERE  	   
       end_at IS NULL;        


-- ROW_NUMBER() OVER(ORDER BY 컬럼 ASC/DESC)
-- 순위를 매겨 반환 : 동일한 값이 있는경우 각행에 고유한 번호  부여
SELECT 
        emp_id
     ,  salary
     ,  ROW_NUMBER() OVER(ORDER BY salary DESC, emp_id) `rank`
 FROM  salaries
WHERE  	   
       end_at IS NULL; 

