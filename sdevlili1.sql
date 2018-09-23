
SHOW PARAMETER AUDIT_TRAIL;

DROP TABLESPACE secure_user INCLUDING CONTENTS;

DROP AUDIT POLICY VER_EMP;

DROP TABLESPACE secure_data INCLUDING CONTENTS;

DROP ROLE GENERIC;

DROP PROFILE security567 CASCADE;

DROP USER ANONYMOUS1;
DROP USER ANONYMOUS2;
DROP USER ANONYMOUS3;
DROP USER ANONYMOUS4;


/*LETS BEGIN*/

CREATE TABLESPACE secure_user DATAFILE SIZE 50M AUTOEXTEND ON MAXSIZE 250M;

CREATE TABLESPACE secure_data DATAFILE SIZE 50M AUTOEXTEND ON MAXSIZE 250M;

CREATE PROFILE security567
LIMIT FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LIFE_TIME 60
PASSWORD_REUSE_TIME 90
PASSWORD_REUSE_MAX 5
PASSWORD_LOCK_TIME 1/24
PASSWORD_GRACE_TIME 10
PASSWORD_VERIFY_FUNCTION ora12c_verify_function;


CREATE TABLE BIDRATES2017 (
    BIDRATE INT,
    LastName varchar(255),
    FirstName varchar(255)
    )
     TABLESPACE secure_data;  
                  
CREATE TABLE BIDRATES2018 (
    BIDRATE INT,
    LastName varchar(255),
    FirstName varchar(255)
    )
     TABLESPACE secure_data;  
                 

CREATE TABLE PROPOSALS2017 (
    PROPOSALS INT,
    LastName varchar(255),
    FirstName varchar(255)
    )
     TABLESPACE secure_data;  
     
  
CREATE TABLE PROPOSALS2018 (
    PROPOSALS INT,
    LastName varchar(255),
    FirstName varchar(255)
    )
     TABLESPACE secure_data;     
     
INSERT INTO BIDRATES2017 VALUES(50,'JUNE','MILES');
INSERT INTO BIDRATES2017 VALUES(60,'VO','MILIHN');
INSERT INTO BIDRATES2017 VALUES(55,'BONT','SUSAN');
INSERT INTO BIDRATES2017 VALUES(75,'CYPRESS','HANNAH');

INSERT INTO BIDRATES2018 VALUES(41,'lEWIS','STEVE');
INSERT INTO BIDRATES2018 VALUES(87,'CARROL','HARRY');
INSERT INTO BIDRATES2018 VALUES(42,'LAND','ALICE');
INSERT INTO BIDRATES2018 VALUES(54,'HAYING','HOLLY');

INSERT INTO PROPOSALS2017 VALUES(2,'CARROL','EMILY');
INSERT INTO PROPOSALS2017 VALUES(1,'SVILARIK','VUK');
INSERT INTO PROPOSALS2017 VALUES(2,'SOTO','LILI');
INSERT INTO PROPOSALS2017 VALUES(1,'WASHINGTON','MARIE');

INSERT INTO PROPOSALS2017 VALUES(1,'SANTOS','VALERIE');
INSERT INTO PROPOSALS2017 VALUES(1,'MURIEL','ZAIDA');
INSERT INTO PROPOSALS2017 VALUES(2,'SILVESTER','AUGUST');
INSERT INTO PROPOSALS2017 VALUES(1,'CRUZ','MARIA');


CREATE ROLE GENERIC;
GRANT CREATE SESSION TO GENERIC;
GRANT READ, UPDATE, INSERT, DELETE ON BIDRATES2017 TO GENERIC;
GRANT READ, UPDATE, INSERT, DELETE ON BIDRATES2018 TO GENERIC;
GRANT READ, UPDATE, INSERT, DELETE ON PROPOSALS2017 TO GENERIC;
GRANT READ, UPDATE, INSERT, DELETE ON PROPOSALS2018 TO GENERIC;

CREATE USER ANONYMOUS1
IDENTIFIED BY DAILY100
DEFAULT TABLESPACE secure_user
PROFILE security567
PASSWORD EXPIRE;
GRANT GENERIC TO ANONYMOUS1;


CREATE USER ANONYMOUS2
IDENTIFIED BY DAily200#
DEFAULT TABLESPACE secure_user
PROFILE security567
PASSWORD EXPIRE;
GRANT GENERIC TO ANONYMOUS2;


CREATE USER ANONYMOUS3
IDENTIFIED BY DAILY300
DEFAULT TABLESPACE secure_user
PROFILE security567
PASSWORD EXPIRE;
GRANT GENERIC TO ANONYMOUS3;

CREATE USER ANONYMOUS4
IDENTIFIED BY DAILY400
DEFAULT TABLESPACE secure_user
PROFILE security567
PASSWORD EXPIRE;
GRANT GENERIC TO ANONYMOUS4;


CREATE AUDIT POLICY VER_EMP
  ACTIONS DELETE on BIDRATES2017,
          INSERT on BIDRATES2017,
          UPDATE on BIDRATES2017,
          READ on BIDRATES2017,
          
          DELETE on BIDRATES2018,
          INSERT on BIDRATES2018,
          UPDATE on BIDRATES2018,
          READ on BIDRATES2018,
          
          DELETE on PROPOSALS2017,
          INSERT on PROPOSALS2017,
          UPDATE on PROPOSALS2017,
          READ on PROPOSALS2017,
          
          DELETE on PROPOSALS2018,
          INSERT on PROPOSALS2018,
          UPDATE on PROPOSALS2018,
          READ on PROPOSALS2018;
          
SELECT audit_option, AUDIT_OPTION_TYPE, OBJECT_SCHEMA, OBJECT_NAME
FROM  AUDIT_UNIFIED_POLICIES
WHERE POLICY_NAME = 'VER_EMP';

CONNECT ANONYMOUS2;

