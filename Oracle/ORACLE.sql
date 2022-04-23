CREATE TABLE compositores (
    nombre VARCHAR (30),
    fecha_nacimiento DATE,
    fecha_muerte DATE,
    epoca VARCHAR (20),
    pais_naciemnto VARCHAR (20),
    CONSTRAINT PK_nom PRIMARY KEY (nombre),
    CONSTRAINT CK_fnac CHECK (TO_NUMBER(substr(carreradeb, -4, 4)) BETWEEN 1500 AND 1900),
    CONSTRAINT CK_epoca CHECK (upper(epoca) IN ('Renacimiento','Barroco','Clásica','Clásica','Romántica', 'Moderna')),
    CONSTRAINT CK_fnac CHECK (pais_nacimiento IS NOT NULL)
);


CREATE TABLE composiciones (
    nom_composicion VARCHAR (70),
    movimientos NUMBER (2),
    tipo VARCHAR2 (40),
    grupo VARCHAR2 (40),
    nom_autor VARCHAR2 (30),
    CONSTRAINT PK_nomcomp PRIMARY KEY (nom_composicion),
    CONSTRAINT FK_nomautor FOREIGN KEY (nom_autor) REFERENCES compositores (nombre)
    CONSTRAINT CK_movimientos CHECK (movimientos > 1),
    CONSTRAINT CK_tipo CHECK (tipo=INITCAP(tipo)),
    CONSTRAINT CK_grupo CHECK (grupo) IN ('Orquesta sinfónica','Orquesta solista', 'Orquesta cámara')
);


CREATE TABLE interprete (
    nom_interprete VARCHAR2 (70),
    pais VARCHAR2 (20),
    tipo_comp VARCHAR2 (20),
    solista VARCHAR2 (50) DEFAULT 'Nulo',
    CONSTRAINT PK_nomint PRIMARY KEY (nom_interprete),
    CONSTRAINT FK_tipo FOREIGN KEY (tipo) REFERENCES composiciones (tipo_comp)
    CONSTRAINT CK_pais CHECK (pais IS NOT NULL),
    CONSTRAINT CK_tipo CHECK (tipo) IN ('Orquesta sinfónica','Orquesta solista', 'Orquesta cámara')
);

CREATE TABLE lugar_interpretacion (
    lugar VARCHAR2 (50),
    pais VARCHAR2 (20) NOT NULL,
    aforo NUMBER (5) UNIQUE,
    arquitecto VARCHAR2 (50),
    CONSTRAINT PK_lugar PRIMARY KEY (lugar),
    CONSTRAINT CK_arquitecto (arquitecto=INITCAP(arquitecto))
);

CREATE TABLE interpretacion (
    cod_interpretacion VARCHAR2 (5),
    obra VARCHAR (70),
    interprete VARCHAR (70),
    lugar_int VARCHAR (50),
    fecha DATETIME,
    CONSTRAINT PK_codint PRIMARY KEY (cod_interpretacion),
    CONSTRAINT FK_interp FOREIGN KEY (interprete) REFERENCES interprete (nom_interprete),
    CONSTRAINT FK_lugar FOREIGN KEY (lugar_int) REFERENCES interpretacion (lugar),
    CONSTRAINT CK_obra CHECK obra DEFAULT 'Orquestal',
    CONSTRAINT CK_interp CHECK (interprete=INITCAP(interprete)),
    CONSTRAINT CK_hora CHECK (hora > TO_DATE(TO_CHAR(TRUNC)(hora), 'DD/MM/YYYY' || '18:00:00', 'DD/MM/YYYY HH24:MI:SS')) BETWEEN (hora < TO_DATE(TO_CHAR(TRUNC)(hora), 'DD/MM/YYYY' || '22:00:00', 'DD/MM/YYYY HH24:MI:SS'))
);

/* ENUNCIADOS */

/* 1.	Añade la columna director en la tabla Interpretación, que sea una cadena de 30 caracteres.*/
ALTER TABLE interpretacion ADD director VARCHAR2 (3);

/* 2.	Eliminar la columna Movimientos de la tabla Composiciones.*/
ALTER TABLE composiciones DROP movimientos;

/* 3.	Modificar nombre en la tabla Compositores disminuyendo a 20 los caracteres de la cadena.*/
ALTER TABLE compositores MODIFY nombre VARCHAR2 (20);

/* 4.	Añadir una restricción a Aforo en la tabla Interpretación para que el mínimo sea 250. */
ALTER TABLE interpretacion ADD CONSTRAINT CK_minimo (aforo > 250);

/* 5.	Eliminar la restricción sobre la columna Obra de la tabla Interpretación.*/
ALTER TABLE interpretación DROP CONSTRAINT CK_obra;

/* 6.	Desactivar la restricción que afecta a País_nacimiento de la tabla Compositores.*/
ALTER TABLE compositores DISABLE CONSTRAINT CK_fnac;

/* INSERTS */

    /* Tabla compositores */
INSERT INTO compositores values ('Mozart', '1756-01-27', '1791-12-05' ,'Clasicismo', 'Alemania');
INSERT INTO compositores values ('Chopin','1849-10-17', '1849-10-17' ,'Romanticismo', 'Polonia');
INSERT INTO compositores values ('Bach','1685-03-31', '1750-07-28','Barroco', 'Alemania');
INSERT INTO compositores values ('Monteverdi','1567-05-09', '1643-11-29','Barroco', 'Italia');
INSERT INTO compositores values ('Beethoven','1770-12-26', '1827-03-26','Clasicismo','Alemania');
INSERT INTO compositores values ('Wagner','1813-05-22', '1883-02-13','Romanticismo','Alemania');

    /* Tabla composiciones */
---
INSERT INTO composiciones values ('Concierto para violin n3 en Sol M','3','Orquesta Sinfónica y solista','Sinfónica con solista','Mozart');
INSERT INTO composiciones values ('Sonata para teclado a cuatro manos','3','Sonata','Duo','Mozart');
INSERT INTO composiciones values ('El rapto del serrallo','3','Opera','Orquesta Sinfónica y Vocalista','Mozart');
---
INSERT INTO composiciones values ('Nocturnos Opus 9','21','Nocturnos','Instrumental','Chopin');
INSERT INTO composiciones values ('Concierto para piano n2 en Fa M','3','Concierto','Orquesta Sinfónica y solista','Chopin');
INSERT INTO composiciones values ('Sonata para Cello en Sol m Opus 65','4','Sonata','Orquesta Sinfónica y solista','Chopin');
---
INSERT INTO composiciones values ('Pasión Según San Juan','40','Oratorio','Orquesta Sinfónica','Bach')
INSERT INTO composiciones values ('Concierto de Brandemburgo','3','Concierto','Orquesta de Cámara','Bach')
INSERT INTO composiciones values ('Concierto para 2 violines','3','Concierto','Concierto Solista','Bach')
---
INSERT INTO composiciones values ('Las fábulas de Orfeo','5','Opera','Orquesta Sinfónica','Monteverdi')
INSERT INTO composiciones values ('Selva morale e spirituale','4','Misa','Orquesta Sinfónica','Monteverdi')
INSERT INTO composiciones values ('El regreso de Ulises a la patria','5','Opera','Orquesta Sinfónica','Monteverdi')
---
INSERT INTO composiciones values ('Sinfonía nº 5','4','Sinfonía','Orquesta Sinfónica','Beethoven')
INSERT INTO composiciones values ('Marcha turca','1','Danza','Orquesta Sinfónica','Beethoven')
INSERT INTO composiciones values ('Concierto para violín','4','Concierto','Orquesta solista','Beethoven')
---
INSERT INTO composiciones values ('Cabalgata de las Valquirias','32','Opera','Orquesta Sinfónica','Wagner')
INSERT INTO composiciones values ('El holandés errante','15','Opera','Orquesta Sinfónica','Wagner')
INSERT INTO composiciones values ('Tristán e Isolda','37','Opera','Orquesta Sinfónica','Wagner')

    /* Tabla interprete */
INSERT INTO interpretes values ('Orquesta Sajona de Dresde','Alemania','Orquesta Sinfónica y solista','Hilary Hahn')
INSERT INTO interpretes values ('Orquesta Sinfónica de Chicago','Estados Unidos','Orquesta Sinfónica','Nulo')
INSERT INTO interpretes values ('Orquesta filarmónica de Berlín','Alemania','Orquesta Sinfónica','Nulo')
INSERT INTO interpretes values ('Orquesta Filarmónica de Viena','Austria','Orquesta Sinfónica y Vocalista','Nulo')
INSERT INTO interpretes values ('Orquesta de Cleveland','Estados Unidos','Orquesta Sinfónica','Nulo')
INSERT INTO interpretes values ('Orquesta Filarmónica de Madrid','España','Orquesta de Cámara','Nulo')
INSERT INTO interpretes values ('Orquesta Sinfónica de Londres','Inglaterra','Orquesta Sinfónica y Vocalista','Nulo')
INSERT INTO interpretes values ('Orquesta Filarmónica de Nueva York','Estados Unidos','Orquesta Sinfónica','Nulo')
INSERT INTO interpretes values ('Real Orquesta del Concertgebouv','Paises Bajos','Duo','Nulo')
INSERT INTO interpretes values ('Orquesta Filarmónica de Panamá','Panamá','Orquesta Sinfónica','Nulo')
INSERT INTO interpretes values ('Orquesta Filarmónica de Sant Petesburgo','Rusia','Orquesta Sinfónica y solista','Nulo')
INSERT INTO interpretes values ('Orquesta Sinfónica de Boston','Estados Unidos','Orquesta de Cámara','Nulo')

    /* Tabla lugar_interpretacion */
INSERT INTO lugar_interpretacion values ('Teatro de la Maestranza','España','1800','Aurelio del Pozo')
INSERT INTO lugar_interpretacion values ('Ópera de Sidney','Australia','1547','Jorn Utzon')
INSERT INTO lugar_interpretacion values ('Teatro Colón','Argentina','2487','Francesco Tamburini')
INSERT INTO lugar_interpretacion values ('Teatro de la Scala','Italia','2030','Arturo Toscanini')
INSERT INTO lugar_interpretacion values ('Ópera Garnier','Francia','1979','Odile Deqc')
INSERT INTO lugar_interpretacion values ('Ópera Estatal de Viena','Austria','1709','Eduard van der Nüll')
INSERT INTO lugar_interpretacion values ('Royal Ópera House','Inglaterra','2268','Edward Middleton Barry')

    /* Tabla interpretación */
INSERT INTO interpretacion values ('M1111','Sonata para teclado a cuatro manos','Real Orquesta del Concertgebouv','Teatro de la Scala','2019-11-25 19:00:00')
INSERT INTO interpretacion values ('C1111','Sonata para Cello en Sol m Opus 65','Orquesta Filarmónica de Sant Petesburgo','Ópera Garnier','1992-02-17 18:00:00')
INSERT INTO interpretacion values ('B1111','Concierto de Brandemburgo','Orquesta Filarmónica de Madrid','Ópera Estatal de Viena','1983-07-06 21:00:00')
INSERT INTO interpretacion values ('M1112','Tristán e Isolda','Orquesta de Cleveland','Ópera de Sidney','2002-08-21 18:30:00')
INSERT INTO interpretacion values ('B1112','Sinfonía nº 5','Orquesta filarmónica de Berlín','Ópera Garnier','1894-01-01 21:30:00')
INSERT INTO interpretacion values ('W1111','Concierto de Brandemburgo','Orquesta Filarmónica de Madrid','Teatro de la Maestranza','2015-12-31 18:45:00')
INSERT INTO interpretacion values ('M1112','Concierto para violin n3 en Sol M','Orquesta Sajona de Dresde','Teatro Colón','1997-06-24 21:00:00')
INSERT INTO interpretacion values ('C1113','Tristán e Isolda','Orquesta filarmónica de Berlín','Royal Ópera House','1989-09-18 20:40:00')
INSERT INTO interpretacion values ('B1113','El rapto del serrallo','Orquesta Filarmónica de Viena','Teatro de la Maestranza','1981-03-03 18:45:00')
INSERT INTO interpretacion values ('M1114','El rapto del serrallo','Orquesta Sinfónica de Londres','Teatro de la Scala','2020-02-14 19:00:00')
INSERT INTO interpretacion values ('B1114','Concierto de Brandemburgo','Orquesta Sinfónica de Boston','Ópera de Sidney','2021-08-15 21:45:00')
INSERT INTO interpretacion values ('W1112','Tristán e Isolda','Orquesta Sinfónica de Chicago','Ópera Estatal de Viena','2000-05-13 19:30:00')


/* Consultas */
/* 1: Muestra los compositores que nacieron antes del año 1813. */
    SELECT *
    FROM compositores
    WHERE fecha_nacimiento <'01/01/1813';

/* 2: Muestra el nombre de las obras,su compositor, y su época, ordenados por número de movimientos.*/
    CREATE VIEW obras
    as
    (SELECT nom_composicion, nom_autor FROM composiciones)
    UNION
    (SELECT epoca FROM compositores);

    SELECT *
    FROM composiciones
    ORDER BY movimientos;

/* 3: Obtener el nombre y el país de los lugares en los que se ha interpretado 'Concierto de Brandemburgo'.*/
    SELECT lugar, pais
    FROM lugar_interpretacion
    WHERE pieza is (SELECT interprete
                    FROM interpretacion
                    WHERE obra = 'Concierto de Brandemburgo');

/* 4: Muestra un listado con los compositores, epoca y el número total de obras de cada uno de ellos. */
    SELECT p.nombre || '-' || p.epoca, count (o.obras)
    FROM compositores p, composiciones o
    WHERE o.nom_autor = p.nombre
    GROUP BY p.nombre;

/* 5: Crear una tabla llamada Monteverdi (PIEZA, MOV, EP), con el mismo tipo y tamaño de las ya existentes. Insertar en la tabla el nombre de la pieza, 
el número de movimientos y la época de las obras de Monteverdi mediante una consulta de datos anexados.*/
    CREATE TABLE monteverdi (
        PIEZA VARCHAR (70),
        MOV NUMBER (2),
        EP VARCHAR (20)
    );

    INSERT INTO monteverdi
    SELECT nom_composicion, movimientos, epoca
    FROM compositores p, composiciones o
    WHERE p.nombre and o.nom_autor = 'Monteverdi';
 
/* 6: Actualizar el numero de movimientos de la Pasión Según San Juan a 47. */
    UPDATE composiciones
    SET movimientos = '47'
    WHERE nom_composicion = 'Pasión Según San Juan';

/* 7: Borrar registros de 'Trsitan e Isolda' de la tabla Interpretación. */
    DELETE FROM interpretacion
    WHERE obra = 'Tristán e Isolda';

/* 8 Nombre del compositor y el número de movimientos en total de sus obras. */
    SELECT p.nombre
    FROM compositores p, composiciones obra
    WHERE p.nombre = o.nom_autor
    GROUP BY p.nombre
    HAVING sum(movimientos) > (SELECT sum(movimientos)
                                FROM composiciones)
    ;

/* 9: Mostra el código de interpretación y el tipo de composición. */
    SELECT p.

/* 10: Consultas con operadores conjuntos*/

/* 11: Subconsultas correlacionadas. */

/* 12: Consulta que incluya varios tipos de los indicados anteriormente.*/