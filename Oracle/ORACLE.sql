/* TABLAS */


CREATE TABLE compositores (
    nombre VARCHAR2 (30),
    fecha_nacimiento DATE,
    fecha_muerte (DATE),
    epoca VARCHAR2 (20),
    pais_naciemnto VARCHAR2 (20),
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