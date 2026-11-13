CREATE DATABASE test;
USE test;

-- -------------------------------
-- 개념적 설계
-- 테이블과 필요한 속성이 무엇?
-- -------------------------------

-- 유저 테이블
-- pk, 이메일, PW, 이름,  생년월일, 전화번호 , 성별, 주소, 프로필  
-- 가입일, 탈퇴일, 작성일, 수정일, 삭제일
CREATE TABLE users(
	  	id					BIGINT			PRIMARY KEY		AUTO_INCREMENT 
 	,	email 			VARCHAR(100)	NOT NULL
	,  `password`		VARCHAR(255) 	NOT NULL		  				 
 	,	user_name 		VARCHAR(30)  	NOT NULL
 	, 	birth				DATE				NOT NULL 
 	, 	phone 			CHAR(13)			NOT NULL 		COMMENT '\'010-0000-1111\', 하이픈 포함 13자리'  	 	
 	, 	gender			CHAR(1) 			NOT NULL 		COMMENT '\'M\', \'F\''
	,  addr_number		CHAR(5)  	
	, 	addr1				VARCHAR(50)
	,  addr2				VARCHAR(50)
 	,  `profile`		VARCHAR(100) 
 	, 	hired_at			DATE 				NOT NULL	DEFAULT (CURRENT_DATE())  		
 	, 	withdrawn_at 	DATE 				DEFAULT NULL 	
 	,	created_at		DATETIME  		NOT NULL	DEFAULT CURRENT_TIMESTAMP()  		
 	,	updated_at		DATETIME  		NOT NULL	DEFAULT CURRENT_TIMESTAMP()  		
 	,	deleted_at		DATETIME  		DEFAULT NULL 	
 	, 	CONSTRAINT uk_users_email UNIQUE(email)
);

-- 게시글 테이블
-- pk, 제목, 본문, 이미지,작성자, 게시글 삭제일,  작성일, 수정일, 삭제일
-- 댓글, 대댓슬, 좋아요, 공유, 북마크  다른 테이블로  
CREATE TABLE posts(
		id					BIGINT 			PRIMARY KEY		AUTO_INCREMENT 
	,	user_id	 		BIGINT			NOT NULL
	, 	title				VARCHAR(100)	NOT NULL	
	,	content			VARCHAR(500) 
	, 	image				VARCHAR(100)	NOT NULL	
	,	deactived_at	DATE 				DEFAULT NULL 		
 	,	created_at		DATETIME  		NOT NULL	DEFAULT CURRENT_TIMESTAMP()  		
 	,	updated_at		DATETIME  		NOT NULL	DEFAULT CURRENT_TIMESTAMP()  		
 	,	deleted_at		DATETIME  		DEFAULT NULL 		 	
);

-- -------------------------------------
-- 테이블 수정
-- -------------------------------------
-- posts 테이블에 fk추가
ALTER TABLE posts
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY(user_id) REFERENCES users(id);

-- 제약조건 제거
ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id;
 
-- 인덱스  제거 
ALTER TABLE posts
DROP INDEX fk_posts_user_id; 

-- 컬럼 추가
ALTER TABLE users
ADD COLUMN birth_month CHAR(2) NOT NULL  COMMENT '\'MM\' 양식';

ALTER TABLE users
ADD COLUMN birth_month CHAR(2) NOT NULL  COMMENT '\'MM\' 양식'
DEFAULT (LPAD(MONTH(users.birth),2,'0')) AFTER birth;


ALTER TABLE users
MODIFY COLUMN birth_month CHAR(2) COMMENT '\'MM\' 양식';

-- 컬럼 삭제
ALTER TABLE users
DROP COLUMN birth_month;

-- -----------------------------
-- Auto_Increment 변경
-- -----------------------------
ALTER TABLE users AUTO_INCREMENT = 1;

-- -----------------------------
-- Truncate문 : 테이블에 모든 데이타를 깨끗하게 제거
-- -----------------------------
TRUNCATE TABLE users;

-- -----------------------------
-- 테이블 삭제
-- -----------------------------
DROP TABLE posts, users;







