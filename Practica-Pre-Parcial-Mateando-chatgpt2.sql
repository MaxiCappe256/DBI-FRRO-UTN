/*
a. (1 pto) Listar las especies cuyo nombre común contenga la palabra “tilo” (cualquier posición, sin distinguir may/min), ordenadas alfabéticamente.
Salida: ID | NombreComun | NombreCientifico

b. (1 pto) Mostrar los ejemplares con riesgo alto (por ejemplo, nivel >= 4), incluyendo nombre científico, barrio y coordenadas.
Salida: ID_Ejemplar | Riesgo | Especie | Barrio | Lat | Lng

c. (1 pto) Para cada barrio, informar la cantidad de ejemplares y el promedio de diámetro. Incluir sólo barrios con al menos 50 ejemplares.
Salida: Barrio | Ejemplares | DiametroProm (2 decimales)

d. (1 pto) Listar los ejemplares sin observaciones (nulas o cadena vacía).
Salida: ID | Especie | Barrio

e. (1 pto) Mostrar las inspecciones del mes actual, con inspector, nivel de riesgo y fecha, ordenadas por fecha asc.
Salida: ID | Inspector | Nivel | Fecha

f. (2 ptos) Informar los 3 barrios con mayor densidad de riesgo calculada como promedio de nivel considerando los ejemplares ubicados allí.
Salida: Barrio | NivelPromedio
Tip: join ejemplares → ubicaciones → barrios → nivel_riesgo.

g. (2 ptos) Listar reclamos sin ejemplar asociado (o sea, cargados por ubicación), con motivo, canal y barrio.
Salida: ID_Reclamo | Motivo | Canal | Barrio

h. (2 ptos) Para cada inspector, contar cuántas inspecciones realizó en los últimos 90 días y el promedio de nivel que asignó. Mostrar sólo inspectores con ≥ 10 inspecciones en ese período.
Salida: Inspector | Inspecciones90d | NivelPromedio

i. (2 ptos) Mostrar las recomendaciones más usadas (top 5) en recomen_inspecciones, indicando cuántas veces se recomendó y el nivel promedio asociado.
Salida: Recomendacion | Veces | NivelPromedio

j. (2 ptos) Listar ejemplares críticos: aquellos que tuvieron alguna inspección con nivel >= 5 y actualmente pertenecen a una especie con altura_maxima > 20.
Salida: ID_Ejemplar | Especie | AlturaMax | UltimoNivelInspeccion
Tip: podés tomar el máximo nivel inspeccionado por ejemplar.

k. (2 ptos) Informar ordenes de trabajo programadas para la próxima semana (hoy + 7 días), mostrando tipo de intervención, asignación (CUA/Contratista), y si dependen de otra OT (ot_pendiente).
Salida: ID_OT | FechaProg | TipoInterv | Asignacion | OT_Depende
Tip: fecha_programada >= CURDATE() y < CURDATE() + INTERVAL 7 DAY.

l. (2 ptos) Calcular el costo promedio y horas hombre promedio de las OT finalizadas el mes pasado.
Salida: Mes | CostoProm | HsHombreProm

m. (2 ptos) Por reclamo, mostrar su estado actual (el más reciente en estados_reclamos por fecha), junto con fecha y nombre del estado.
Salida: ID_Reclamo | EstadoActual | Fecha
Tip: subconsulta o window function; si no hay window, usar MAX(fecha).

n. (2 ptos) Listar las OT que no tienen foto antes ni foto después, pero están finalizadas.
Salida: ID_OT | FechaFinalizacion | TipoInterv

o. (2 ptos) Mostrar las calles con más de 200 ejemplares asignados, ordenadas por cantidad desc. aaaaa
Salida: Calle | Ejemplares
Tip: ejemplares → ubicaciones (id=id_ubicacion) → calles (id=id_calle).

p. (2 ptos) Listar las recomendaciones por prioridad para inspecciones con nivel = 3, mostrando cuántas veces se emitió cada recomendación por cada prioridad.
Salida: Recomendacion | Prioridad | Veces

q. (2 ptos) Para cada especie, informar el rango de plantación (fecha_plant_desde a fecha_plant_hasta) y cuántos ejemplares caen dentro de ese rango (si ambas fechas no son nulas).
Salida: Especie | Desde | Hasta | EjemplaresEnRango
Tip: si las fechas son nulas, podés excluir la especie.

r. (2 ptos) Identificar ubicaciones con servicios subterráneos (serv_subterraneos = TRUE) donde haya ejemplares de especies con diámetro > 50.
Salida: Barrio | CalleAltura | Especie | Diametro

s. (2 ptos) Detectar reclamos sin estados (no aparecen en estados_reclamos).
Salida: ID_Reclamo | Motivo | Canal

t. (2 ptos) Encontrar OT encadenadas (aquellas que dependen de otra OT) y mostrar la cadena de dependencia hasta la raíz (sin dependencia) usando CTE recursiva.
Salida: ID_OT | Cadena
Tip: WITH RECURSIVE sobre ordenes_trabajo (id, ot_pendiente).

u. (2 ptos) Calcular el tiempo de ejecución de las OT finalizadas: diferencia en días entre fecha_programada y fecha_finalizacion, y mostrar el promedio por tipo de intervención.
Salida: TipoInterv | DiasPromEjecucion

v. (2 ptos) Por barrio, informar la proporción de ejemplares con servicios subterráneos en su ubicación (porcentaje respecto del total de ejemplares del barrio).
Salida: Barrio | PorcConServicios (0–100 con 2 decimales)

w. (2 ptos) Top 10 de motivos de reclamo por barrio en el último año, ordenado por cantidad desc (dentro de cada barrio).
Salida: Barrio | Motivo | Reclamos
Tip: filtrar por estados_reclamos.fecha o por fecha de OT relacionada si tu modelo lo requiere.

x. (2 ptos) Insert de ejemplo: crear una inspección para un inspector existente con nivel_riesgo medio; agregar dos recomendaciones con prioridades 1 y 2, y una foto.
Entrega: sentencias INSERT consistentes (usá IDs existentes).

y. (2 ptos) Update: marcar como Contratista (asignacion = 'CON' por ejemplo) todas las OT del próximo mes cuyo costo_estimado supere $500.000.
Entrega: sentencia UPDATE con filtro de fechas y costo.

z. (2 ptos) Delete seguro: eliminar de fotos_inspecciones las fotos huérfanas cuyo id_inspeccion no exista en inspecciones.
Entrega: sentencia DELETE con NOT EXISTS.

*/