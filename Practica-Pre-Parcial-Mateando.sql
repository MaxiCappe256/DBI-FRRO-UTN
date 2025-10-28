-- a. (1 punto) Informar características de los productos cuyo nombre comience
-- con “ma” y tengan una capacidad mayor a 500 cc, ordenados de mayor a
-- menor por capacidad:
-- Producto Tipo de Producto Material ↓↓↓↓↓

SELECT 
	pro.nombre "Producto",
    tip.descripcion "Tipo producto",
    mat.material "Material"
FROM Productos pro
INNER JOIN TiposProductos tip
ON pro.IdTipProducto = tip.codigo
INNER JOIN Materiales mat
ON pro.IdMaterial = mat.codigo
WHERE pro.nombre LIKE 'ma%' AND pro.capacidad > 500
ORDER BY pro.capacidad DESC;

/*
b. (1 punto) Informar el precio vigente a hoy del producto mate-listo de 1000 cc.
Código Producto Precio
*/
SELECT 
	pro.codigo,
	pro.nombre,
	pro.precio
FROM Productos pro
INNER JOIN HistoPrecios hist
ON pro.codigo = hist.codigo
WHERE pro.nombre = 'mate-listo' AND pro.capacidad = 1000 AND fechaDesde <= CURDATE()
ORDER BY fechaDesde DESC
LIMIT 1;

/* c. (1 punto) Informar vendedores junto con su supervisor, en el caso de que un
vendedor no tenga supervisión informar “Sin supervisión”.
Legajo Empleado
(Nombre y apellido
Fecha Ingreso
(dd/mm/YYYY)
Antigüedad Supervisor
(Nombre y apellido
*/

SELECT 
	ven.legajo "Legajo",
	CONCAT(ven.nombre, ", ", ven.apellido) "Empleado",
    IFNULL(CONCAT(sup.nombre, ", ", sup.apellido), "Sin supervisor") "Supervisor",
    DATE_FORMAT(ven.fecha_ingreso, "%d/%m/%Y") "Fecha ingreso"
FROM vendedores ven
LEFT JOIN vendedores sup
ON ven.leg_supervisor = sup.legajo


 