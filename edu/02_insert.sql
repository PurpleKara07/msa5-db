-- INSERT문
-- DML 신규데이터 저장
-- INSERT INTO 테이블명[(컬럼1, 컬럼2)]
-- VALUES(값1, 값2 ...dbsample);
INSERT INTO employees 
	(
		`name`
	, 	birth
	, 	gender
	, 	hire_at
	)
VALUES 
	(
	  '김성현'
	, '2000-01-01'
	, 'M'
	, NOW()
	);

-- 복수의 레코드를 삽입하는 경우	
INSERT INTO employees ( `name`, 	birth, 	gender, 	hire_at)
VALUES ('김성현', '2000-01-01', 'M', NOW())
	,	 ('홍길동', '1700-01-01', 'M', NOW())
	, 	 ('갑돌이', '1900-01-01', 'M', NOW());

START TRANSACTION;

-- SELECT INSERT	
INSERT INTO title_emps(
	  	  emp_id
		, title_code
		, start_at
		, end_at
		, created_at
		, updated_at	
		, deleted_at
)
SELECT 
		  emp_id
		, 'T001'
		, NOW()
		, NULL 
		, NOW() 
		, NOW() 
		, NULL 
  FROM employees
 WHERE  	
       emp_id > 100000;
	

COMMIT;
ROLLBACK;    		