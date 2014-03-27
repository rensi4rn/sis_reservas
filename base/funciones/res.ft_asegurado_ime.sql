CREATE OR REPLACE FUNCTION "res"."ft_asegurado_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Reservas
 FUNCION: 		res.ft_asegurado_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'res.tasegurado'
 AUTOR: 		 (admin)
 FECHA:	        27-03-2014 15:18:40
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_asegurado	integer;
			    
BEGIN

    v_nombre_funcion = 'res.ft_asegurado_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RES_ASE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-03-2014 15:18:40
	***********************************/

	if(p_transaccion='RES_ASE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into res.tasegurado(
			estado_reg,
			codigo_asegurado,
			id_persona,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.codigo_asegurado,
			v_parametros.id_persona,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_asegurado into v_id_asegurado;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Asegurado almacenado(a) con exito (id_asegurado'||v_id_asegurado||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_asegurado',v_id_asegurado::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'RES_ASE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-03-2014 15:18:40
	***********************************/

	elsif(p_transaccion='RES_ASE_MOD')then

		begin
			--Sentencia de la modificacion
			update res.tasegurado set
			codigo_asegurado = v_parametros.codigo_asegurado,
			id_persona = v_parametros.id_persona,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_asegurado=v_parametros.id_asegurado;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Asegurado modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_asegurado',v_parametros.id_asegurado::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'RES_ASE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-03-2014 15:18:40
	***********************************/

	elsif(p_transaccion='RES_ASE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from res.tasegurado
            where id_asegurado=v_parametros.id_asegurado;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Asegurado eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_asegurado',v_parametros.id_asegurado::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "res"."ft_asegurado_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
