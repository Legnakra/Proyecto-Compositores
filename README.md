# Proyecto-Compositores

## Descripción
Debes crear un esquema relacional de una temática de tu interés con al menos 5 tablas, en mi caso, las he creado de composiciones clásicas interpretadas. 

## #Tablas

### Compositores
| Columna | tipo de dato | Restricción |
| --- | --- | --- |
| nombre | cadena de caracteres (30) | Mayúscula |
| fecha_nacimiento | fecha | Entre 1500 y 1900 |
| fecha_muerte | fecha |  |
| epoca | cadenade caracteres | 'Renacimiento','Barroco','Clásica','Romántica','Moderna' |
| pais_nacimiento | cadena de caracteres | No nulo |
