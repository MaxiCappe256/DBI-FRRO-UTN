USE `afatse`;

-- 1) Agregar el nuevo instructor Daniel Tapia con cuil: 44-44444444-4, teléfono: 444-444444,
-- email: dotapia@gmail.com, dirección Ayacucho 4444 y sin supervisor.

INSERT INTO `afatse`.`instructores` (
	cuil, nombre, apellido, tel, email, direccion, cuil_supervisor
    ) VALUES (
	'44-44444444-4', 'Daniel', 'Tapia', '444-444444', 'dotapia@gmail.com', 'Ayacucho 4444', NULL
    );
    
SELECT * FROM `afatse`.`instructores` WHERE cuil = '44-44444444-4';

-- 2) Ingresar un nuevo plan de capacitación con sus datos, costo, temas, exámenes y
-- materiales:
-- Plan:
-- Nombre: Administrador de BD, descripción: Instalación y configuración MySQL. Lenguaje
-- SQL. Usuarios y permisos, de 300 hs con modalidad presencial

SELECT * FROM `afatse`.`plan_capacitacion`;

INSERT INTO `afatse`.`plan_capacitacion` (
		nom_plan, desc_plan, hs, modalidad
    ) VALUES (
		'Administrador de BD', 
        'Instalacion y configracion MySQL. Lenguaje SQL. Usuarios y permisos',
        300,
        'Presencial'
    );
    
SELECT * FROM `afatse`.`plan_temas`;
    
INSERT INTO `afatse`.`plan_temas` (
		nom_plan, titulo, detalle
    ) VALUES 
    ('Administrador de BD', 'Instalacion MySQL', 'Distintas configuraciones de instalacion'),
	('Administrador de BD', 'Configuracion DBMS','Variables de entorno, su uso y configuracion',),
    ('Administrador de BD', 'Lenguaje SQL', 'DML, DDL y TCL'),
    ('Administrador de BD', 'Usuarios y Permisos', 'Permisos de usuarios y DCL');
    
SELECT * FROM `afatse`.`examenes`;

INSERT INTO `afatse`.`examenes` (
		nom_plan, nro_examen
	) VALUES 
    ('Administrador de BD', 1),
    ('Administrador de BD', 2),
    ('Administrador de BD', 3),
    ('Administrador de BD', 4);

SELECT * FROM `afatse`.`examenes_temas`;

INSERT INTO `afatse`.`examenes_temas` (
		nom_plan, titulo, nro_examen
	) VALUES 
	('Administrador de BD', '1- Instalacion MySQL', 1),
	('Administrador de BD', '2- COnfiguracion DBMS', 2),
	('Administrador de BD', '3- Lenguaje SQL', 3),
	('Administrador de BD', '4- Usuarios y Permisos', 4);
    
SELECT * FROM `afatse`.`materiales`;

INSERT INTO `afatse`.`materiales` (
		cod_material, desc_material, url_descarga, 
        autores, tamanio, fecha_creacion, 
        cant_disponible, punto_pedido, cantidad_a_pedir
	) VALUES 
	('AP-010', 'DBA en MySQL', 'www.afatse.com.ar/apuntes?AP=010', 'Jose Roman', '2MB', '01/03/09'),
	('AP-011', 'SQL en MySQL', 'www.afatse.com.ar/apuntes?AP=011', 'Juan Lopez', '3MB', '01/04/09');

SELECT * FROM `afatse`.`materiales_plan`;

INSERT INTO `afatse`.`materiales_plan` (
		nom_plan, cod_material, cant_entrega
	) VALUES 
	('Administrador de BD', 'UT-001', 1),
    ('Administrador de BD', 'UT-002', 1),
    ('Administrador de BD', 'UT-003', 1),
    ('Administrador de BD', 'UT-004', 1),
    ('Administrador de BD', 'AP-010', 1),
    ('Administrador de BD', 'AP-011', 1);
    
SELECT * FROM `afatse`.`valores_plan`;

INSERT INTO `afatse`.`valores_plan` 
		(nom_plan, fecha_desde_plan, valor_plan)
    VALUES
		('Administrador de BD', '2009-02-01', 150.000);
        
        
-- UPDATE

-- 1) Como resultado de una mudanza a otro edificio más grande se ha incrementado la
-- capacidad de los salones, además la experiencia que han adquirido los instructores permite
-- ampliar el cupo de los cursos. Para todos los curso con modalidad presencial y
-- semipresencial aumentar el cupo de la siguiente forma:
-- ● 50% para los cursos con cupo menor a 20
-- ● 25% para los cursos con cupo mayor o igual a 20


SELECT * FROM `afatse`.`cursos`;

UPDATE `afatse`.`cursos` cur
	INNER JOIN `afatse`.`plan_capacitacion` pc
		ON cur.nom_plan = pc.nom_plan
	SET cur.cupo = cur.cupo * 1.50
    WHERE cur.cupo IS NOT NULL 
		AND cur.cupo < 20
        AND (LOWER(pc.modalidad) = 'presencial' OR LOWER(pc.modalidad) LIKE 'semi%');
        

