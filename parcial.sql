-- 1. CREATE A TABLESPACE MID_TERM WITH ONE DATAFILE OF 50Mb (For the datafile don't put the path, just the name of the datafile)
CREATE TABLESPACE  MID_TERM 
DATAFILE 'MID_TERM.dbf' SIZE 50M;

--2. CREATE AN USER WITH 20Mb ASSIGNED TO THE TABLESPACE MID_TERM
CREATE USER user1
IDENTIFIED BY "123456"
DEFAULT TABLESPACE MID_TERM
QUOTA 20M ON table1;


--3. GIVE THE DBA ROLE TO THE USER, ALSO SHOULD BE ABLE TO LOG IN.

--4. CREATE TWO SEQUENCES:
	--5.1 COMUNAS_SEQ SHOULD START IN 50 WITH INCREMENTS OF 3
	--5.2 COLEGIOS_SEQ SHOULD START IN 100 WITH INCREMENTS OF 1