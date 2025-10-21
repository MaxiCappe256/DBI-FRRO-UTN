-- Practica Nº 5: Subconsultas, Tablas Temporales y Variables
-- Practica en Clase: 1 – 2 – 3 – 4 – 7 – 9 – 10 – 11 – 12 – 16
-- Práctica Complementaria: 5 – 6 – 8 – 13 – 14 – 15 – 17
-- BASE DE DATOS: AGENCIA_PERSONAL


-- 1 )¿Qué personas fueron contratadas por las mismas empresas que Stefanía 
-- Lopez?
-- |dni |apellido |nombre|

SELECT per.dni, per.apellido, per.nombre
	FROM `agencia_personal`.`personas` per
    INNER JOIN `agencia_personal`.`contratos` con
		ON per.dni = con.dni
	INNER JOIN `agencia_personal`.`empresas` emp
		ON con.cuit = emp.cuit
	WHERE per.nombre = "Stefania" AND per.apellido = "Lopez";
		



-- 2) Encontrar a aquellos empleados que ganan menos que el máximo sueldo de 
-- los empleados de Viejos Amigos.
-- |dni |nombre y apellidos |sueldo



SELECT per.dni, CONCAT(per.nombre, " ", per.apellido), con.sueldo
	FROM `agencia_personal`.`contratos` con
        INNER JOIN `agencia_personal`.`empresas` emp ON con.cuit = emp.cuit
		INNER JOIN `agencia_personal`.`personas` per ON con.dni = per.dni
		WHERE con.sueldo < (
        SELECT MAX(con.sueldo)
		FROM `agencia_personal`.`contratos` con2
        INNER JOIN `agencia_personal`.`empresas` emp2 ON con2.cuit = emp2.cuit
		WHERE emp2.razon_social = "Viejos Amigos"
        );


-- 3) Mostrar empresas contratantes y sus promedios de comisiones pagadas o a pagar, pero sólo
-- de aquellas cuyo promedio supere al promedio de Tráigame eso.

-- cuit raxon_social avg(importe_comision)
SELECT emp.cuit, razon_social, AVG(importe_comision) "Promedio imp comision"	
	FROM `agencia_personal`.`comisiones` com
    INNER JOIN `agencia_personal`.`contratos` con
		ON com.nro_contrato = con.nro_contrato
	INNER JOIN `agencia_personal`.`empresas` emp
		ON con.cuit = emp.cuit
	GROUP BY emp.cuit
    HAVING AVG(importe_comision) > (
        
SELECT AVG(importe_comision)
	FROM `agencia_personal`.`comisiones` com
    INNER JOIN `agencia_personal`.`contratos` con
		ON com.nro_contrato = con.nro_contrato
	INNER JOIN `agencia_personal`.`empresas` emp
		ON con.cuit = emp.cuit
	WHERE razon_social = "Tráigame eso");
	
	


-- 4) Seleccionar las comisiones pagadas que tengan un importe menor al promedio 
-- de todas las comisiones(pagas y no pagas), mostrando razón social de la 
-- empresa contratante, mes contrato, año contrato , nro. contrato, nombre y 
-- apellido del empleado.

SELECT 
	emp.razon_social, 
    per.nombre,
    per.apellido,
    com.nro_contrato,
    com.mes_contrato,
    com.anio_contrato,
    com.importe_comision    
	FROM `agencia_personal`.`comisiones` com
    INNER JOIN `agencia_personal`.`contratos` con 
    ON com.nro_contrato = con.nro_contrato
    INNER JOIN `agencia_personal`.`empresas`emp
    ON con.cuit = emp.cuit
    INNER JOIN `agencia_personal`.`personas` per
    ON con.dni = per.dni
    WHERE com.fecha_pago IS NOT NULL AND fecha_pago < (
SELECT AVG(com2.importe_comision) promedio_comisiones
	FROM `agencia_personal`.`comisiones` com2
    INNER JOIN `agencia_personal`.`contratos` con2
    ON com2.nro_contrato = con2.nro_contrato
);
    
    
-- 5) Determinar las empresas que en promedio pagaron más comisiones 
-- que la comision promedio



-- 6) Seleccionar los empleados que no tengan educación no formal o terciario.
-- |apellido |nombre   |




-- 7) Mostrar los empleados cuyo salario supere al promedio de sueldo de la empresa que los
-- contrató.
-- |cuit |dni |sueldo |prom



-- 9 – 10 – 11 – 12 – 16
-- 9) Alumnos que se hayan inscripto a más cursos que Antoine de Saint-Exupery. Mostrar
-- todos los datos de los alumnos, la cantidad de cursos a la que se inscribió y cuantas
-- veces más que Antoine de Saint-Exupery.
-- |dni |nombre|apellido |direccion |email |te |count(*) count(*)- @cant)

SET @COUNT_ANTOINE = (
	SELECT COUNT(*)
    FROM `afatse`.`alumnos` alu
    INNER JOIN `afatse`.`inscripciones` ins
		ON alu.dni = ins.dni
	WHERE alu.nombre = "Antoine de" AND alu.apellido = "Saint-Exupery"
);


SELECT 
	alu.dni "dni",
    alu.nombre "nombre",
    alu.apellido "apellido",
    alu.direccion "direccion",
    alu.email "email",
    alu.tel "tel",
    COUNT(*),
    COUNT(*) - @COUNT_ANTOINE "diferencia"
	FROM `afatse`.`inscripciones` ins
    INNER JOIN `afatse`.`alumnos` alu
		ON ins.dni = alu.dni    
    GROUP BY alu.dni
    HAVING COUNT(*) > @COUNT_ANTOINE
    ;

-- 10) En el año 2014, qué cantidad de alumnos se han inscripto a los Planes de Capacitación
-- indicando para cada Plan de Capacitación la cantidad de alumnos inscriptos y el
-- porcentaje que representa respecto del total de inscriptos a los Planes de Capacitación
-- dictados en el año.

SET @CANT_ALUM_2014 = (
	SELECT COUNT(*) 
		FROM `afatse`.`inscripciones` ins
        INNER JOIN `afatse`.`plan_capacitacion` plc
			ON ins.nom_plan = plc.nom_plan
		WHERE YEAR(fecha_inscripcion) = 2014
);

SELECT @CANT_ALUM_2014;

SELECT 
	ins.nom_plan "nom_plan",
    COUNT(*),
    ROUND((COUNT(*) / @CANT_ALUM_2014) * 100, 2) "% Total"
	FROM `afatse`.`inscripciones` ins
        INNER JOIN `afatse`.`plan_capacitacion` plc
			ON ins.nom_plan = plc.nom_plan
		WHERE YEAR(fecha_inscripcion) = 2014
		GROUP BY ins.nom_plan;
        

-- 11) Indicar el valor actual de los planes de Capacitación
-- nom_plan | fecha_desde_plan | valor_plan

DROP TEMPORARY TABLE IF EXISTS tt_ult_fecha;

CREATE TEMPORARY TABLE tt_ult_fecha (
	SELECT nom_plan, MAX(fecha_desde_plan) "ult_fecha"
    FROM `afatse`.`valores_plan`
    GROUP BY nom_plan
);

DROP TEMPORARY TABLE tt_ult_fecha;

SELECT val.nom_plan,
	val.fecha_desde_plan,
    val.valor_plan
	FROM `afatse`.`valores_plan` val
    INNER JOIN `afatse`.`tt_ult_fecha` ult
		ON val.nom_plan = ult.nom_plan
	WHERE val.fecha_desde_plan = ult.ult_fecha;


-- 12) Plan de capacitacion mas barato. Indicar los datos del plan de capacitacion y el valor actual
-- nom_plan desc_plan hs modalidad valor_plan

SET @valor_mas_barato = (
	SELECT MIN(valor_plan) 
		FROM `afatse`.`valores_plan`
);

SELECT @valor_mas_barato;

SELECT val.nom_plan, cap.desc_plan, cap.hs, cap.modalidad, val.valor_plan
	FROM `afatse`.`valores_plan` val
    INNER JOIN `afatse`.`plan_capacitacion` cap
		ON val.nom_plan = cap.nom_plan
	WHERE val.valor_plan = @valor_mas_barato;
       
       
-- 13) ¿Qué instructores que han dictado algún curso del Plan de Capacitación “Marketing 1” el
-- año 2014 y no vayan a dictarlo este año? (año 2015)

SELECT ins.cuil 
	FROM `afatse`.`instructores` ins
    INNER JOIN `afatse`.`cursos_instructores` curins
		ON ins.cuil = curins.cuil
	INNER JOIN `afatse`.`cursos` cur
		ON curins.nom_plan = cur.nom_plan
	WHERE YEAR(cur.fecha_ini) = 2015 AND cur.nom_plan = "Marketing 1" AND cur.fecha_fin = 2014
    GROUP BY ins.cuil
    ;

-- 14) Alumnos que tengan todas sus cuotas pagas hasta la fecha.	
    
-- 15) Alumnos cuyo promedio supere al del curso que realizan. Mostrar dni, nombre y apellido,
-- promedio y promedio del curso.

DROP TEMPORARY TABLE IF EXISTS `afatse`.`tt_curso_promedio_notas`;

CREATE TEMPORARY TABLE `afatse`.`tt_curso_promedio_notas`
	SELECT 
    eva.nro_curso AS tt_nro_curso, 
    eva.nom_plan AS tt_nom_plan, 
    AVG(eva.nota) AS tt_prom_curso
		FROM `afatse`.`evaluaciones` eva
        INNER JOIN `afatse`.`alumnos` alu
			ON eva.dni = alu.dni
		GROUP BY eva.nro_curso, eva.nom_plan
		;
        
SELECT alu.dni, alu.nombre, alu.apellido, AVG(eva.nota) AS prom_alu, ttcpn.tt_prom_curso AS prom_curso
	FROM `afatse`.`alumnos` alu
	INNER JOIN `afatse`.`inscripciones` insc
		ON alu.dni = insc.dni
	INNER JOIN `afatse`.`evaluaciones` eva
		ON eva.nom_plan = insc.nom_plan AND eva.nro_curso = insc.nro_curso AND eva.dni = insc.dni
	INNER JOIN `afatse`.`tt_curso_promedio_notas` ttcpn
		ON ttcpn.tt_nom_plan = eva.nom_plan AND ttcpn.tt_nro_curso = eva.nro_curso
	GROUP BY alu.dni, alu.nombre, alu.apellido, ttcpn.tt_prom_curso
    HAVING AVG(eva.nota) > tt_prom_curso
    ORDER BY alu.nombre ASC;

DROP TEMPORARY TABLE `afatse`.`tt_curso_promedio_notas`;


-- 16)Para conocer la disponibilidad de lugar en los cursos que empiezan en abril 
-- para lanzar una campaña se desea conocer la cantidad de alumnos inscriptos a 
-- los cursos que comienzan a partir del 1/04/2014 indicando: Plan de 
-- Capacitación, curso, fecha de inicio, salón, cantidad de alumnos inscriptos 
-- y diferencia con el cupo de alumnos registrado para el curso que tengan al 
-- más del 80% de lugares disponibles respecto del cupo.
-- Ayuda: tener en cuenta el uso de los paréntesis y la precedencia de los 
-- operadores matemáticos.
-- nro_curso fecha_ini salon cupo count( dni ) ( cupo - count( dni ) )

DROP TEMPORARY TABLE IF EXISTS `afatse`.`tt_cant_alu_insc`;

CREATE TEMPORARY TABLE `afatse`.`tt_cant_alu_insc`
	SELECT 
        cur.nom_plan, 
        cur.nro_curso, 
        cur.fecha_ini,
		COUNT(dni) AS tt_count_dni
		FROM `afatse`.`cursos` cur
        LEFT JOIN `afatse`.`inscripciones` ins
			ON cur.nom_plan = ins.nom_plan 
            AND cur.nro_curso = ins.nro_curso
		WHERE cur.fecha_ini >= '2014-04-01'
        GROUP BY cur.nom_plan, cur.nro_curso, cur.fecha_ini;
    

SELECT 
	cur.nom_plan AS plan_capacitacion,
	cur.nro_curso,
    cur.fecha_ini,
    cur.salon,
    cur.cupo AS cupo,
    ttcai.tt_count_dni AS cant_insc,
    (cupo - ttcai.tt_count_dni) AS diferencia_con_cupo,
    (cupo - ttcai.tt_count_dni) / cur.cupo AS porcentaje_libre
    
		FROM `afatse`.`cursos` cur
		INNER JOIN `afatse`.`tt_cant_alu_insc` ttcai
			ON cur.nom_plan = ttcai.nom_plan 
				AND cur.nro_curso = ttcai.nro_curso 
				AND cur.fecha_ini = ttcai.fecha_ini
        HAVING porcentaje_libre > 0.8
        ORDER BY porcentaje_libre DESC;

DROP TEMPORARY TABLE `afatse`.`tt_cant_alu_insc`;

SELECT COUNT(dni) "cant ins", c.cupo "cupos" FROM `afatse`.`cursos` c
INNER JOIN `afatse`.`inscripciones` i
ON c.nom_plan = i.nom_plan AND c.nro_curso = i.nro_curso
GROUP BY c.cupo;