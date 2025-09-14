-- PRACTICA SQL 1TUP1 2025

-- Practica en Clase: 1 – 3 – 4 – 6 – 7 – 11
-- Práctica Complementaria: 2 – 5 – 8 – 9 – 10 – 12 – 14


-- 1) Mostrar la estructura de la tabla Empresas. Seleccionar toda la información de la misma.


-- 3) Guardar el siguiente query en un archivo de extensión .sql, para luego correrlo.
-- Mostrar los títulos con el formato de columna: Código Descripción y Tipo ordenarlo
-- alfabéticamente por descripción.

SELECT cod_titulo "Código", desc_titulo "Descripción", tipo_titulo "Tipo" 
FROM titulos order by desc_titulo;

SELECT * FROM titulos 
INTO OUTFILE 'C:\\Users\\Cristián\\Downloads\\titulos.txt'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';

-- Error Code: 1290. The MySQL server is running with the --secure-file-priv option so it cannot execute this statement
-- indica que MySQL está configurado para permitir la exportación de archivos solo a un directorio específico por 
-- razones de seguridad. Este comportamiento está controlado por la opción --secure-file-priv, que restringe las 
-- operaciones de importación y exportación a una carpeta definida en la configuración de MySQL.
-- veamos donde se pueden escribir estos archivos...
SHOW VARIABLES LIKE 'secure_file_priv';

SELECT * FROM titulos 
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\titulos.txt'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';


-- 4) Mostrar de la persona con DNI nro. 28675888, nombre y apellido, fecha de
-- nacimiento, teléfono y su dirección.
-- Las cabeceras de las columnas serán:
-- |Apellido y Nombre (concatenados)  |Fecha Nac.|Teléfono  |Dirección               |


-- 6) Mostrar las personas cuyo apellido empiece con la letra ‘G’.

-- 7) Mostrar el nombre, apellido y fecha de nacimiento de las personas nacidas entre 1980 y 2000

-- 11) Mostrar los contratos cuyo salario sea mayor que 2000 y trabajen en las empresas 30-10504876-5 o 30-21098732-4.
-- Rotule el encabezado:
-- |Nro Contrato                |DNI             |Salario           |CUIL               |
