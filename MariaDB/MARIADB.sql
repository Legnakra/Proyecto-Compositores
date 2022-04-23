CREATE TABLE compositores (     
    nombre VARCHAR (30),
    fecha_nacimiento DATE,     
    fecha_muerte DATE,     
    epoca VARCHAR (20),     
    pais_nacimiento VARCHAR (20),     
    CONSTRAINT PK_nom PRIMARY KEY (nombre), 
    CONSTRAINT CK_fnac CHECK (fecha_nacimiento BETWEEN '1500-01-01' AND '1900-12-31'), 
    CONSTRAINT CK_epoca CHECK (upper(epoca) IN ('Renacimiento','Barroco','Clásica','Clásica','Romántica', 'Moderna')),     
    CONSTRAINT CK_nac CHECK (pais_nacimiento IS NOT NULL) 
    );

CREATE TABLE composiciones (
    nom_composicion VARCHAR (70),
    movimientos INT (2),
    tipo VARCHAR (40),
    grupo ENUM ('Orquesta sinfónica','Orquesta solista', 'Orquesta cámara'),
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
    CONSTRAINT FK_tipo_comp FOREIGN KEY (tipo_comp) REFERENCES composiciones (tipo)
);
--------

CREATE TABLE lugar_interpretacion (
    lugar VARCHAR (50),
    pais VARCHAR (20) NOT NULL,
    aforo INT (5) UNIQUE,
    arquitecto VARCHAR (50),
    CONSTRAINT PK_lugar PRIMARY KEY (lugar),
    CONSTRAINT CK_arquitecto (CONCAT(UCASE(LEFT(arquitecto, 1))))
    );