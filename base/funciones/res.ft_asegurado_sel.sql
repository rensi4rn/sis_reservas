CREATE OR REPLACE FUNCTION res.ft_asegurado_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Reservas
 FUNCION: 		res.ft_asegurado_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'res.tasegurado'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'res.ft_asegurado_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RES_ASE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		27-03-2014 15:18:40
	***********************************/

	if(p_transaccion='RES_ASE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						ase.id_asegurado,
						ase.estado_reg,
						ase.codigo_asegurado,
						ase.id_persona,
						ase.id_usuario_reg,
						ase.fecha_reg,
						ase.id_usuario_mod,
						ase.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        person.nombre_completo1 as desc_person
						from res.tasegurado ase
						inner join segu.tusuario usu1 on usu1.id_usuario = ase.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ase.id_usuario_mod
                        inner join segu.vpersona person on person.id_persona = ase.id_persona
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'RES_ASE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		27-03-2014 15:18:40
	***********************************/

	elsif(p_transaccion='RES_ASE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_asegurado)
					    from res.tasegurado ase
					    inner join segu.tusuario usu1 on usu1.id_usuario = ase.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ase.id_usuario_mod
                        inner join segu.vpersona person on person.id_persona = ase.id_persona
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
	end if;
					
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;