# Proyecto-Compositores

## Descripción
Debes crear un esquema relacional de una temática de tu interés con al menos 5 tablas, en mi caso, las he creado de composiciones clásicas interpretadas. 

## Tablas
A continuación mostraré las tablas que he construido en los sistemas de Oracle, MariaDB y PostgreSQL.

* La columna en **negrita** será clave primaria de la tabla.
* La columna en *cursiva* será clave foránea. 

### Compositores
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| **nombre** | cadena de caracteres (30) | Mayúscula 
| fecha_nacimiento | fecha | Entre 1500 y 1900 
| fecha_muerte | fecha |  |
| epoca | cadenade caracteres (20) | Renacimiento,Barroco,Clásica,Romántica,Moderna |
| pais_nacimiento | cadena de caracteres (20) | No nulo |

### Tipo
| Columna | tipo de dato | Restriccion |
| --- | --- | --- |
| **nom_tipo** | cadena de caracteres (40) | Mayúscula inicial | 
| descripcion | cadena de caracteres (70) |  |

### Composiciones
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| **nom_composición** | cadena de caracteres (70) |  |
| movimientos | numérico hasta 99 | Mayor de 1 |
| tipo | cadena de caracteres (40) | Mayúscula inicial |
| grupo | cadena de caracteres | Orquesta Sinfónica,Orquesta Solista,Orquesta Cámara |
| *nom_autor* | cadena de caracteres (30) |   |

### Interpretación

| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| **cod_interpretación** | cadena de caracteres (5) | Inicial del compositor y los 4 últimos deben ser numéricos  |
| *obra* | cadena de caracteres (70) | Por defecto 'Orquestal' |
| *interprete* | cadena de caracteres (70) | Mayúscula inicial |
| *lugar_int* | cadena de caracteres (50) |   |
| fecha | fecha y hora | La hora debe ser entre las 18:00 y las 22:00 |

### Intérprete
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| **nom_interprete** | cadena de caracteres (70) | Mayúscula inicial |
| pais | cadena de caracteres (20) | No nulo |
| solista | cadena de caracteres (50) | Por defecto 'Nulo' |

### Lugar de interpretación
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| **lugar** | cadena de caracteres (50) |  |
| pais | cadena de caracteres (20) | No nulo |
| aforo | numérico hasta 99999 | Único |
| arquitecto | cadena de caracteres (50) | Mayúscula inicial |

## Enunciados

1. Añade la columna *director* en la tabla **Interpretación**, que sea una cadena de 30 caracteres.
2. Elimina la columna *movimientos* de la tabla **Composiciones**.
3. Modifica *nombre* en la tabla **Compositores** disminuyendo a 20 los caracteres de la cadena.
4. Añade una restricción a *aforo* en la tabla **Interpretación** para que el mínimo numérico sea 250.
5. Elimina la restricción sobre la columna *obra* en la tabla **Interpretación**.
6. Desactiva la restricción que afecta a *pais_nacimiento* de la tabla **Compositores**.

## Consultas

* Consulta sencilla
	* Muestra los compositores nacidos después del año 1813.
	* Muestra el nombre de las obras cuyo tipo es 'Concierto'. 
* Vistas
	* Muestra el nombre de las obras,su compositor, y su época, ordenados por número de movimientos.
* Subconsultas
	* Obtiene el nombre y el país de los lugares donde se ha interpretado 'Concierto de Brandemburgo'.
	* Muestra las obras de Beethoven que han sido interpretadas en Francia.
* Combinaciones de tablas.
	* Muestra un listado con los compositores, la época y el número total de obras de cada que existen en la base de datos.
	* Muestra el país en los que se ha interpretado 'El rapto del serrallo'.
* Inserción de registros. Consulta de datos anexados.
	* Crear una tabla llamada Monteverdi (PIEZA, MOV, EP), con el mismo tipo y tamaño de las ya existentes. Insertar en la tabla el nombre de la pieza sea 'Nocturnos Opus 9' que está en la tabla composiciones, el número de movimientos sea igual que 'Marcha turca' y la época de las obra de Monteverdi mediante una consulta de datos anexados.
* Modificación de registros. Consulta de actualización.
	* Actualizar el número de movimientos de la Pasión Según San Juan a 47 movimientos.
	* Crear una columna llamada total_interpretaciones en la tabla composiciones, donde se incluya el número de veces que ha sido interpretada una obra.
* Borrado de registros. Consulta de eliminación.
	* Borrar registros de 'Tristán e Isdolda' de la tabla interpretación.
* Group by y having.
	* Muestra el nombre de los autores y sus obras con mayor número de movimientos, siendo menores a 50, y con menor número de movimientos, siendo inferior de 5, ordenados por el nombre del autor.
* Outer joins. Combinaciones externas.
	* Muestra el nombre de la obra, la fecha y el código de las interpretaciones de forma posterior al 5 de mayo de 2000.
	* Muestra el nombre de la obra, el nombre del autor y las veces que ha sido interpretada dicha obra.
* Consultas con operadores conjuntos.
	* Consulta el tipo de composición con su descripción y los tipos de composiciones con el nombre de las mismas y las anexionamos.
* Subconsulta corelacionada.
	* Muestra el nombre de la composición, el número de movimientos, el tipo, el grupo y el nobre del autor.
* Consulta que incluya varios tipos de los ya empleados anteriormente.
	* Muestra las obras, la fecha de la interpretación y el código de las interpretaciones cuyo código comiente por M y hayan sido realizadas en el S.XXI.

## Autora :computer:
* María Jesús Alloza Rodríguez
* :school:I.E.S. Gonzalo Nazareno :round_pushpin:(Dos Hermanas, Sevilla).
