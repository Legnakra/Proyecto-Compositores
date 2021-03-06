CREATE TABLE compositores (     
    nombre VARCHAR (30),
    fecha_nacimiento DATE,     
    fecha_muerte DATE,     
    epoca VARCHAR (20),     
    pais_nacimiento VARCHAR (20),     
    CONSTRAINT PK_nom PRIMARY KEY (nombre), 
    CONSTRAINT CK_fnac CHECK (fecha_nacimiento BETWEEN '1500-01-01' AND '1900-12-31'), 
    CONSTRAINT CK_epoca CHECK (epoca=INITCAP(epoca)),     
    CONSTRAINT CK_nac CHECK (pais_nacimiento IS NOT NULL) 
    );

CREATE TABLE tipo (
    nom_tipo VARCHAR (40),
    descripcion VARCHAR (70),
    CONSTRAINT PK_nomtip PRIMARY KEY (nom_tipo),
    CONSTRAINT CK_int CHECK (nom_tipo=INITCAP(nom_tipo))
);

CREATE TYPE form AS ENUM ('Orquesta sinfonica','Orquesta solista', 'Orquesta cámara');

CREATE TABLE composiciones (
    nom_composicion VARCHAR (70),
    movimientos SERIAL,
    tipo VARCHAR (40),
    grupo VARCHAR (30),
    nom_autor VARCHAR (30),
    CONSTRAINT PK_nomcomp PRIMARY KEY (nom_composicion),
    CONSTRAINT FK_nomautor FOREIGN KEY (nom_autor) REFERENCES compositores (nombre),
    CONSTRAINT FK_composicion FOREIGN KEY (tipo) REFERENCES tipo (nom_tipo),
    CONSTRAINT CK_movimientos CHECK (movimientos >= 1),
    CONSTRAINT CK_tipo CHECK (tipo=INITCAP(tipo))
);

CREATE TABLE interprete (
    nom_interprete VARCHAR (70),
    pais VARCHAR (20) NOT NULL,
    solista VARCHAR (50) DEFAULT 'Nulo',
    CONSTRAINT PK_nomint PRIMARY KEY (nom_interprete),
    CONSTRAINT CK_int CHECK (nom_interprete=INITCAP(nom_interprete))
);

CREATE TABLE lugar_interpretacion (
    lugar VARCHAR (50),
    pais VARCHAR (20) NOT NULL,
    aforo SERIAL UNIQUE,
    arquitecto VARCHAR (50),
    CONSTRAINT PK_lugar PRIMARY KEY (lugar),
    CONSTRAINT CK_arquitecto CHECK (arquitecto=INITCAP(arquitecto))
    );

CREATE TABLE interpretacion (
    cod_interpretacion VARCHAR (5),
    obra VARCHAR (70) DEFAULT 'Orquestal',
    interprete VARCHAR (70),
    lugar_inter VARCHAR (50),
    fecha TIMESTAMP,
    CONSTRAINT PK_codint PRIMARY KEY (cod_interpretacion),
    CONSTRAINT FK_interp FOREIGN KEY (interprete) REFERENCES interprete (nom_interprete),
    CONSTRAINT FK_lugar FOREIGN KEY (lugar_inter) REFERENCES lugar_interpretacion (lugar),
    CONSTRAINT CK_interp CHECK (interprete=INITCAP(interprete)),
    CONSTRAINT CK_hora_inicio CHECK ((TIMESTAMP_FORMAT(fecha, '%H') >= '18') AND (TIMESTAMP_FORMAT(fecha, '%H') <= '22'))
);

/* ENUNCIADOS */

/* 1.	Añade la columna director en la tabla Interpretación, que sea una cadena de 30 caracteres.*/
ALTER TABLE interpretacion ADD director VARCHAR (30);

/* 2.	Eliminar la columna Grupo de la tabla Composiciones.*/
ALTER TABLE composiciones DROP grupo;

/* 3.	Modificar pais_nacimiento en la tabla Compositores incrementado a 30 los caracteres de la cadena.*/
ALTER TABLE compositores ALTER COLUMN pais_nacimiento TYPE VARCHAR (30);

/* 4.	Añadir una restricción a Aforo en la tabla Interpretación para que el mínimo sea 250. */
ALTER TABLE lugar_interpretacion ADD CONSTRAINT CK_minimo CHECK (aforo > 250);

/* 5.	Eliminar la restricción default sobre la columna Obra de la tabla Interpretación.*/
ALTER TABLE interpretacion DROP CONSTRAINT CK_obra;

/* 6.	Desactivar la restricción que afecta a País_nacimiento de la tabla Compositores.*/
ALTER TABLE compositores DISABLE CK_nac;

/* INSERTS */

    /* Tabla compositores */
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Mozart', '1756-01-27', '1791-12-05' ,'Clasicismo', 'Alemania');
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Chopin','1849-10-17', '1849-10-17' ,'Romanticismo', 'Polonia');
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Bach','1685-03-31', '1750-07-28','Barroco', 'Alemania');
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Monteverdi','1567-05-09', '1643-11-29','Barroco', 'Italia');
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Beethoven','1770-12-26', '1827-03-26','Clasicismo','Alemania');
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Wagner','1813-05-22', '1883-02-13','Romanticismo','Alemania');

    /* Tabla tipo */
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Sinfonia', 'Composición musical de 3 o 4 movimientos');
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Sonata','Danzas para ser sonadas');
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Opera','Accion escénica armonizada, cantada y acompañada');
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Concierto','Piezas consecutivas para orquesta y solista');
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Duo','Composición para dos instrumentos');
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Misa','Obra musical que cubre el ciclo ordinario de la liturgia');
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Nocturnos','Pieza vocal o instrumental de estructura libre');
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Danza','Pieza musical para ser bailada');
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Motete','Composición polifónica para ser cantada en iglesias');
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Tocata','Pieza instrumental para instrumentos de cuerda');
INSERT INTO tipo (nom_tipo, descripcion) VALUES ('Oratorio','Género dramático sin puesta en escena');

    /* Tabla composiciones */
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto para violin n3 en Sol M','3','Concierto','Orquesta solista','Mozart');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('La flauta mágica','42','Opera','Orquesta Sinfonica','Mozart');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('El rapto del serrallo','3','Opera','Orquesta Sinfonica','Mozart');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Nocturnos Opus 9','21','Nocturnos','Orquesta Sinfonica','Chopin');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto para piano n2 en Fa M','3','Concierto','Orquesta solista','Chopin');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Sonata para Cello en Sol m Opus 65','4','Sonata','Orquesta solista','Chopin');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Pasión Según San Juan','40','Oratorio','Orquesta sinfónica','Bach');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto de Brandemburgo','3','Concierto','Orquesta cámara','Bach');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto para 2 violines','3','Concierto','Orquesta solista','Bach');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Las fábulas de Orfeo','5','Opera','Orquesta Sinfónica','Monteverdi');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Selva morale e spirituale','4','Misa','Orquesta Sinfónica','Monteverdi');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('El regreso de Ulises a la patria','5','Opera','Orquesta Sinfónica','Monteverdi');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Sinfonía nº 5','4','Sinfonia','Orquesta Sinfónica','Beethoven');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Marcha turca','1','Danza','Orquesta Sinfónica','Beethoven');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto para violín','4','Concierto','Orquesta solista','Beethoven');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Cabalgata de las Valquirias','32','Opera','Orquesta Sinfónica','Wagner');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('El holandés errante','15','Opera','Orquesta Sinfónica','Wagner');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Tristán e Isolda','37','Opera','Orquesta Sinfónica','Wagner');

    /* Tabla interprete */
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Sajona De Dresde','Alemania','Hilary Hahn');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Sinfónica De Chicago','Estados Unidos','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica De Berlín','Alemania','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica De Viena','Austria','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta De Cleveland','Estados Unidos','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica De Madrid','España','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Sinfónica De Londres','Inglaterra','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica De Nueva York','Estados Unidos','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Real Orquesta Del Concertgebouv','Paises Bajos','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica De Panamá','Panamá','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica De Sant Petesburgo','Rusia','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Sinfónica De Boston','Estados Unidos','Nulo');

    /* Tabla lugar_interpretacion */
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Teatro de la Maestranza','España','1800','Aurelio Del Pozo');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Ópera de Sidney','Australia','1547','Jorn Utzon');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Teatro Colón','Argentina','2487','Francesco Tamburini');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Teatro de la Scala','Italia','2030','Arturo Toscanini');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Ópera Garnier','Francia','1979','Odile Deqc');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Ópera Estatal de Viena','Austria','1709','Eduard Van Der Nüll');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Royal Ópera House','Inglaterra','2268','Edward Middleton Barry');

    /* Tabla interpretación */
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('M1111','La flauta mágica','Real Orquesta Del Concertgebouv','Teatro de la Scala','2019-12-25 19:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('C1111','Sonata para Cello en Sol m Opus 65','Orquesta Filarmónica De Sant Petesburgo','Ópera Garnier','1992-02-17 18:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('B1111','Concierto de Brandemburgo','Orquesta Filarmónica De Madrid','Ópera Estatal de Viena','1983-07-06 21:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('M1112','Tristán e Isolda','Orquesta De Cleveland','Ópera de Sidney','2002-08-21 18:30:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('B1112','Sinfonía nº 5','Orquesta Filarmónica De Berlín','Ópera Garnier','1894-01-01 21:30:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('W1111','Concierto de Brandemburgo','Orquesta Filarmónica De Madrid','Teatro de la Maestranza','2015-12-31 18:45:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('M1113','Concierto para violin n3 en Sol M','Orquesta Sajona De Dresde','Teatro Colón','1997-06-24 21:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('C1113','Tristán e Isolda','Orquesta Filarmónica De Berlín','Royal Ópera House','1989-09-18 20:40:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('B1113','El rapto del serrallo','Orquesta Filarmónica De Viena','Teatro de la Maestranza','1981-03-03 18:45:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('M1114','El rapto del serrallo','Orquesta Sinfónica De Londres','Teatro de la Scala','2020-02-14 19:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('B1114','Concierto de Brandemburgo','Orquesta Sinfónica De Boston','Ópera de Sidney','2021-08-15 21:45:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_inter,fecha) values ('W1112','Tristán e Isolda','Orquesta Sinfónica De Chicago','Ópera Estatal de Viena','2000-05-13 19:30:00');


/* Consultas */

/* CONSULTAS SENCILLAS */
    ---Muestra los compositores que nacieron después del año 1813.
        SELECT * 
        FROM compositores 
        WHERE fecha_nacimiento >'1813-01-01';

    ---Consulta el nombre de las obras qcuyo tipo de composicion sea 'Concierto.
        SELECT nom_composicion AS Conciertos
        FROM composiciones
        WHERE tipo = 'Concierto';

/* VISTAS */
    ---Muestra el nombre de las obras,su compositor, y su época, ordenados por número de movimientos.
        CREATE VIEW obras 
        AS 
        SELECT c.nom_composicion, c.nom_autor, a.epoca
        FROM composiciones c, compositores a
        WHERE a.nombre = c.nom_autor;

        SELECT *
        FROM obras;

/* SUBCONSULTAS */
    ---Obtener el nombre y el país de los lugares en los que se ha interpretado 'Concierto de Brandemburgo'.
        SELECT pais
        FROM lugar_interpretacion
        WHERE lugar IN (SELECT lugar_inter
                        FROM interpretacion
                        WHERE obra = 'Concierto de Brandemburgo');
    
    --- Muestra las obras de Beethoven que han sido interpretadas en Francia
        SELECT DISTINCT obra
        FROM interpretacion
        WHERE obra IN (SELECT nom_composicion
                            FROM composiciones
                            WHERE nom_autor = 'Beethoven'
                            and lugar_inter IN (SELECT lugar
                                              FROM lugar_interpretacion
                                              WHERE pais = 'Francia'));

/* COMBINACIONES DE TABLAS */
    ---Muestra un listado con los compositores, epoca y el número total de obras de cada uno de ellos.
        SELECT p.nombre, p.epoca, count(nom_composicion) AS obras_totales
        FROM compositores p, composiciones o
        WHERE o.nom_autor = p.nombre
        GROUP BY p.nombre;


    ---Muestra el pais en los que se haya interpretado 'El rapto del serrallo'.
        SELECT pais
        FROM lugar_interpretacion
        WHERE lugar IN(SELECT lugar_inter
                        FROM interpretacion
                        WHERE obra = 'El rapto del serrallo');

/* INSERCIÓN DE REGISTROS */
    ---Crear una tabla llamada Monteverdi (PIEZA, MOV, EP), con el mismo tipo y tamaño de las ya existentes. Insertar en la tabla el nombre de la pieza sea 'Nocturnos Opus 9' que está en la tabla composiciones, el número de movimientos sea igual que 'Marcha turca' y la época de las obra de Monteverdi mediante una consulta de datos anexados. INSERCCION DE REGISTROS*/
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
    
    --- Crear una columna llamada total_interpretaciones en la tabla composiciones, donde se incluya el número de veces que ha sido interpretada una obra. 
        ALTER TABLE composiciones 
        ADD total_interpretaciones INT (5);

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
        FROM composiciones c LEFT JOIN interpretacion o ON o.obra = c.nom_composicion
        GROUP BY c.nom_composicion, c.nom_autor
        ORDER BY Num_Interpretaciones ASC;

/* CONSULTAS CON OPERADORES CONJUNTOS */
    --- Consulta el tipo de composicion con su descripcion y los tipos de composición con el nombre de las mismas y anexiónalas.
        SELECT tipo, nom_composicion
        FROM composiciones
        UNION
        SELECT nom_tipo, descripcion
        FROM tipo;
        
/* SUBCONSULTAS CORRELACIONADAS. */
    --- Muestra el nombre de la composición, el número de movimientos, el tipo, el grupo y el nombre del autor. Muestra las que no han sido interpretadas.
    SELECT *
    FROM composiciones c
    WHERE movimientos = (SELECT MAX(movimientos)
                         FROM composiciones
                         WHERE nom_composicion = c.nom_composicion);
        
/* CONSULTA QUE INCLUYA VARIOS TIPOS DE LOS INDICADOS ANTERIORMENTE.*/
    ---Muestra la obra y la fecha de la interpretación realizada en el siglo XXI y que su código de interpretación comience por M y termine por 4.
    SELECT i.obra, i.fecha, i.cod_interpretacion
    FROM interpretacion i LEFT JOIN composiciones c ON c.nom_composicion = i.obra
    WHERE (i.fecha >='2000-01-01') AND i.cod_interpretacion = (SELECT cod_interpretacion
                                                                FROM interpretacion
                                                                WHERE cod_interpretacion ~ 'M.*4$');