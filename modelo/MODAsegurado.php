<?php
/**
*@package pXP
*@file gen-MODAsegurado.php
*@author  (admin)
*@date 27-03-2014 15:18:40
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAsegurado extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAsegurado(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='res.ft_asegurado_sel';
		$this->transaccion='RES_ASE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_asegurado','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo_asegurado','varchar');
		$this->captura('id_persona','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('desc_person','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarAsegurado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='res.ft_asegurado_ime';
		$this->transaccion='RES_ASE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo_asegurado','codigo_asegurado','varchar');
		$this->setParametro('id_persona','id_persona','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAsegurado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='res.ft_asegurado_ime';
		$this->transaccion='RES_ASE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_asegurado','id_asegurado','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo_asegurado','codigo_asegurado','varchar');
		$this->setParametro('id_persona','id_persona','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAsegurado(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='res.ft_asegurado_ime';
		$this->transaccion='RES_ASE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_asegurado','id_asegurado','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>