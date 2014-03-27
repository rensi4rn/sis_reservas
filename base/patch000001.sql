/***********************************I-SCP-JRR-RES-1-27/03/2014****************************************/

CREATE TABLE res.tasegurado 
(
id_asegurado  SERIAL NOT NULL, 
codigo_asegurado varchar(255),
 id_persona int4, PRIMARY KEY (id_asegurado)
)INHERITS (pxp.tbase);




/***********************************F-SCP-JRR-RES-1-27/03/2014****************************************/
