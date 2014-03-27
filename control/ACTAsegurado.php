<?php
/**
*@package pXP
*@file gen-ACTAsegurado.php
*@author  (admin)
*@date 27-03-2014 15:18:40
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAsegurado extends ACTbase{    
			
	function listarAsegurado(){
		$this->objParam->defecto('ordenacion','id_asegurado');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAsegurado','listarAsegurado');
		} else{
			$this->objFunc=$this->create('MODAsegurado');
			
			$this->res=$this->objFunc->listarAsegurado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAsegurado(){
		$this->objFunc=$this->create('MODAsegurado');	
		if($this->objParam->insertar('id_asegurado')){
			$this->res=$this->objFunc->insertarAsegurado($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAsegurado($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAsegurado(){
			$this->objFunc=$this->create('MODAsegurado');	
		$this->res=$this->objFunc->eliminarAsegurado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>