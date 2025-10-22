-- Practica Nº 4: GROUP BY - HAVING
-- Practica en Clase: 1 – 2 – 4 – 8 – 9 – 13 – 14 – 15
-- Práctica Complementaria: 3 – 5 – 6 – 7 – 10 – 11 – 12
-- BASE DE DATOS: AGENCIA_PERSONAL

-- **1) Mostrar las comisiones pagadas por la empresa Tráigame eso
	
SELECT *
	FROM `agencia_personal`.``














SELECT razon_social "razon_social", sum( importe_comision ) "Comisiones Pagas"
	FROM `agencia_personal`.`empresas` E
		INNER JOIN `agencia_personal`.`solicitudes_empresas` SE 
			ON E.cuit=SE.cuit
		INNER JOIN `agencia_personal`.`contratos` C 	
			ON SE.cuit=C.cuit and SE.cod_cargo=C.cod_cargo and SE.fecha_solicitud=C.fecha_solicitud
        INNER JOIN `agencia_personal`.`comisiones` COM 
			ON C.nro_contrato=COM.nro_contrato
	WHERE razon_social="Tráigame eso" and fecha_pago IS NOT NULL ;

-- **2) Ídem 1) pero para todas las empresas.
SELECT razon_social "razon_social", sum( importe_comision ) "Comisiones Pagas"
	FROM `agencia_personal`.`empresas` E
		INNER JOIN `agencia_personal`.`solicitudes_empresas` SE 
			ON E.cuit=SE.cuit
		INNER JOIN `agencia_personal`.`contratos` C 	
			ON SE.cuit=C.cuit and SE.cod_cargo=C.cod_cargo and SE.fecha_solicitud=C.fecha_solicitud
        INNER JOIN `agencia_personal`.`comisiones` COM 
			ON C.nro_contrato=COM.nro_contrato
	WHERE fecha_pago IS NOT NULL
    GROUP BY E.cuit, E.razon_social;
    
-- 3) Mostrar el promedio, desviación estándar y varianza del puntaje de las
-- evaluaciones de entrevistas, por tipo de evaluación y entrevistador. 
-- Ordenar por promedio en forma ascendente y luego por desviación estándar en forma descendente.
-- nombre_entrevistador cod_evaluacion AVG( resul tado ) STD( resultad o ) variance(resultado)
SELECT nombre_entrevistador, desc_evaluacion, 
	AVG(EE.resultado) "Promedio",
	STD(EE.resultado) "Desvío estandar",
	VARIANCE(EE.resultado) "Varianza"
	FROM `agencia_personal`.`entrevistas` E
		INNER JOIN `agencia_personal`.`entrevistas_evaluaciones` EE 
			ON E.nro_entrevista=EE.nro_entrevista
		INNER JOIN `agencia_personal`.`evaluaciones`EVAL
			ON EE.cod_evaluacion=EVAL.cod_evaluacion
	GROUP BY nombre_entrevistador, EE.cod_evaluacion
    ORDER BY AVG(EE.resultado), STD(EE.resultado) DESC;


-- **4) Ídem 3) pero para Angélica Doria, con promedio mayor a 71. Ordenar por código
-- de evaluación.
SELECT nombre_entrevistador, desc_evaluacion, 
	AVG(EE.resultado) "Promedio",
	STD(EE.resultado) "Desvío estandar",
	VARIANCE(EE.resultado) "Varianza"
	FROM `agencia_personal`.`entrevistas` E
		INNER JOIN `agencia_personal`.`entrevistas_evaluaciones` EE 
			ON E.nro_entrevista=EE.nro_entrevista
		INNER JOIN `agencia_personal`.`evaluaciones`EVAL
			ON EE.cod_evaluacion=EVAL.cod_evaluacion
	WHERE nombre_entrevistador="Angélica Doria"
	GROUP BY nombre_entrevistador, EE.cod_evaluacion
    HAVING AVG(EE.resultado)>71
    ORDER BY AVG(EE.resultado), STD(EE.resultado) DESC;

-- 5) Cuantas entrevistas fueron hechas por cada entrevistador en octubre de 2014.

SELECT
  nombre_entrevistador,
  COUNT(*) AS `Cantidad de Entrevistas`
FROM entrevistas
WHERE fecha_entrevista >= '2014-10-01'
  AND fecha_entrevista <  '2014-11-01'
GROUP BY nombre_entrevistador
ORDER BY nombre_entrevistador;









-- 6) Ídem 4) pero para todos los entrevistadores. Mostrar nombre y cantidad.
-- Ordenado por cantidad de entrevistas.
SELECT nombre_entrevistador, desc_evaluacion, count(*) "Cantidad",
	AVG(EE.resultado) "Promedio",
	STD(EE.resultado) "Desvío estandar",
	VARIANCE(EE.resultado) "Varianza"
	FROM `agencia_personal`.`entrevistas` E
		INNER JOIN `agencia_personal`.`entrevistas_evaluaciones` EE 
			ON E.nro_entrevista=EE.nro_entrevista
		INNER JOIN `agencia_personal`.`evaluaciones`EVAL
			ON EE.cod_evaluacion=EVAL.cod_evaluacion
	# WHERE nombre_entrevistador="Angélica Doria"
	GROUP BY nombre_entrevistador, EE.cod_evaluacion
    HAVING AVG(EE.resultado) > 71
    ORDER BY count(*) ASC;  # DESC

-- 7) Ídem 6) para aquellos cuya cantidad de entrevistas por código de evaluación
-- sea mayor que 1. Ordenado por nombre en forma descendente y por código de
-- evaluación en forma ascendente
SELECT nombre_entrevistador, desc_evaluacion, count(*) "Cantidad",
	AVG(EE.resultado) "Promedio", STD(EE.resultado) "Desvío estandar", VARIANCE(EE.resultado) "Varianza"
	FROM `agencia_personal`.`entrevistas` E
		INNER JOIN `agencia_personal`.`entrevistas_evaluaciones` EE 
			ON E.nro_entrevista=EE.nro_entrevista
		INNER JOIN `agencia_personal`.`evaluaciones`EVAL
			ON EE.cod_evaluacion=EVAL.cod_evaluacion
	# WHERE COUNT(cod_evaluacion) > 1  <-- no confundir where/having, las funciones de agregación para evaluar los grupos van en el having ,acá están mal
    GROUP BY EE.cod_evaluacion, nombre_entrevistador
    HAVING COUNT(*) > 1  #  HAVING cod_evaluacion > 1  <-- condiciones que debe cumplir un atributo en el where, acá está mal
    ORDER BY EE.cod_evaluacion ASC;  # DESC




-- **8) Mostrar para cada contrato cantidad total de las comisiones, cantidad a pagar,
-- cantidad pagadas.

SELECT CON.nro_contrato "contrato", 
	count(*) "Total", 
    count(fecha_pago) "pagadas", 
    count(*) - count(fecha_pago) "a pagar"
	FROM `agencia_personal`.`contratos` CON 
		INNER JOIN `agencia_personal`.`comisiones` COM 
			ON CON.nro_contrato=COM.nro_contrato
	GROUP BY CON.nro_contrato;
-- Error Code: 1140. In aggregated query without GROUP BY, 
-- expression #1 of SELECT list contains nonaggregated column 'agencia_personal.CON.nro_contrato'; this is incompatible with sql_mode=only_full_group_by
            

-- **9) Mostrar para cada contrato la cantidad de comisiones, el % de comisiones pagas y
-- el % de impagas.

SELECT 
	con.nro_contrato,
    COUNT(*) "Total",
    (COUNT(fecha_pago) / COUNT(*)) * 100 "pagadas",
    ((COUNT(*) - COUNT(fecha_pago)) / COUNT(*)) * 100 "a pagar"
	FROM `agencia_personal`.`contratos` con
    INNER JOIN `agencia_personal`.`comisiones` com
		ON con.nro_contrato = com.nro_contrato
	GROUP BY con.nro_contrato;










SELECT CON.nro_contrato, COM.fecha_pago
	FROM `agencia_personal`.`contratos` CON 
		INNER JOIN `agencia_personal`.`comisiones` COM ON CON.nro_contrato=COM.nro_contrato;
-- analizar los valores del join anterior

SELECT 
	CON.nro_contrato, COUNT(*) "Cant. comisiones",
    ROUND(COUNT(fecha_pago)/COUNT(*), 2) * 100 "% de comisiones pagas",
    100 - ROUND(COUNT(fecha_pago)/COUNT(*), 2) * 100 "% de comisiones impagas"
	FROM `agencia_personal`.`contratos` CON 
		INNER JOIN `agencia_personal`.`comisiones` COM ON CON.nro_contrato=COM.nro_contrato
    GROUP BY CON.nro_contrato;
    

-- 10) Mostar la cantidad de empresas diferentes que han realizado solicitudes y la
-- diferencia respecto al total de solicitudes.
-- | cantidad      | diferencia              |

SELECT 
	COUNT(fecha_solicitud) "Cantidad",
    COUNT(*) - COUNT(fecha_solicitud) "Diferencia"
	FROM `agencia_personal`.`empresas` emp	
    LEFT JOIN `agencia_personal`.`solicitudes_empresas` sol
		ON emp.cuit = sol.cuit
	GROUP BY emp.cuit;
	



SELECT COUNT(DISTINCT EMP.cuit) "cantidad de empresas diferentes que han realizado solicitudes",
	COUNT(*) - COUNT(DISTINCT EMP.cuit) "la diferencia respecto al total"
	FROM `agencia_personal`.`empresas` EMP INNER JOIN `agencia_personal`.`solicitudes_empresas` SE
		ON EMP.cuit=SE.cuit;


-- 11) Cantidad de solicitudes por empresas.
SELECT 
	emp.cuit "Cuit",
    emp.razon_social,
    COUNT(*)
	FROM `agencia_personal`.`empresas` emp
    INNER JOIN `agencia_personal`.`solicitudes_empresas` sol
		ON emp.cuit = sol.cuit
	GROUP BY emp.cuit;
	






SELECT EMP.cuit "cuit", EMP.razon_social "razon_social", COUNT(*) "cant. de solicitudes"
	FROM `agencia_personal`.`empresas` EMP INNER JOIN `agencia_personal`.`solicitudes_empresas` SE
		ON EMP.cuit=SE.cuit
	GROUP BY EMP.cuit
    ORDER BY COUNT(*) DESC;


-- 12) Cantidad de solicitudes por empresas y cargos.
-- |cuit |razon_social |descripción del cargo | cantidad|

SELECT
	emp.cuit,
    emp.razon_social,
    car.cod_cargo,
    COUNT(*)
	FROM `agencia_personal`.`empresas` emp
    INNER JOIN `agencia_personal`.`solicitudes_empresas` sol
		ON emp.cuit = sol.cuit
	INNER JOIN `agencia_personal`.`cargos` car
		ON sol.cod_cargo = car.cod_cargo
	GROUP BY emp.cuit, car.cod_cargo;






SELECT 
	EMP.cuit "cuit", EMP.razon_social "razon_social", 
	CONCAT (CAR.cod_cargo, "-", CAR.desc_cargo) "descripción del cargo", COUNT(*) "cant. de solicitudes"
	FROM `agencia_personal`.`empresas` EMP 
		INNER JOIN `agencia_personal`.`solicitudes_empresas` SE  ON EMP.cuit=SE.cuit
		INNER JOIN `agencia_personal`.`cargos` CAR ON SE.cod_cargo=CAR.cod_cargo
	GROUP BY EMP.cuit, CAR.cod_cargo
    ORDER BY COUNT(*) DESC;


-- LEFT/RIGHT JOIN
-- **13) Listar las empresas, indicando todos sus datos y la cantidad de personas diferentes
-- que han mencionado dicha empresa como antecedente laboral. Si alguna empresa NO fue
-- mencionada como antecedente laboral deberá indicar 0 en la cantidad de personas.
SELECT EMP.*, COUNT(DISTINCT ANT.dni) "Cant. personas diferentes que la mencionaron"
	FROM `agencia_personal`.`empresas` EMP 
		LEFT JOIN `agencia_personal`.`antecedentes` ANT ON EMP.cuit=ANT.cuit
	GROUP BY EMP.cuit
    # HAVING COUNT(DISTINCT ANT.dni) >= 2  # si queremos saber las empresas que hayan sido nombradas por lo menos 2
    ORDER BY COUNT(DISTINCT ANT.dni) DESC
    # LIMIT 3;  # TOP 3
;

-- **14) Indicar para cada cargo la cantidad de veces que fue solicitado. Ordenado en
-- forma descendente por cantidad de solicitudes. Si un cargo nunca fue solicitado, mostrar
-- 0. Agregar algún cargo que nunca haya sido solicitado
SELECT ANT.cod_cargo "cod_cargo", CAR.desc_cargo "desc_cargo", count(ANT.cod_cargo) "Cant de Solicitudes"
	FROM `agencia_personal`.`antecedentes` ANT
		RIGHT JOIN `agencia_personal`.`cargos` CAR ON ANT.cod_cargo=CAR.cod_cargo
	GROUP BY ANT.cod_cargo, CAR.desc_cargo
    ORDER BY count(ANT.cod_cargo) DESC
;
-- Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and 
-- contains nonaggregated column 'agencia_personal.CAR.desc_cargo' which is not functionally dependent on columns in GROUP BY clause; 
-- this is incompatible with sql_mode=only_full_group_by
SELECT * 
	FROM `agencia_personal`.`cargos` CAR
		LEFT JOIN `agencia_personal`.`antecedentes` ANT ON ANT.cod_cargo=CAR.cod_cargo
;

-- **15) Indicar los cargos que hayan sido solicitados menos de 2 veces














SELECT ANT.cod_cargo "cod_cargo", CAR.desc_cargo "desc_cargo", count(ANT.cod_cargo) "Cant de Solicitudes" 
	FROM `agencia_personal`.`cargos` CAR
		LEFT JOIN `agencia_personal`.`antecedentes` ANT ON ANT.cod_cargo=CAR.cod_cargo
	GROUP BY ANT.cod_cargo, CAR.desc_cargo
    HAVING count(ANT.cod_cargo) < 2
    ORDER BY count(ANT.cod_cargo) DESC
;











