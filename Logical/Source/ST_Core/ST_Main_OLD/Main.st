(*********************************************************************************
 * Copyright: ATS Automation Tooling Systems, Inc. 2015
 *     All rights reserved.
 *********************************************************************************
 *********************************************************************************
 * Description:
 * -------------------------------------------------------------------------------
 * This task configures the internal communication structure AND controlls
 * the SuperTrak system.
 *********************************************************************************)

PROGRAM _INIT
	
	testString;
 
	(* DiagCpuIsSimulated() returns TRUE if "Activate Simulation" is enabled. *)
	IsSimulation := DiagCpuIsSimulated();
	
	(* DiagCpuIsSimulated() returns FALSE if the project configuration specifies
	 * ARsim. Assume simulation mode IF this task is named 'ST_MainSim'.
	 *)
	taskName := '';
	status := ST_name(0, ADR(taskName), ADR(taskGroup));

	IF (taskName = 'ST_MainSim') THEN
		IsSimulation := TRUE;
	END_IF;
		
	IF (IsSimulation) THEN
		(* This path can be customized as needed *)
		SuperTrakStoragePath := '/DEVICE=../../../../Logical/ConfigFiles';
		//SuperTrakStoragePath	:= '/DEVICE=C:\SuperTrakCfg\SuperTrakCore';
	ELSE
		(* CFast card USER partition *)
		SuperTrakStoragePath := '/DEVICE=F:\SuperTrakCore';
	END_IF;
	
	
	// SuperTrak initialization
	SuperTrakInit(IsSimulation,SuperTrakStoragePath);
	
	DeviceDetectInterface0.allowConfiguration  := TRUE;
	DeviceDetectInterface0.deviceState    := 1;
	DeviceDetectInterface0.deviceType    := DEVICE_TYPE_SUPERTRAK_G3;
	DeviceDetectInterface0.enable     := TRUE;
	DeviceDetectInterface0.device     := ''; (* empty for ARsim *)
	DeviceDetectInterface0();
	
	// Service Channel initialization
	ServiceChannelData.channelId    		:= 1;
	ServiceChannelData.pRequestHeader		:= ADR(gStServiceChannelReqData);
	ServiceChannelData.pResponseHeader		:= ADR(gStServiceChannelResData);
	ServiceChannelData.pRequestValues     	:= ADR(gStServiceChannelReqData) + SIZEOF(ServiceChannelHeader_t);
	ServiceChannelData.pResponseValues    	:= ADR(gStServiceChannelResData) + SIZEOF(ServiceChannelHeader_t);
	ServiceChannelData.requestBufferSize  	:= SIZEOF(gStServiceChannelReqData);
	ServiceChannelData.responseBufferSize  	:= SIZEOF(gStServiceChannelResData);
	ServiceChannelData.state     			:= scSTATE_RECV;
	
	pResView ACCESS ADR(gStServiceChannelResData);
	pReqView ACCESS ADR(gStServiceChannelReqData);
	
	// Command interface mapping
	SuperTrakControlInterface[0].pControl   := ADR(gStCyclicControlData);
	SuperTrakControlInterface[0].pStatus   := ADR(gStCyclicStatusData);
	SuperTrakControlInterface[0].controlSize  := SIZEOF(gStCyclicControlData);
	SuperTrakControlInterface[0].statusSize  := SIZEOF(gStCyclicStatusData);
	
	mvCounter;
 
END_PROGRAM

PROGRAM _CYCLIC

	mvCounter := mvCounter + 1;

	// Cyclic SuperTrak control
	SuperTrakCyclic();
 
	// Map internal communication structure
	FOR i := 0 TO stMAX_CONTROL_IF_INDEX DO
		SuperTrakProcessControl(i, SuperTrakControlInterface[i]);
	END_FOR;
	
	// Service channel handling
	IF ServiceChannelData.state = scSTATE_RECV AND
		pReqView.sequence <> pResView.sequence THEN
		ServiceChannelData.requestSequence  := pReqView.sequence;
		ServiceChannelData.state    		:= scSTATE_EXEC;
	ELSIF ServiceChannelData.state = scSTATE_EXEC OR ServiceChannelData.state = scSTATE_WAIT THEN
		SuperTrakServiceChannel(ServiceChannelData);
	ELSIF ServiceChannelData.state = scSTATE_SEND THEN
		ServiceChannelData.state    		:= scSTATE_RECV;
	END_IF;
 
END_PROGRAM

PROGRAM _EXIT

 // Clear internal memory
	SuperTrakExit();

END_PROGRAM


