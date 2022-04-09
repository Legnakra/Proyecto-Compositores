# Proyecto-Compositores

## Descripción
Debes crear un esquema relacional de una temática de tu interés con al menos 5 tablas, en mi caso, las he creado de composiciones clásicas interpretadas. 

## Tablas
A continuación mostraré las tablas que he construido en los sistemas de Oracle, MariaDB y PostgreSQL.

* La columna en *negrita* será clave primaria de la tabla.
* La columna en **cursiva** será clave foránea. 

### Compositores
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
|*nombre* | cadena de caracteres (30) | Mayúscula |
| --- | --- | --- |
| fecha_nacimiento | fecha | Entre 1500 y 1900 |
| fecha_muerte | fecha |  |
| epoca | cadenade caracteres (20) | Renacimiento,Barroco,Clásica,Romántica,Moderna |
| pais_nacimiento | cadena de caracteres (20) | No nulo |

### Composiciones
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| *nom_composición* | cadena de caracteres (70) |  |
| movimientos | numérico hasta 99 | Mayor de 1 |
| tipo | cadena de caracteres (40) | Mayúscula inicial |
| grupo | cadena de caracteres |Orquesta Sinfónica,Orquesta Solista,Orquesta Cámara |
| **nom_autor**  | cadena de caracteres (30) |   |

### Interpretación

| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| *cod_interpretación* | cadena de caracteres (5) | Inicial del compositor y los 4 últimos deben ser numéricos  |
| **obra**  | cadena de caracteres (70) | Por defecto 'Orquestal' |
| **interprete**  | cadena de caracteres (70) | Mayúscula inicial |
| **lugar_int** | cadena de caracteres (50) |   |
| fecha | fecha y hora | La hora debe ser entre las 18:00 y las 22:00 |

### Intérprete
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| *nom_interprete* | cadena de caracteres (70) |  |
| pais | cadena de caracteres (20) | No nulo |
| **tipo_comp** | cadena de caracteres (70) | Orquesta Sinfónica,Orquesta Solista,Orquesta Cámara |
| solista | cadena de caracteres (50) | Por defecto 'Nulo' |

### Lugar de interpretación
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| *lugar* | cadena de caracteres (50) |  |
| pais | cadena de caracteres (20) | No nulo |
| aforo | numérico hasta 99999 | Único |
| arquitecto | cadena de caracteres (50) | Mayúscula inicial |

## Enunciados

1. Añade la columna **director** en la tabla *Interpretación*, que sea una cadena de 30 caracteres.
2. Elimina la columna **movimientos** de la tabla *Composiciones*.
3. Modifica **nombre** en la tabla *Compositores* disminuyendo a 20 los caracteres de la cadena.
4. Añade una restricción a **aforo** en la tabla *Interpretación* para que el mínimo numérico sea 250.
5. Elimina la restricción sobre la columna **obra** en la tabla *Interpretación*.
6. Desactiva la restricción que afecta a **pais_nacimiento** de la tabla *Compositores*.



