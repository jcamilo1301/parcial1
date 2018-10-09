-- 1. CREATE A TABLESPACE MID_TERM WITH ONE DATAFILE OF 50Mb (For the datafile don't put the path, just the name of the datafile)
CREATE TABLESPACE  MID_TERM 
DATAFILE 'MID_TERM.dbf' SIZE 50M;

--2. CREATE AN USER WITH 20Mb ASSIGNED TO THE TABLESPACE MID_TERM
CREATE USER user1
IDENTIFIED BY "123456"
DEFAULT TABLESPACE MID_TERM
QUOTA 20M ON MID_TERM;


--3. GIVE THE DBA ROLE TO THE USER, ALSO SHOULD BE ABLE TO LOG IN.
GRANT DBA TO user1;
GRANT CONNECT TO user1;

--4. CREATE TWO SEQUENCES:
	--5.1 COMUNAS_SEQ SHOULD START IN 50 WITH INCREMENTS OF 3
	--5.2 COLEGIOS_SEQ SHOULD START IN 100 WITH INCREMENTS OF 1
    
    --1
    CREATE SEQUENCE secuencia1
    START WITH 50
    INCREMENT BY 3  NOCYCLE;
        --2
    CREATE SEQUENCE secuencia2
    START WITH 100
    INCREMENT BY 1  NOCYCLE;
    
    --AUMENTAR VALOR DE LA SECUNCIA
SELECT secuencia1.NEXTVAL FROM DUAL;
SELECT secuencia2.NEXTVAL FROM DUAL;

--VALOR ACTUAL DE LA SECUENCIA
SELECT secuencia2.CURRVAL FROM DUAL;
SELECT secuencia1.CURRVAL FROM DUAL;

--5. CREATE THE NEXT TABLES:

CREATE TABLE COMUNAS (
	ID INTEGER PRIMARY KEY,
	NOMBRE VARCHAR2(255)
);

INSERT INTO COMUNAS VALUES (1,	'POPULAR');
INSERT INTO COMUNAS VALUES (10,	'LA CANDELARIA');
INSERT INTO COMUNAS VALUES (11,	'LAURELES ESTADIO');
INSERT INTO COMUNAS VALUES (12,	'LA AMERICA');
INSERT INTO COMUNAS VALUES (13,	'SAN JAVIER');
INSERT INTO COMUNAS VALUES (14,	'POBLADO');
INSERT INTO COMUNAS VALUES (15,	'GUAYABAL');
INSERT INTO COMUNAS VALUES (16,	'BEL�N');
INSERT INTO COMUNAS VALUES (2,	'SANTA CRUZ');
INSERT INTO COMUNAS VALUES (3,	'MANRIQUE');
INSERT INTO COMUNAS VALUES (4,	'ARANJUEZ');
INSERT INTO COMUNAS VALUES (5,	'CASTILLA');
INSERT INTO COMUNAS VALUES (50,	'PALMITAS');
INSERT INTO COMUNAS VALUES (6,	'DOCE DE OCTUBRE');
INSERT INTO COMUNAS VALUES (60,	'SAN CRISTOBAL');
INSERT INTO COMUNAS VALUES (7,	'ROBLEDO');
INSERT INTO COMUNAS VALUES (70,	'ALTAVISTA');
INSERT INTO COMUNAS VALUES (8,	'VILLA HERMOSA');
INSERT INTO COMUNAS VALUES (80,	'SAN ANTONIO DE PRADO');
INSERT INTO COMUNAS VALUES (9,	'BUENOS AIRES');
INSERT INTO COMUNAS VALUES (90,	'SANTA ELENA');
    
    
   -- FOR THE NEXT TABLE YOU SHOULD: 	

--* ADD THE PRIMARY KEY "ID" COLUMN TO THE COLEGIOS TABLE, ALSO ADD THE FOREIGN KEY WITH COMUNAS TABLE. THE NAME OF THE FOREIGN KEY SHOULD BE "COMUNA_FK"

create table colegios (
    id int primary key,
	consecutivo_dane VARCHAR2(255),
	nombre_sede VARCHAR2(255),
	tipo_sede VARCHAR2(255),
	comuna_id INTEGER,
	prestacion_servicio VARCHAR2(255),
	zona VARCHAR2(255),
	barrio VARCHAR2(255),
	sector VARCHAR2(255),
	direccion_sede VARCHAR2(255),
	telefono_sede VARCHAR2(255),
	rector VARCHAR2(255),
	contador_prejardin_jardin INTEGER,
	contador_transicion INTEGER,
	contador_primaria INTEGER,
	contador_secundaria INTEGER,
	contador_media INTEGER,
	contador_adultos INTEGER,
	jornada_completa VARCHAR(8),
	jornada_manana VARCHAR(8),
	jornada_tarde VARCHAR(8),
	jornada_nocturna VARCHAR(8),
	jornada_fin_de_semana VARCHAR(8),
	jornada_unica VARCHAR(8),
	clasificacion_icfes VARCHAR(8),
    CONSTRAINT COMUNA_FK
    FOREIGN KEY (comuna_id)
    REFERENCES COMUNAS (id)
);

--7. Queries (DO NOT CHANGE THE NAME OF THE COLUMNS):

--7.1: Traiga el nombre del barrio y el n�mero de colegios ubicados en cada barrio de aquellas instituciones ubicadas en la comuna 
--de buenos aires ordenado por el n�mero de colegios de mayor a menor.
--	 Columnas: barrio, numero_colegios
select col.barrio, count(*) as numero_colegios from colegios col
inner join comunas com on col.comuna_id= com.id
where com.nombre ='BUENOS AIRES'
group by col.barrio
;


--7.2: Traiga los registros junto con el nombre de su comuna, para cada registro deber� calcularse el total de los estudiantes seg�n los contadores. Tambi�n deber� traer el total de estudiantes agrupados por comuna.
--	 Columnas: ID, NOMBRE_SEDE, COMUNA_ID, NOMBRE_COMUNA, TOTAL_GENERAL, TOTAL_POR COMUNA

select col.ID, col.nombre_sede, col.comuna_id, com.nombre as NOMBRE_COMUNA, 
col.contador_prejardin_jardin + col.contador_transicion + col.contador_primaria + col.contador_secundaria + col.contador_media +
col.contador_adultos as TOTAL_GENERAL,
sum(col.contador_prejardin_jardin + col.contador_transicion + col.contador_primaria + col.contador_secundaria + col.contador_media +
col.contador_adultos) OVER (PARTITION BY com.nombre) as "TOTAL_POR COMUNA"
from comunas com
inner join colegios col on com.id = col.comuna_id
;



--7.3: Traiga los colegios que dicten clases a estudiantes de prejardin-jardin y que en la prestaci�n de su servicio sean no oficiales para las comunas ARANJUEZ, CASTILLA y DOCE DE OCTUBRE. Deber� incluir el contador de estudiantes de secundaria y deber� calcular el promedio de estudiantes de secundaria agrupados por comuna redondeado a 2 decimales.
--	 Columnas: ID, NOMBRE_SEDE, COMUNA_ID, NOMBRE_COMUNA, CONTADOR_SECUNDARIA, PROMEDIO_SECUNDARIA_COMUNA

--7.4 Traiga el nombre de los rectores y el n�mero de colegios encargados para cada rector de aquellos rectores que est�n encargados de m�s de 2 colegios. 
--	Los registros deber�n estar ordenados alfab�ticamente
--	Nota: NO se deber�n incluir aquellos registros que tengan un correo electr�nico registrado y tampoco aquellos que registran como nombre "s/d"
--	Columnas: rector, numero_colegios

--7.5 Muestre el nombre del colegio, el barrio, la direcci�n de aquellos colegios que est�n ubicados en la zona rural y tengan alg�n tipo de clasificaci�n en el ICFES. Adem�s deber� traer aquellos colegios que ense�an a m�s de 200 estudiantes adultos
--	Columnas: barrio, numero_colegios

