CREATE TABLE compositores (     
    nombre VARCHAR (30),
    fecha_nacimiento DATE,     
    fecha_muerte DATE,     
    epoca VARCHAR (20),     
    pais_nacimiento VARCHAR (20),     
    CONSTRAINT PK_nom PRIMARY KEY (nombre), 
    CONSTRAINT CK_fnac CHECK (fecha_nacimiento BETWEEN '1500-01-01' AND '1900-12-31'), 
    CONSTRAINT CK_epoca CHECK (upper(epoca) IN ('Renacimiento','Barroco','Clásica','Clasicismo','Romanticismo', 'Moderna')),     
    CONSTRAINT CK_nac CHECK (pais_nacimiento IS NOT NULL) 
    );

CREATE TABLE composiciones (
    nom_composicion VARCHAR (70),
    movimientos INT (2),
    tipo VARCHAR (40),
    grupo ENUM ('Orquesta sinfonica','Orquesta solista', 'Orquesta cámara'),
    nom_autor VARCHAR (30),
    CONSTRAINT PK_nomcomp PRIMARY KEY (nom_composicion),
    CONSTRAINT FK_nomautor FOREIGN KEY (nom_autor) REFERENCES compositores (nombre),
    CONSTRAINT CK_movimientos CHECK (movimientos >= 1),
    CONSTRAINT CK_tipo CHECK (CONCAT(UCASE(LEFT(tipo, 1))))
);
--------
CREATE TABLE interprete (
    nom_interprete VARCHAR (70),
    pais VARCHAR (20) NOT NULL,
    tipo_comp VARCHAR (40),
    solista VARCHAR (50) DEFAULT 'Nulo',
    CONSTRAINT PK_nomint PRIMARY KEY (nom_interprete),
    CONSTRAINT CK_tipo_comp CHECK (CONCAT(UCASE(LEFT(tipo_comp, 1)))),
--------
    CONSTRAINT FK_tipo_comp FOREIGN KEY (tipo_comp) REFERENCES composiciones (tipo)
);
--------

CREATE TABLE lugar_interpretacion (
    lugar VARCHAR (50),
    pais VARCHAR (20) NOT NULL,
    aforo INT (5) UNIQUE,
    arquitecto VARCHAR (50),
    CONSTRAINT PK_lugar PRIMARY KEY (lugar),
    CONSTRAINT CK_arquitecto CHECK (CONCAT(UCASE(LEFT(arquitecto, 1))))
    );

CREATE TABLE interpretacion (
    cod_interpretacion VARCHAR (5),
    obra VARCHAR (70),
    interprete VARCHAR (70),
    lugar_int VARCHAR (50),
    fecha DATE,
    CONSTRAINT PK_codint PRIMARY KEY (cod_interpretacion),
    CONSTRAINT FK_interp FOREIGN KEY (interprete) REFERENCES interprete (nom_interprete),
--------
    CONSTRAINT FK_lugar FOREIGN KEY (lugar_int) REFERENCES interpretacion (lugar),
    CONSTRAINT CK_obra CHECK obra DEFAULT 'Orquestal',
    CONSTRAINT CK_interp CHECK (CONCAT(UCASE(LEFT(interprete, 1)))),
    CONSTRAINT CK_hora CHECK (hora > TO_DATE(TO_CHAR(TRUNC)(hora), 'DD/MM/YYYY' || '18:00:00', 'DD/MM/YYYY HH24:MI:SS')) BETWEEN (hora < TO_DATE(TO_CHAR(TRUNC)(hora), 'DD/MM/YYYY' || '22:00:00', 'DD/MM/YYYY HH24:MI:SS'))
);

/* ENUNCIADOS */

/* 1.	Añade la columna director en la tabla Interpretación, que sea una cadena de 30 caracteres.*/
ALTER TABLE interpretacion ADD director VARCHAR (3);

/* 2.	Eliminar la columna Movimientos de la tabla Composiciones.*/
ALTER TABLE composiciones DROP movimientos;

/* 3.	Modificar nombre en la tabla Compositores disminuyendo a 20 los caracteres de la cadena.*/


/* 4.	Añadir una restricción a Aforo en la tabla Interpretación para que el mínimo sea 250. */
ALTER TABLE lugar_interpretacion ADD CONSTRAINT CK_minimo CHECK (aforo > 250);

/* 5.	Eliminar la restricción sobre la columna Obra de la tabla Interpretación.*/


/* 6.	Desactivar la restricción que afecta a País_nacimiento de la tabla Compositores.*/

/* INSERTS */

    /* Tabla compositores */
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Mozart', '1756-01-27', '1791-12-05' ,'Clasicismo', 'Alemania');
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Chopin','1849-10-17', '1849-10-17' ,'Romanticismo', 'Polonia');
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Bach','1685-03-31', '1750-07-28','Barroco', 'Alemania');
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Monteverdi','1567-05-09', '1643-11-29','Barroco', 'Italia');
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Beethoven','1770-12-26', '1827-03-26','Clasicismo','Alemania');
INSERT INTO compositores (nombre, fecha_nacimiento,fecha_muerte,epoca,pais_nacimiento) values ('Wagner','1813-05-22', '1883-02-13','Romanticismo','Alemania');

    /* Tabla composiciones */
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto para violin n3 en Sol M',3,'Orquesta Sinfonica y solista','Orquesta solista','Mozart');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Sonata para teclado a cuatro manos','3','Sonata','Duo','Mozart');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('El rapto del serrallo','3','Opera','Orquesta Sinfónica y Vocalista','Mozart');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Nocturnos Opus 9','21','Nocturnos','Instrumental','Chopin');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto para piano n2 en Fa M','3','Concierto','Orquesta Sinfónica y solista','Chopin');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Sonata para Cello en Sol m Opus 65','4','Sonata','Orquesta Sinfónica y solista','Chopin');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Pasión Según San Juan','40','Oratorio','Orquesta Sinfónica','Bach');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto de Brandemburgo','3','Concierto','Orquesta de Cámara','Bach');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto para 2 violines','3','Concierto','Concierto Solista','Bach');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Las fábulas de Orfeo','5','Opera','Orquesta Sinfónica','Monteverdi');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Selva morale e spirituale','4','Misa','Orquesta Sinfónica','Monteverdi');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('El regreso de Ulises a la patria','5','Opera','Orquesta Sinfónica','Monteverdi');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Sinfonía nº 5','4','Sinfonía','Orquesta Sinfónica','Beethoven');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Marcha turca','1','Danza','Orquesta Sinfónica','Beethoven');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto para violín','4','Concierto','Orquesta solista','Beethoven');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Cabalgata de las Valquirias','32','Opera','Orquesta Sinfónica','Wagner');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('El holandés errante','15','Opera','Orquesta Sinfónica','Wagner');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Tristán e Isolda','37','Opera','Orquesta Sinfónica','Wagner');

    /* Tabla interprete */
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta Sajona de Dresde','Alemania','Orquesta Sinfónica y solista','Hilary Hahn');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta Sinfónica de Chicago','Estados Unidos','Orquesta Sinfónica','Nulo');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta filarmónica de Berlín','Alemania','Orquesta Sinfónica','Nulo');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta Filarmónica de Viena','Austria','Orquesta Sinfónica y Vocalista','Nulo');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta de Cleveland','Estados Unidos','Orquesta Sinfónica','Nulo');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta Filarmónica de Madrid','España','Orquesta de Cámara','Nulo');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta Sinfónica de Londres','Inglaterra','Orquesta Sinfónica y Vocalista','Nulo');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta Filarmónica de Nueva York','Estados Unidos','Orquesta Sinfónica','Nulo');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Real Orquesta del Concertgebouv','Paises Bajos','Duo','Nulo');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta Filarmónica de Panamá','Panamá','Orquesta Sinfónica','Nulo');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta Filarmónica de Sant Petesburgo','Rusia','Orquesta Sinfónica y solista','Nulo');
INSERT INTO interpretes (nom_interprete,pais,tipo_comp,solista) values ('Orquesta Sinfónica de Boston','Estados Unidos','Orquesta de Cámara','Nulo');

    /* Tabla lugar_interpretacion */
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Teatro de la Maestranza','España','1800','Aurelio del Pozo');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Ópera de Sidney','Australia','1547','Jorn Utzon');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Teatro Colón','Argentina','2487','Francesco Tamburini');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Teatro de la Scala','Italia','2030','Arturo Toscanini');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Ópera Garnier','Francia','1979','Odile Deqc');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Ópera Estatal de Viena','Austria','1709','Eduard van der Nüll');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Royal Ópera House','Inglaterra','2268','Edward Middleton Barry');

    /* Tabla interpretación */
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('M1111','Sonata para teclado a cuatro manos','Real Orquesta del Concertgebouv','Teatro de la Scala','2019-11-25 19:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('C1111','Sonata para Cello en Sol m Opus 65','Orquesta Filarmónica de Sant Petesburgo','Ópera Garnier','1992-02-17 18:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('B1111','Concierto de Brandemburgo','Orquesta Filarmónica de Madrid','Ópera Estatal de Viena','1983-07-06 21:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('M1112','Tristán e Isolda','Orquesta de Cleveland','Ópera de Sidney','2002-08-21 18:30:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('B1112','Sinfonía nº 5','Orquesta filarmónica de Berlín','Ópera Garnier','1894-01-01 21:30:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('W1111','Concierto de Brandemburgo','Orquesta Filarmónica de Madrid','Teatro de la Maestranza','2015-12-31 18:45:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('M1112','Concierto para violin n3 en Sol M','Orquesta Sajona de Dresde','Teatro Colón','1997-06-24 21:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('C1113','Tristán e Isolda','Orquesta filarmónica de Berlín','Royal Ópera House','1989-09-18 20:40:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('B1113','El rapto del serrallo','Orquesta Filarmónica de Viena','Teatro de la Maestranza','1981-03-03 18:45:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('M1114','El rapto del serrallo','Orquesta Sinfónica de Londres','Teatro de la Scala','2020-02-14 19:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('B1114','Concierto de Brandemburgo','Orquesta Sinfónica de Boston','Ópera de Sidney','2021-08-15 21:45:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_interpretacion,fecha) values ('W1112','Tristán e Isolda','Orquesta Sinfónica de Chicago','Ópera Estatal de Viena','2000-05-13 19:30:00');