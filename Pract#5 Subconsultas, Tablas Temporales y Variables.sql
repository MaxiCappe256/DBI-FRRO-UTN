-- Practica Nº 5: Subconsultas, Tablas Temporales y Variables
-- Practica en Clase: 1 – 2 – 3 – 4 – 7 – 9 – 10 – 11 – 12 – 16
-- Práctica Complementaria: 5 – 6 – 8 – 13 – 14 – 15 – 17
-- BASE DE DATOS: AGENCIA_PERSONAL


-- 1 )¿Qué personas fueron contratadas por las mismas empresas que Stefanía Lopez?
-- |dni |apellido |nombre|


-- 2) Encontrar a aquellos empleados que ganan menos que el máximo sueldo de los empleados
-- de Viejos Amigos.
-- |dni |nombre y apellidos |sueldo


-- 3) Mostrar empresas contratantes y sus promedios de comisiones pagadas o a pagar, pero sólo
-- de aquellas cuyo promedio supere al promedio de Tráigame eso.


-- 4) Seleccionar las comisiones pagadas que tengan un importe menor al promedio de todas las
-- comisiones(pagas y no pagas), mostrando razón social de la empresa contratante, mes
-- contrato, año contrato , nro. contrato, nombre y apellido del empleado.

-- 5) Determinar las empresas que pagaron más que el promedio

-- 6) Seleccionar los empleados que no tengan educación no formal o terciario.
-- |apellido |nombre   |

-- 7) Mostrar los empleados cuyo salario supere al promedio de sueldo de la empresa que los
-- contrató.
-- |cuit |dni |sueldo |prom

-- 9) Alumnos que se hayan inscripto a más cursos que Antoine de Saint-Exupery. Mostrar
-- todos los datos de los alumnos, la cantidad de cursos a la que se inscribió y cuantas
-- veces más que Antoine de Saint-Exupery.
-- |dni |nombre|apellido |direccion |email |te |count(*) count(*)- @cant)

-- 11) Indicar el valor actual de los planes de Capacitación
-- nom_plan fecha_desde_plan valor_plan


-- 12) Plan de capacitacion mas barato. Indicar los datos del plan de capacitacion y el valor actual
-- nom_plan desc_plan hs modalidad valor_plan

-- 16)Para conocer la disponibilidad de lugar en los cursos que empiezan en abril para
-- lanzar una campaña se desea conocer la cantidad de alumnos inscriptos a los cursos
-- que comienzan a partir del 1/04/2014 indicando: Plan de Capacitación, curso, fecha de
-- inicio, salón, cantidad de alumnos inscriptos y diferencia con el cupo de alumnos
-- registrado para el curso que tengan al más del 80% de lugares disponibles respecto del
-- cupo.
-- Ayuda: tener en cuenta el uso de los paréntesis y la precedencia de los operadores
-- matemáticos.
-- nro_curso fecha_ini salon cupo count( dni ) ( cupo - count( dni ) )


