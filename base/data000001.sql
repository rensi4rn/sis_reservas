
/***********************************I-DAT-FFP-RES-0-27/03/2014*****************************************/

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('RES', 'Reservas', '27/03/2014', 'RES', 'activo', 'reservas', NULL);

----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('RESERVAS', '', 'RES', 'si',1 , '', 1, '', '', 'RES');
select pxp.f_insert_tgui ('Asegurado', 'asegurados', 'aseg', 'si', 1, 'sis_reservas/vista/asegurado/Asegurado.php', 2, '', 'Asegurado', 'RES');
select pxp.f_insert_testructura_gui ('RES', 'SISTEMA');
select pxp.f_insert_testructura_gui ('aseg', 'RES');

/***********************************F-DAT-FFP-RES-0-27/03/2014*****************************************/


/***********************************I-DAT-FFP-RES-1-27/03/2014*****************************************/

----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('Especialidad', 'Especialidad', 'ESPE', 'si', 2, 'sis_reservas/vista/especialidad/Especialidad.php', 2, '', 'Especialidad', 'RES');
select pxp.f_insert_testructura_gui ('ESPE', 'RES');

/***********************************F-DAT-FFP-RES-1-27/03/2014*****************************************/