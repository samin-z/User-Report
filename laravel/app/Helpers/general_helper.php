<?php

	function jerror( $msg = ''){
		if(is_object($msg))
		{
			$msg = $msg->messages()->messages();
		}

		echo json_encode(array('stat'=>'er' , 'msg'=>$msg));
		exit;
	}


	function jok( $data = array() ){

		$data = is_array($data) ? $data : array('msg'=>$data);
		echo json_encode(array('stat'=>'ok') + $data );
		exit;
	}
?>