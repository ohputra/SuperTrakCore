(*
Copyright ATS Automation Tooling Systems, Inc. 2016-2017
All rights reserved.
*)

TYPE
	DeviceDetectInterfaceInternal_t : 	STRUCT 
		socket : UDINT;
		state : UINT;
		clientPort : UINT;
		rxLength : UINT;
		txLength : UINT;
		rx : ARRAY[0..63]OF USINT;
		tx : ARRAY[0..63]OF USINT;
		errorResetTimer : UDINT;
		fb_recv : UdpRecv;
		fb_send : UdpSend;
		fb_logWrite : AsArLogWrite;
END_STRUCT;
END_TYPE
