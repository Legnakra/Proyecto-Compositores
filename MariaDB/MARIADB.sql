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

CREATE TABLE tipo (
    nom_tipo VARCHAR (40),
    descripcion VARCHAR (70),
    CONSTRAINT PK_nom PRIMARY KEY (nom_tipo),
    CONSTRAINT CK_tipo CHECK (CONCAT(UCASE(LEFT(nom_tipo, 1))))
);

CREATE TABLE composiciones (
    nom_composicion VARCHAR (70),
    movimientos INT (2),
    tipo VARCHAR (40),
    grupo ENUM ('Orquesta sinfonica','Orquesta solista', 'Orquesta cámara'),
    nom_autor VARCHAR (30),
    CONSTRAINT PK_nomcomp PRIMARY KEY (nom_composicion),
    CONSTRAINT FK_nomautor FOREIGN KEY (nom_autor) REFERENCES compositores (nombre),
    CONSTRAINT FK_composicion FOREIGN KEY (tipo) REFERENCES tipo (nom_tipo),
    CONSTRAINT CK_movimientos CHECK (movimientos >= 1),
    CONSTRAINT CK_tipo CHECK (CONCAT(UCASE(LEFT(tipo, 1))))
);

CREATE TABLE interprete (
    nom_interprete VARCHAR (70),
    pais VARCHAR (20) NOT NULL,
    solista VARCHAR (50) DEFAULT 'Nulo',
    CONSTRAINT PK_nomint PRIMARY KEY (nom_interprete)
);

CREATE TABLE lugar_interpretacion (
    lugar VARCHAR (50),
    pais VARCHAR (20) NOT NULL,
    aforo INT (5) UNIQUE,
    arquitecto VARCHAR (50),
    CONSTRAINT PK_lugar PRIMARY KEY (lugar),
    CONSTRAINT CK_arquitecto CHECK (CONCAT(UCASE(LEFT(arquitecto, 1))))
    );

---> Mariadb no posee restricciones en DATETIME, por lo que crearé una constraint que englobe el rango de horas de inicio de la interpretación.
CREATE TABLE interpretacion (
    cod_interpretacion VARCHAR (5),
    obra VARCHAR (70) DEFAULT 'Orquestal',
    interprete VARCHAR (70),
    lugar_int VARCHAR (50),
    fecha DATETIME,
    CONSTRAINT PK_codint PRIMARY KEY (cod_interpretacion),
    CONSTRAINT FK_interp FOREIGN KEY (interprete) REFERENCES interprete (nom_interprete),
    CONSTRAINT FK_obra FOREIGN KEY (obra) REFERENCES composiciones (nom_composicion),
    CONSTRAINT FK_lugar FOREIGN KEY (lugar_int) REFERENCES lugar_interpretacion (lugar),
    CONSTRAINT CK_hora_inicio CHECK ((TIME_FORMAT(fecha, '%H') >= '18') AND (TIME_FORMAT(fecha, '%H') <= '22'))
);

/* ENUNCIADOS */

/* 1.	Añade la columna director en la tabla Interpretación, que sea una cadena de 30 caracteres.*/
ALTER TABLE interpretacion ADD director VARCHAR (3);

/* 2.	Eliminar la columna Movimientos de la tabla Composiciones.*/
ALTER TABLE composiciones DROP movimientos;

/* 3.	Modificar pais_nacimiento en la tabla Compositores incrementado a 30 los caracteres de la cadena.*/
ALTER TABLE compositores MODIFY pais_nacimiento VARCHAR (30);

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
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto para violin n3 en Sol M',3,'Concierto','Orquesta solista','Mozart');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('La flauta mágica','42','Opera','Orquesta Sinfonica','Mozart');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('El rapto del serrallo','3','Opera','Orquesta Sinfonica y Vocalista','Mozart');
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
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Sinfonía nº 5','4','Sinfonía','Orquesta Sinfónica','Beethoven');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Marcha turca','1','Danza','Orquesta Sinfónica','Beethoven');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Concierto para violín','4','Concierto','Orquesta solista','Beethoven');
---
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Cabalgata de las Valquirias','32','Opera','Orquesta Sinfónica','Wagner');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('El holandés errante','15','Opera','Orquesta Sinfónica','Wagner');
INSERT INTO composiciones (nom_composicion,movimientos,tipo,grupo,nom_autor) values ('Tristán e Isolda','37','Opera','Orquesta Sinfónica','Wagner');

    /* Tabla interprete */
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Sajona de Dresde','Alemania','Hilary Hahn');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Sinfónica de Chicago','Estados Unidos','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica de Berlín','Alemania','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica de Viena','Austria','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta de Cleveland','Estados Unidos','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica de Madrid','España','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Sinfónica de Londres','Inglaterra','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica de Nueva York','Estados Unidos','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Real Orquesta del Concertgebouv','Paises Bajos','Duo','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica de Panamá','Panamá','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Filarmónica de Sant Petesburgo','Rusia','Nulo');
INSERT INTO interprete (nom_interprete,pais,solista) values ('Orquesta Sinfónica de Boston','Estados Unidos','Nulo');

    /* Tabla lugar_interpretacion */
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Teatro de la Maestranza','España','1800','Aurelio del Pozo');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Ópera de Sidney','Australia','1547','Jorn Utzon');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Teatro Colón','Argentina','2487','Francesco Tamburini');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Teatro de la Scala','Italia','2030','Arturo Toscanini');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Ópera Garnier','Francia','1979','Odile Deqc');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Ópera Estatal de Viena','Austria','1709','Eduard van der Nüll');
INSERT INTO lugar_interpretacion (lugar,pais,aforo,arquitecto) values ('Royal Ópera House','Inglaterra','2268','Edward Middleton Barry');

    /* Tabla interpretación */
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('M1111','La flauta mágica','Real Orquesta del Concertgebouv','Teatro de la Scala','2019-12-25 19:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('C1111','Sonata para Cello en Sol m Opus 65','Orquesta Filarmónica de Sant Petesburgo','Ópera Garnier','1992-02-17 18:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('B1111','Concierto de Brandemburgo','Orquesta Filarmónica de Madrid','Ópera Estatal de Viena','1983-07-06 21:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('M1112','Tristán e Isolda','Orquesta de Cleveland','Ópera de Sidney','2002-08-21 18:30:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('B1112','Sinfonía nº 5','Orquesta filarmónica de Berlín','Ópera Garnier','1894-01-01 21:30:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('W1111','Concierto de Brandemburgo','Orquesta Filarmónica de Madrid','Teatro de la Maestranza','2015-12-31 18:45:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('M1112','Concierto para violin n3 en Sol M','Orquesta Sajona de Dresde','Teatro Colón','1997-06-24 21:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('C1113','Tristán e Isolda','Orquesta filarmónica de Berlín','Royal Ópera House','1989-09-18 20:40:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('B1113','El rapto del serrallo','Orquesta Filarmónica de Viena','Teatro de la Maestranza','1981-03-03 18:45:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('M1114','El rapto del serrallo','Orquesta Sinfónica de Londres','Teatro de la Scala','2020-02-14 19:00:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('B1114','Concierto de Brandemburgo','Orquesta Sinfónica de Boston','Ópera de Sidney','2021-08-15 21:45:00');
INSERT INTO interpretacion (cod_interpretacion,obra,interprete,lugar_int,fecha) values ('W1112','Tristán e Isolda','Orquesta Sinfónica de Chicago','Ópera Estatal de Viena','2000-05-13 19:30:00');