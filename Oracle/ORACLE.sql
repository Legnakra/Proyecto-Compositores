CREATE TABLE compositores (
    nombre VARCHAR2 (30),
    fecha_nacimiento DATE,
    fecha_muerte DATE,
    epoca VARCHAR2 (20),
    pais_nacimiento VARCHAR2 (20),
    CONSTRAINT PK_nom PRIMARY KEY (nombre),
    CONSTRAINT CK_fnac CHECK (TO_NUMBER(substr(fecha_nacimiento, -4, 4)) BETWEEN 1500 AND 1900),
    CONSTRAINT CK_epoca CHECK (upper(epoca) IN ('RENACIMIENTO','BARROCO','CLASICISMO','CLÁSICA','ROMANTICISMO', 'MODERNA')),
    CONSTRAINT CK_nac CHECK (pais_nacimiento IS NOT NULL)
);


CREATE TABLE tipo (
    nom_tipo VARCHAR2 (40),
    descripcion VARCHAR2 (70),
    CONSTRAINT PK_nomtipo PRIMARY KEY (nom_tipo),
    CONSTRAINT CK_tipo CHECK (nom_tipo=INITCAP(nom_tipo))
);

CREATE TABLE composiciones (
    nom_composicion VARCHAR2 (70),
    movimientos NUMBER (2),
    tipo VARCHAR2 (40),
    grupo VARCHAR2 (40),
    nom_autor VARCHAR2 (30),
    CONSTRAINT PK_nomcomp PRIMARY KEY (nom_composicion),
    CONSTRAINT FK_nomautor FOREIGN KEY (nom_autor) REFERENCES compositores (nombre),
    CONSTRAINT CK_movimientos CHECK (movimientos > 1),
    CONSTRAINT CK_tip CHECK (tipo=INITCAP(tipo)),
    CONSTRAINT CK_grupo CHECK (grupo IN ('Orquesta sinfonica','Orquesta solista', 'Orquesta camara'))
);

CREATE TABLE interprete (
    nom_interprete VARCHAR2 (70),
    pais VARCHAR2 (20),
    solista VARCHAR2 (50) DEFAULT 'Nulo',
    CONSTRAINT PK_nomint PRIMARY KEY (nom_interprete),
    CONSTRAINT CK_pais CHECK (pais IS NOT NULL),
    CONSTRAINT CK_nom_int CHECK (nom_interprete=INITCAP(nom_interprete))
);

CREATE TABLE lugar_interpretacion (
    lugar VARCHAR2 (50),
    pais VARCHAR2 (20),
    aforo NUMBER (5) UNIQUE,
    arquitecto VARCHAR2 (50),
    CONSTRAINT PK_lugar PRIMARY KEY (lugar),
    CONSTRAINT CK_paisl CHECK (pais IS NOT NULL),
    CONSTRAINT CK_arquitecto CHECK (arquitecto=INITCAP(arquitecto))
    );

CREATE TABLE interpretacion (
    cod_interpretacion VARCHAR2 (5),
    obra VARCHAR2 (70) DEFAULT 'Orquestal',
    interprete VARCHAR2 (70),
    lugar_int VARCHAR2 (50),
    fecha DATE,
    CONSTRAINT PK_codint PRIMARY KEY (cod_interpretacion),
    CONSTRAINT FK_interp FOREIGN KEY (interprete) REFERENCES interprete (nom_interprete),
    CONSTRAINT FK_lugar FOREIGN KEY (lugar_int) REFERENCES lugar_interpretacion (lugar),
    CONSTRAINT FK_obra FOREIGN KEY (obra) REFERENCES composiciones (nom_composicion),
    CONSTRAINT CK_interp CHECK (interprete=INITCAP(interprete)),
    CONSTRAINT CK_hora CHECK (TO_CHAR(fecha, 'hh24:mi:ss') BETWEEN '18:00:00' AND '22:00:00')
);


/* INSERTS */

    /* Tabla compositores */
INSERT INTO compositores values ('Mozart', TO_DATE('27/01/1756', 'dd/mm/yyyy'), TO_DATE('05/12/1791', 'dd/mm/yyyy'),'CLASICISMO', 'Alemania');
INSERT INTO compositores values ('Chopin',TO_DATE('17/10/1849', 'dd/mm/yyyy'), TO_DATE('17/10/1849', 'dd/mm/yyyy'),'ROMANTICISMO', 'Polonia');
INSERT INTO compositores values ('Bach',TO_DATE('31/03/1685', 'dd/mm/yyyy'), TO_DATE('28/071750', 'dd/mm/yyyy'),'BARROCO', 'Alemania');
INSERT INTO compositores values ('Monteverdi',TO_DATE('09/05/1567', 'dd/mm/yyyy'),TO_DATE('29/11/1643', 'dd/mm/yyyy'),'BARROCO', 'Italia');
INSERT INTO compositores values ('Beethoven',TO_DATE('26/12/1770', 'dd/mm/yyyy'), TO_DATE('23/03/1827', 'dd/mm/yyyy'),'CLASICISMO','Alemania');
INSERT INTO compositores values ('Wagner',TO_DATE('22/05/1813', 'dd/mm/yyyy'), TO_DATE('13/02/1883', 'dd/mm/yyyy'),'ROMANTICISMO','Alemania');

    /* Tabla tipo */
INSERT INTO tipo VALUES ('Sinfonia', 'Composición musical de 3 o 4 movimientos');
INSERT INTO tipo VALUES ('Sonata','Danzas para ser sonadas');
INSERT INTO tipo VALUES ('Opera','Accion escénica armonizada, cantada y acompañada');
INSERT INTO tipo VALUES ('Concierto','Piezas consecutivas para orquesta y solista');
INSERT INTO tipo VALUES ('Duo','Composición para dos instrumentos');
INSERT INTO tipo VALUES ('Misa','Obra musical que cubre el ciclo ordinario de la liturgia');
INSERT INTO tipo VALUES ('Nocturnos','Pieza vocal o instrumental de estructura libre');
INSERT INTO tipo VALUES ('Danza','Pieza musical para ser bailada');
INSERT INTO tipo VALUES ('Motete','Composición polifónica para ser cantada en iglesias');
INSERT INTO tipo VALUES ('Tocata','Pieza instrumental para instrumentos de cuerda');
INSERT INTO tipo VALUES ('Oratorio','Género dramático sin puesta en escena');

    /* Tabla composiciones */
---
INSERT INTO composiciones values ('Concierto para violin n3 en Sol M','3','Concierto','Orquesta solista','Mozart');
INSERT INTO composiciones values ('La flauta mágica','42','Opera','Orquesta sinfonica','Mozart');
INSERT INTO composiciones values ('El rapto del serrallo','3','Opera','Orquesta sinfonica','Mozart');
---
INSERT INTO composiciones values ('Nocturnos Opus 9','21','Nocturnos','Orquesta sinfonica','Chopin');
INSERT INTO composiciones values ('Concierto para piano n2 en Fa M','3','Concierto','Orquesta solista','Chopin');
INSERT INTO composiciones values ('Sonata para Cello en Sol m Opus 65','4','Sonata','Orquesta solista','Chopin');
---
INSERT INTO composiciones values ('Pasión Según San Juan','40','Oratorio','Orquesta sinfonica','Bach');
INSERT INTO composiciones values ('Concierto de Brandemburgo','3','Concierto','Orquesta camara','Bach');
INSERT INTO composiciones values ('Concierto para 2 violines','3','Concierto','Orquesta solista','Bach');
---
INSERT INTO composiciones values ('Las fábulas de Orfeo','5','Opera','Orquesta sinfonica','Monteverdi');
INSERT INTO composiciones values ('Selva morale e spirituale','4','Misa','Orquesta sinfonica','Monteverdi');
INSERT INTO composiciones values ('El regreso de Ulises a la patria','5','Opera','Orquesta sinfonica','Monteverdi');
---
INSERT INTO composiciones values ('Sinfonía nº 5','4','Sinfonia','Orquesta sinfonica','Beethoven');
INSERT INTO composiciones values ('Marcha turca','2','Danza','Orquesta sinfonica','Beethoven');
INSERT INTO composiciones values ('Concierto para violín','4','Concierto','Orquesta solista','Beethoven');
---
INSERT INTO composiciones values ('Cabalgata de las Valquirias','32','Opera','Orquesta sinfonica','Wagner');
INSERT INTO composiciones values ('El holandés errante','15','Opera','Orquesta sinfonica','Wagner');
INSERT INTO composiciones values ('Tristán e Isolda','37','Opera','Orquesta sinfonica','Wagner');


    /* Tabla interprete */
INSERT INTO interprete values ('Orquesta Sajona de Dresde','Alemania','Hilary Hahn');
INSERT INTO interprete values ('Orquesta Sinfónica de Chicago','Estados Unidos','Nulo');
INSERT INTO interprete values ('Orquesta Filarmónica de Berlín','Alemania','Nulo');
INSERT INTO interprete values ('Orquesta Filarmónica de Viena','Austria','Nulo');
INSERT INTO interprete values ('Orquesta de Cleveland','Estados Unidos','Nulo');
INSERT INTO interprete values ('Orquesta Filarmónica de Madrid','España','Nulo');
INSERT INTO interprete values ('Orquesta Sinfónica de Londres','Inglaterra','Nulo');
INSERT INTO interprete values ('Orquesta Filarmónica de Nueva York','Estados Unidos','Nulo');
INSERT INTO interprete values ('Real Orquesta Del Concertgebouv','Paises Bajos','Nulo');
INSERT INTO interprete values ('Orquesta Filarmónica de Panamá','Panamá','Nulo');
INSERT INTO interprete values ('Orquesta Filarmónica de Sant Petesburgo','Rusia','Nulo');
INSERT INTO interprete values ('Orquesta Sinfónica de Boston','Estados Unidos','Nulo');

    /* Tabla lugar_interpretacion */
INSERT INTO lugar_interpretacion values ('Teatro de la Maestranza','España','1800','Aurelio Del Pozo');
INSERT INTO lugar_interpretacion values ('Ópera de Sidney','Australia','1547','Jorn Utzon');
INSERT INTO lugar_interpretacion values ('Teatro Colón','Argentina','2487','Francesco Tamburini');
INSERT INTO lugar_interpretacion values ('Teatro de la Scala','Italia','2030','Arturo Toscanini');
INSERT INTO lugar_interpretacion values ('Ópera Garnier','Francia','1979','Odile Deqc');
INSERT INTO lugar_interpretacion values ('Ópera Estatal De Viena','Austria','1709','Eduard Van Der Null');
INSERT INTO lugar_interpretacion values ('Royal Ópera House','Inglaterra','2268','Edward Middleton Barry');

    /* Tabla interpretación */
INSERT INTO interpretacion values ('M1111','La flauta mágica','Real Orquesta Del Concertgebouv','Teatro de la Scala', TO_DATE('25/11/2019 19:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('C1111','Sonata para Cello en Sol m Opus 65','Orquesta Filarmónica de Sant Petesburgo','Ópera Garnier',TO_DATE('17/02/1992 18:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('B1111','Concierto de Brandemburgo','Orquesta Filarmónica de Madrid','Ópera Estatal De Viena',TO_DATE('06/07/1983 21:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('M1112','Tristán e Isolda','Orquesta de Cleveland','Ópera de Sidney',TO_DATE('21/08/2002 18:30:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('B1112','Sinfonía nº 5','Orquesta Filarmónica de Berlín','Ópera Garnier',TO_DATE('01/01/1894 21:30:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('W1111','Concierto de Brandemburgo','Orquesta Filarmónica de Madrid','Teatro de la Maestranza',TO_DATE('31/12/2015 18:45:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('M1113','Concierto para violin n3 en Sol M','Orquesta Sajona de Dresde','Teatro Colón',TO_DATE('24/06/1997 21:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('C1113','Tristán e Isolda','Orquesta Filarmónica de Berlín','Royal Ópera House',TO_DATE('18/09/1989 20:40:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('B1113','El rapto del serrallo','Orquesta Filarmónica de Viena','Teatro de la Maestranza',TO_DATE('03/03/1981 18:45:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('M1114','El rapto del serrallo','Orquesta Sinfónica de Londres','Teatro de la Scala',TO_DATE('14/02/2020 19:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('B1114','Concierto de Brandemburgo','Orquesta Sinfónica de Boston','Ópera de Sidney',TO_DATE('15/08/2021 21:45:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('W1112','Tristán e Isolda','Orquesta Sinfónica de Chicago','Ópera Estatal De Viena',TO_DATE('13/05/2000 19:30:00', 'dd/mm/yyyy hh24:mi:ss'));


/* ENUNCIADOS */

/* 1.	Añade la columna director en la tabla Interpretación, que sea una cadena de 30 caracteres.*/
ALTER TABLE interpretacion ADD director VARCHAR (30);
    ---INSERTS
        INSERT INTO interpretacion (director) VALUES ('Sir Charles Mackerras');
        INSERT INTO interpretacion (director) VALUES ('Sir Thomas Beecham');
        INSERT INTO interpretacion (director) VALUES ('Sir Colin Davis');
        INSERT INTO interpretacion (director) VALUES ('Yevgeny Mravinsky');
        INSERT INTO interpretacion (director) VALUES ('Piere Monteux');
        INSERT INTO interpretacion (director) VALUES ('Bernard Haitink');
        INSERT INTO interpretacion (director) VALUES ('George Szell');
        INSERT INTO interpretacion (director) VALUES ('Carlo Maria Giulini');
        INSERT INTO interpretacion (director) VALUES ('Piere Boulez');
        INSERT INTO interpretacion (director) VALUES ('Wilhelm Furtwängler');
        INSERT INTO interpretacion (director) VALUES ('Daniel Baremboim');
        INSERT INTO interpretacion (director) VALUES ('Gustavo Dudamel');
        INSERT INTO interpretacion (director) VALUES ('Gustavo Gimeno');

/* 2.	Eliminar la columna Grupo de la tabla Composiciones.*/
ALTER TABLE composiciones DROP COLUMN grupo;

/* 3.	Modificar pais_nacimiento en la tabla Compositores incrementado a 30 los caracteres de la cadena.*/
ALTER TABLE compositores MODIFY pais_nacimiento VARCHAR (30);

/* 4.	Añadir una restricción a Aforo en la tabla Interpretación para que el mínimo sea 250. */
ALTER TABLE lugar_interpretacion ADD CONSTRAINT CK_minimo CHECK (aforo > 250);

/* 5.	Eliminar la restricción de hora sobre la tabla Interpretación.*/
ALTER TABLE interpretacion DROP CONSTRAINT CK_hora;

/* 6.	Desactivar la restricción que afecta a País_nacimiento de la tabla Compositores.*/
ALTER TABLE compositores DISABLE CONSTRAINT CK_nac;


/* Consultas */

/* CONSULTAS SENCILLAS */
    /* Muestra los compositores que nacieron después del año 1813.*/
        SELECT * 
        FROM compositores 
        WHERE fecha_nacimiento >'1813-01-01';

    /* Consulta el nombre de las obras qcuyo tipo de composicion sea 'Concierto.*/
        SELECT nom_composicion
        FROM composiciones
        WHERE tipo = 'Concierto';

/* VISTAS /*
    /* Muestra el nombre de las obras,su compositor, y su época, ordenados por número de movimientos.*/
CREATE VIEW obras 
    AS 
    SELECT c.nom_composicion, c.nom_autor, a.epoca
    FROM composiciones c, compositores a
    WHERE a.nombre = c.nom_autor;

SELECT *
FROM obras;

/* SUBCONSULTAS */
    ---Obtener el nombre, el país de los lugares en los que se ha interpretado 'Concierto de Brandemburgo'.
        SELECT pais
        FROM lugar_interpretacion
        WHERE lugar IN (SELECT lugar_int
                        FROM interpretacion
                        WHERE obra = 'Concierto de Brandemburgo');
                                                                    
    ---Muestra las obras de Beethoven que han sido interpretadas en Francia
        SELECT DISTINCT obra
        FROM interpretacion
        WHERE obra IN (SELECT nom_composicion
                            FROM composiciones
                            WHERE nom_autor = 'Beethoven'
                            and lugar_int IN (SELECT lugar
                                              FROM lugar_interpretacion
                                              WHERE pais = 'Francia'));
/* COMBINACIONES DE TABLAS */
    ---Muestra un listado con los compositores, epoca y el número total de obras de cada uno de ellos.
        SELECT p.nombre, p.epoca, count(o.nom_composicion) AS obras_totales
        FROM compositores p, composiciones o
        WHERE o.nom_autor = p.nombre
        GROUP BY p.nombre, p.epoca;

    ---Muestra el pais en los que se haya interpretado 'El rapto del serrallo'.
        SELECT pais
        FROM lugar_interpretacion
        WHERE lugar IN (SELECT lugar_int
                        FROM interpretacion
                        WHERE obra = 'El rapto del serrallo');

//* INSERCIÓN DE REGISTROS */
    ---Crear una tabla llamada Monteverdi (PIEZA, MOV, EP), con el mismo tipo y tamaño de las ya existentes. Insertar en la tabla el nombre de la pieza sea 'Nocturnos Opus 9' que está en la tabla composiciones, el número de movimientos sea igual que 'Marcha turca' y la época de Mozart de la tabla compositores mediante una consulta de datos anexados. INSERCCION DE REGISTROS*/
        CREATE TABLE Monteverdi (
            PIEZA VARCHAR (70),
            MOV INT (2),
            EP VARCHAR (20)
        );

        INSERT INTO Monteverdi (PIEZA, MOV, EP)
        VALUES ('Nocturnos Opus 9', (SELECT movimientos FROM composiciones WHERE nom_composicion = 'Marcha turca'), (SELECT epoca FROM compositores WHERE nombre = 'Mozart')); 

/* ACTUALIZACIÓN DE REGISTROS */
    ---Actualizar el numero de movimientos de la Pasión Según San Juan a 47.
        UPDATE composiciones
        SET movimientos = '47'
        WHERE nom_composicion = 'Pasión Según San Juan';
    
    --- Crear la columna total_interpretaciones, donde se incluya el número de veces que ha sido interpretada una obra.
        ALTER TABLE composiciones
        ADD total_interpretaciones NUMBER (5);

        UPDATE composiciones
        SET total_interpretaciones = (SELECT COUNT(obra)
                                      FROM interpretacion
                                      WHERE obra = nom_composicion);

/* BORRADO DE REGISTROS */
    ---Borrar registros de 'Trsitan e Isolda' de la tabla Interpretación.
        DELETE FROM interpretacion
        WHERE obra = 'Tristán e Isolda';

/* HAVING Y GROUP BY */
    ---Nombre del compositor y el número de movimientos en total de sus obras, ordenados por el nombre de autor.
        SELECT nom_autor, MAX(movimientos) AS max_movimientos, MIN(movimientos) AS min_movimientos
        FROM composiciones
        GROUP BY nom_autor
        HAVING MAX(movimientos) > 50 OR MIN(movimientos) < 5
        ORDER BY nom_autor;

/* COMBINACIONES EXTERNAS */
    --- Muestra el nombre de la obra, el nombre del autor y las veces que ha sido interpretada dicha obra, monstrando las que no han sido interpretadas y ordenándolas por número de veces que han sido interpretadas.
        SELECT c.nom_composicion, c.nom_autor, COUNT(cod_interpretacion) AS Num_Interpretaciones 
        FROM composiciones c, interpretacion o
        GROUP BY c.nom_composicion, c.nom_autor
        ORDER BY Num_Interpretaciones ASC;

/* CONSULTAS CON OPERADORES CONJUNTOS */
    --- Consulta el tipo de composicion con su descripcion y los tipos de composición con el nombre de las mismas y anexiónalas.
        SELECT nom_tipo, descripcion
        FROM tipo
        UNION
        SELECT tipo, nom_composicion
        FROM composiciones;
        
/* SUBCONSULTAS CORRELACIONADAS. */
    --- Muestra el nombre de la composición, el número de movimientos, el tipo, el grupo y el nombre del autor. Muestra las que no han sido interpretadas y ordenadas por número de movimientos.
    SELECT *
    FROM composiciones c
    WHERE movimientos = (SELECT MAX(movimientos)
                         FROM composiciones
                         WHERE nom_composicion = c.nom_composicion);
        
/* CONSULTA QUE INCLUYA VARIOS TIPOS DE LOS INDICADOS ANTERIORMENTE.*/
    ---Muestra la obra y la fecha de la interpretación realizada en el siglo XXI y que su código de interpretación comience por M y termine por 4.
    SELECT i.obra, i.fecha, i.cod_interpretacion
    FROM interpretacion i LEFT JOIN composiciones c ON c.nom_composicion = i.obra
    WHERE (i.fecha >='01/01/2000') AND  i.cod_interpretacion = (SELECT cod_interpretacion
                                                                FROM interpretacion
                                                                WHERE REGEXP_LIKE (cod_interpretacion, '^M.*4$'));

/* PLSQL */

/* FUNCIONES */
    /* Realiza una función que pida el nombre de un compositor y muestre la época a la que pertenece */
CREATE OR REPLACE FUNCTION EpocaCompositor (p_nombrecompositor compositores.nombre%TYPE)
RETURN 
    compositores.epoca%TYPE 
IS
    v_epoca compositores.epoca%TYPE;
BEGIN
    SELECT epoca 
    INTO v_epoca 
    FROM compositores 
    WHERE nombre = p_nombrecompositor;
    RETURN v_epoca;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
    DBMS_OUTPUT.PUT_LINE ('Error de nombre' || p_nombrecompositor ); 
    RETURN -1;
END;
/

            /*LLamamos a la función*/ 
DECLARE 
    v_epoca compositores.epoca%TYPE;
BEGIN 
    v_epoca:=EpocaCompositor('Jose');
    DBMS_OUTPUT.PUT_LINE('La epoca del compositor es ' || v_epoca || '.');
END;
/

    /* Realiza una función que pida el código de una interpretación y el nombre de la obra */
CREATE OR REPLACE FUNCTION CodigoNombreObra (p_codigointerpretacion interpretacion.cod_interpretacion%TYPE)
RETURN 
    compositores.epoca%TYPE
IS
    v_nombre compositores.nombre%TYPE;
BEGIN
    SELECT obra
    INTO v_nombre 
    FROM interpretacion 
    WHERE cod_interpretacion = p_codigointerpretacion;
    RETURN v_nombre;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE ('Error de codigo' || p_codigointerpretacion );
    RETURN -1;
END;
/

            /*LLamamos a la función*/ 
DECLARE 
    v_nombre compositores.nombre%TYPE;
BEGIN 
    v_nombre:=CodigoNombreObra('B1114');
    DBMS_OUTPUT.PUT_LINE('El nombre de la obra interpretada es ' || v_nombre || '.');
END;
/

/* PROCEDIMIENTOS */

    /* Realiza un procedimiento que cuente el numero de filas que hay en la tabla Interpretación, depositando el resultado en una variable y mostrando el contenido. */
CREATE OR REPLACE PROCEDURE NumeroFilas
IS
    v_numfilas NUMBER;
BEGIN
    SELECT count(*)
    INTO v_numfilas
    FROM interpretacion;
    dbms_output.put_line('El número de filas de la tabla interpretación es: '|| v_numfilas);
END;
/
            /* Ejecutamos el procedimiento */ 
exec NumeroFilas;

/* Realiza un procedimiento que MostrarCompositoresMasInterpretados que muestre el nombre de los compositores que han interpretado más de una vez. */
CREATE OR REPLACE PROCEDURE CompMasInterpretados
IS
    cursor c_compositores IS
        SELECT nombre
        FROM compositores
        ORDER BY nombre desc;
    v_nombre c_compositores%ROWTYPE;
BEGIN
    open c_compositores;
    fetch c_compositores into v_nombre;
    WHILE c_compositores%FOUND AND c_compositores%ROWCOUNT<=2 LOOP
        dbms_output.put_line('El compositor ' || v_nombre || ' se ha interpretado dos veces o más.');
    END LOOP;
    IF c_compositores%ROWCOUNT < 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No hay compositores con más de una interpretación.');
    END IF;
    close c_compositores;
END;
/


/* INFORMES */
    /* Realiza un procedimiento llamado ListadoMásInterpretados que muestre:
        - Un listado de las 3 obras más interpretadas. 
        - Las orquestas que lo han realizado 
        - La fecha de interpretación.
    Debemos controlar las siguientes excepciones:
        - Tabla vacía de interpretación.
        - Tabla vacía de tipo.
        - Hay menos de 3 obras que hayan sido interpretadas.*/
CREATE OR REPLACE PROCEDURE ComprobarExcepciones
IS
    e_interpretacion_vacia EXCEPTION;
    e_tipo_vacio EXCEPTION;
    e_numero_obras EXCEPTION;

    v_num_interpretaciones NUMBER;
    v_num_tipos NUMBER;
    v_num_obras NUMBER;
BEGIN
    SELECT count(*)
    INTO v_num_interpretaciones
    FROM interpretacion;
    SELECT count(*)
    INTO v_num_tipos
    FROM tipo;
    SELECT count(DISTINCT obra)
    INTO v_num_obras
    FROM obras;
    IF v_num_interpretaciones = 0 THEN
        RAISE e_interpretacion_vacia;
    END IF;
    IF v_num_tipos = 0 THEN
        RAISE e_tipo_vacio;
    END IF;
    IF v_num_obras < 4 THEN
        RAISE e_numero_obras;
    END IF;
EXCEPTION
    WHEN e_interpretacion_vacia THEN
        dbms_output.put_line('La tabla interpretación está vacía.');
    WHEN e_tipo_vacio THEN
        dbms_output.put_line('La tabla tipo está vacía.');
    WHEN e_numero_obras THEN
        dbms_output.put_line('Hay menos de 3 obras.');
        raise;
END;

CREATE OR REPLACE PROCEDURE MostrarCabeceraInforme
IS
BEGIN
    dbms_output.put_line('Listado de las 3 obras más interpretadas.');
    dbms_output.put_line('-------------------------------------');
END;
/


CREATE OR REPLACE PROCEDURE MostrarObras (p_obras interpretacion.obra%TYPE)
IS
    cursor c_interpretacion is
        SELECT obra, fecha
        FROM interpretacion
        WHERE obra = p_obras;
BEGIN
    for v_interpretacion in c_interpretacion loop
        dbms_output.put_line('Obra: ' || v_interpretacion.obra);
        dbms_output.put_line('Fecha: ' || v_interpretacion.fecha);
    end loop;
END;
/
---------INACABADO-------



/* TRIGGERS */

    /* Realiza un trigger que impida introducir una interpretación con fecha de interpretación posterior a la fecha actual. */
CREATE OR REPLACE TRIGGER tr_fecha_interpretacion 
BEFORE INSERT ON interpretacion 
FOR EACH ROW
BEGIN
    IF (:new.fecha < sysdate) THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de interpretación debe ser posterior a la de la última obra.');
    END IF;
END;
/

        /* comprobación de funcionamiento */
INSERT INTO interpretacion values ('M997','La flauta mágica','Real Orquesta Del Concertgebouv','Teatro de la Scala', TO_DATE('9/06/2022 19:00:00', 'dd/mm/yyyy hh24:mi:ss'));
INSERT INTO interpretacion values ('M998','La flauta mágica','Real Orquesta Del Concertgebouv','Teatro de la Scala', TO_DATE('11/06/2022 19:00:00', 'dd/mm/yyyy hh24:mi:ss'));


    /* Registrar todas las operaciones hechas sobre la tabla ventas en una tabla llamada Auditoria_interpretaciones donde se guarde usuario, fecha y tipo de operación. */
CREATE TABLE Auditoria_interpretaciones (
    usuario VARCHAR (30),
    fecha DATE,
    tipo_operacion VARCHAR (30)
);

CREATE OR REPLACE TRIGGER tr_auditoria_interpretaciones 
BEFORE INSERT OR UPDATE OR DELETE ON interpretacion
declare
	v_operacion varchar2(20);
begin
	if (inserting) then
		v_operacion := 'Insert';
	elsif (updating) then
		v_operacion := 'Update';
	elsif (deleting) then
		v_operacion := 'Delete';
	end if;
	insert into Auditoria_interpretaciones values(user, sysdate, v_operacion);
end;
/

        /* comprobación de funcionamiento */
INSERT INTO interpretacion values ('M999','La flauta mágica','Real Orquesta Del Concertgebouv','Teatro de la Scala', TO_DATE('10/06/2022 19:00:00', 'dd/mm/yyyy hh24:mi:ss',));
UPDATE interpretacion SET obra = 'El holandés errante' WHERE cod_interpretacion = 'M999';
DELETE FROM interpretacion WHERE cod_interpretacion = 'M999';
SELECT * FROM Auditoria_interpretaciones;