-- PRACTICA SQL 1TUP1 2025

-- Practica en Clase: 1 – 3 – 4 – 6 – 7 – 11
-- Práctica Complementaria: 2 – 5 – 8 – 9 – 10 – 12 – 14

USE `agencia_personal`;

-- 1) Mostrar la estructura de la tabla Empresas. Seleccionar toda la información de la misma.
DESCRIBE `agencia_personal`.`empresas`;

-- otra manera
USE `information_schema`;
select * from columns where table_schema='agencia_personal' and table_name="empresas";

-- comentarios 
# comentarios

SELECT * FROM `agencia_personal`.`empresas`;
SELECT cuit, razon_social FROM `agencia_personal`.`empresas`;


-- 3) Guardar el siguiente query en un archivo de extensión .sql, para luego correrlo.
-- Mostrar los títulos con el formato de columna: Código Descripción y Tipo ordenarlo
-- alfabéticamente por descripción.
-- Alias "Código" representación del atributo // nombre del encabezado
SELECT cod_titulo AS "Código", desc_titulo "Descripción", tipo_titulo "Tipo" 
FROM `agencia_personal`.`titulos` order by desc_titulo;

SELECT * FROM `agencia_personal`.`titulos` 
INTO OUTFILE 'C:\\Users\\Cristián\\Downloads\\titulos.sql'
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

-- "1","Tecnico Electronico","Secundario"
-- "2","Diseñador de Interiores","Terciario"
-- "3","Tecnico Mecanico","Secundario"
-- "4","Payaso de Circo","Educacion no formal"
-- "5","Arquitecto","Universitario"
-- "6","Entrenado de Lemures","Educacion no formal"
-- "7","Ing en Sist de Inf","Universitario"
-- "8","Bachiller","Secundario"

-- 4) Mostrar de la persona con DNI nro. 28675888, nombre y apellido, fecha de
-- nacimiento, teléfono y su dirección.
-- Las cabeceras de las columnas serán:
-- |Apellido y Nombre (concatenados)  |Fecha Nac.|Teléfono  |Dirección               |
SELECT CONCAT(apellido, ", ", nombre) "Apellido y Nombre", 
	DATE_FORMAT(fecha_nacimiento, "%d/%m/%Y") "Fecha Nac.",   -- por defecto en sql "YYYY-MM-DD"
    Telefono "Teléfono", 
    direccion "Dirección" 
    FROM `agencia_personal`.`personas`
	WHERE dni="28675888";

-- 6) Mostrar las personas cuyo apellido empiece con la letra ‘G’.
-- |Apellido y Nombre (concatenados)|Fecha Nac. |Teléfono |Dirección|
SELECT CONCAT(apellido, ", ", nombre) "Apellido y Nombre", 
	DATE_FORMAT(fecha_nacimiento, "%d/%m/%Y") "Fecha Nac.",   -- por defecto en sql "YYYY-MM-DD"
    Telefono "Teléfono", 
    direccion "Dirección" 
    FROM `agencia_personal`.`personas`
	WHERE apellido LIKE "G%";

-- 7) Mostrar el nombre, apellido y fecha de nacimiento de las personas nacidas entre 1980 y 2000
SELECT nombre, apellido, 
	DATE_FORMAT(fecha_nacimiento, "%d/%m/%Y") "Fecha Nac."
	FROM `agencia_personal`.`personas`
	WHERE `fecha_nacimiento` BETWEEN "1980-01-01" AND "2000-12-31";

-- 11) Mostrar los contratos cuyo salario sea mayor que 2000 y trabajen en las empresas 30-10504876-5 o 30-21098732-4.
-- Rotule el encabezado:
-- |Nro Contrato                |DNI             |Salario           |CUIT              |
SELECT nro_contrato "Nro Contrato", 
	dni "DNI", 
	TRUNCATE(sueldo, 2) "Salario",
    cuit "CUIT"     
	FROM `agencia_personal`.`contratos`
    WHERE sueldo > 2000 and (cuit = "30-10504876-5" OR  cuit="30-21098732-4");

SELECT TRUNCATE(3.456, 2);  -- 3.45
SELECT ROUND(3.456, 2);  -- 3.46
SELECT CEIL(3.456);  -- 4 TECHO 
SELECT FLOOR(3.456);  -- 3 PISO 









