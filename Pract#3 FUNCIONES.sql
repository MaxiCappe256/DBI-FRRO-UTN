-- Práctica Nº 3: Funciones de presentación de datos
-- Practica Complementaria: 1 – 2 – 3 – 4 – 5
-- BASE DE DATOS: AGENCIA_PERSONAL

-- 1) Para aquellos contratos que no hayan terminado calcular la fecha de caducidad
-- como la fecha de solicitud más 30 días (no actualizar la base de datos). Función ADDDATE


-- 2) Mostrar los contratos. Indicar nombre y apellido de la persona, razón social de la
-- empresa fecha de inicio del contrato y fecha de caducidad del contrato. Si la fecha no ha
-- terminado mostrar “Contrato Vigente”. Función IFNULL



-- 3) Para aquellos contratos que terminaron antes de la fecha de finalización, indicar la
-- cantidad de días que finalizaron antes de tiempo. Función DATEDIFF



-- 4) Emitir un listado de comisiones impagas para cobrar. Indicar cuit, razón social de la
-- empresa y dirección, año y mes de la comisión, importe y la fecha de vencimiento que se
-- calcula como la fecha actual más dos meses. Función ADDDATE con INTERVAL



-- 5) Mostrar en qué día mes y año nacieron las personas (mostrarlos en columnas
-- separadas) y sus nombres y apellidos concatenados. Funciones DAY, YEAR, MONTH y CONCAT
