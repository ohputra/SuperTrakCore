(*********************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  Bernecker + Rainer
 * Created:  July 27, 2016/10:44 AM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.00.0   July 27, 2016/10:44 AM  First Version
 * V 1.10.0	  January 3, 2018/4:30 PM	Updated to work with new gSuperTrak
										command structure
 *********************************************************************************
 * Description:
	
	This task accepts commands and parameters from the gSuperTrak control structure,
	and writes new status information to the same structure. ST_Logic should not
	be necessary to modify, and can be used as a starting point for applications.
 *********************************************************************************)

PROGRAM _INIT
 
 (*************************************************************************************************)
 (*************************************************************************************************)
 (* FUNCTION BLOCK CONFIGURATION *)
 
 // Configure the internal communication structure to/from SuperTrak
	SuperTrakControlParameters.NrOfCommands        	:= CONFIG_ST_MAX_COMMANDS;
	SuperTrakControlParameters.NrOfPallets        	:= CONFIG_ST_MAX_PALLETS;
	SuperTrakControlParameters.NrOfSections        	:= CONFIG_ST_MAX_SECTIONS;
	SuperTrakControlParameters.NrOfTargets        	:= CONFIG_ST_MAX_TARGETS;
 
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* FUNCTION BLOCK INITIALIZATION *)

	// Initialize the function block, handling the communication to/from SuperTrak
	StControl_0.StLink       				:= ADR(gStLink);
	StControl_0.Enable       				:= TRUE;
	StControl_0.Parameters      			:= ADR(SuperTrakControlParameters);
	StControl_0.StCtrlData      			:= ADR(gStCyclicControlData);
	StControl_0.StCtrlDataSize     			:= SIZEOF(gStCyclicControlData);
	StControl_0.StStatData      			:= ADR(gStCyclicStatusData);
	StControl_0.StStatDataSize     			:= SIZEOF(gStCyclicStatusData);
	StControl_0.StServChRequestData   		:= ADR(gStServiceChannelReqData);
	StControl_0.StServChRequestDataSize  	:= SIZEOF(gStServiceChannelReqData);
	StControl_0.StServChResponseData  		:= ADR(gStServiceChannelResData);
	StControl_0.StServChResponseDataSize 	:= SIZEOF(gStServiceChannelResData);
	
	// Initialize parameter read function block to pull status information from SuperTrak
	StReadPnu_0.StLink						:= ADR(gStLink);
	StReadPnu_0.Parameters					:= ADR(ReadPnuPara[0]);
	StReadPnu_0.DataAddress					:= ADR(ReadDataBuffer[0].Entry);
	StReadPnu_0.DataSize					:= SIZEOF(ReadDataBuffer[0].Entry);
	
	// Initialize parameter write function block to push parameter information to the SuperTrak
	StWritePnu_0.StLink						:= ADR(gStLink);
	StWritePnu_0.Parameters					:= ADR(WritePnuPara[0]);
	StWritePnu_0.DataAddress				:= ADR(WriteDataBuffer[0].Entry);
	StWritePnu_0.DataSize					:= SIZEOF(WriteDataBuffer[0].Entry);	
	
	// Initialize parameter inputs to Section control function block
	FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
		SuperTrakSectionParameters[Index].Reserved;
	END_FOR;
	
	// Initialize parameter inputs to Target control function block
	FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
		SuperTrakTargetParameters[Index].AdvancedReleaseConfig.DestinationTarget	:= 15;
		SuperTrakTargetParameters[Index].AdvancedReleaseConfig.Direction			:= stCOM_DIR_RIGHT;
		SuperTrakTargetParameters[Index].PalletConfig.Motion.Acceleration			:= 500;//mm/s^2
		SuperTrakTargetParameters[Index].PalletConfig.Motion.Velocity				:= 1000;//mm/s
	END_FOR;

	// Initialize parameter inputs to Pallet control function blocks
	FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
		SuperTrakPalletParameters[Index].AdvancedReleaseConfig.DestinationTarget	:= 15;
		SuperTrakPalletParameters[Index].AdvancedReleaseConfig.Direction			:= stCOM_DIR_RIGHT;
		SuperTrakPalletParameters[Index].PalletConfig.Motion.Acceleration			:= 500;//mm/s^2
		SuperTrakPalletParameters[Index].PalletConfig.Motion.Velocity				:= 1000;//mm/s
	END_FOR;
 
	// Initialize the function blocks, controlling a single section
	FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
		StSection_[Index].StLink    		:= ADR(gStLink);
		StSection_[Index].Parameters  		:= ADR(SuperTrakSectionParameters[Index]);
		StSection_[Index].Section   		:= Index;
	END_FOR;

	// Initialize the function blocks, controlling a single target
	FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
		StTargetExt_[Index].StLink    		:= ADR(gStLink);
		StTargetExt_[Index].Parameters   	:= ADR(SuperTrakTargetParameters[Index]);
		StTargetExt_[Index].Target    		:= Index;
	END_FOR;
	
	// Initialize the function blocks controlling a single pallet
	FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
		StPallet_[Index].StLink				:= ADR(gStLink);
		StPallet_[Index].Parameters			:= ADR(SuperTrakPalletParameters[Index]);
		StPallet_[Index].PalletID			:= Index;
	END_FOR;
	

END_PROGRAM

PROGRAM _CYCLIC
 
 (*************************************************************************************************)
 (*************************************************************************************************)
 (* FUNCTION BLOCK ENABLE *)
 
 // Wait for StControl to be active, before enalbing all other function blocks
	IF StControl_0.Active THEN
		// Loop thru all StSection function blocks
		FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
			// Enable StSection
			StSection_[Index].Enable     := TRUE; 
		END_FOR;
  
		// Loop thru all StTargetExt function blocks
		FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
			// Enable StTargetExt
			StTargetExt_[Index].Enable     := TRUE; 
		END_FOR;
		
		// Loop thru all StPallet function blocks
		FOR Index := 0 TO (SIZEOF(StPallet_) /SIZEOF(StPallet_[0]) - 1) DO
			// Enable StPallet
			StPallet_[Index].Enable			:= TRUE;
		END_FOR;
		
		
	END_IF;
 
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* ENABLE / DISABLE SUPERTRAK SECTIONS *)
 
	// Wait for command, to enable all sections
	IF gSuperTrak.Cmds.Enable THEN
		// Loop thru all StSection function blocks
		FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
			// Check if section is ready to be enalbed
			IF StSection_[Index].MotorPowerOn AND NOT StSection_[Index].Error THEN
				// Enable section
				StSection_[Index].EnableSection   := TRUE; 
			END_IF; 
		END_FOR;
  
		// If command is reset, disable all sections
	ELSE
		// Loop thru all StSection function blocks
		FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
			// Disable section
			StSection_[Index].EnableSection		:= FALSE; 
			//StSection_[Index].Enable			:= FALSE;
		END_FOR;
	END_IF;
 
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* PALLET ROUTING AROUND THE SYSTEM - ACCEPT INPUTS FROM gSUPERTRAK *)
 
	// Check if all sections are enabled, before setting any commands
	IF StControl_0.SectionsEnabled THEN
		
		// Set the system status bit POWERED high
		gSuperTrak.Status.System.Enabled		:= TRUE;
		
		// Loop through all possible targets to accept new configuration parameters & release commands
		FOR Index := 1 TO ((SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0]))-1) DO
			CASE StTargetState[Index] OF
				0:	// Begin state machine if a release command is sent by the main application
					IF gSuperTrak.Status.Target[Index].PalletPresent AND
						(gSuperTrak.Par.Target[Index].ReleaseToTarget OR 
						gSuperTrak.Par.Target[Index].ReleaseToOffset OR 
						gSuperTrak.Par.Target[Index].IncrementOffset) THEN		
						
						// Grab all command information within the same cycle, in case MainCtrl modifies these commands in subsequent cycles
						IF gSuperTrak.Par.Target[Index].ReleaseToTarget THEN
							releaseModeTarget[Index]				:= 0;
						ELSIF gSuperTrak.Par.Target[Index].ReleaseToOffset THEN
							releaseModeTarget[Index]				:= 1;		
						ELSIF gSuperTrak.Par.Target[Index].IncrementOffset THEN
							releaseModeTarget[Index]				:= 2;
						END_IF;
						
						// Do the same for motion parameters & release config
						SuperTrakTargetParameters[Index].PalletConfig.Motion.Acceleration			:= gSuperTrak.Par.Target[Index].Config.Acceleration;
						SuperTrakTargetParameters[Index].PalletConfig.Motion.Velocity				:= gSuperTrak.Par.Target[Index].Config.Velocity;
						SuperTrakTargetParameters[Index].AdvancedReleaseConfig.DestinationTarget	:= gSuperTrak.Par.Target[Index].Config.DestinationTarget;
						SuperTrakTargetParameters[Index].AdvancedReleaseConfig.TargetOffset			:= gSuperTrak.Par.Target[Index].Config.TargetOffset;
						SuperTrakTargetParameters[Index].AdvancedReleaseConfig.IncrementalOffset	:= gSuperTrak.Par.Target[Index].Config.IncrementOffset;
						SuperTrakTargetParameters[Index].AdvancedReleaseConfig.Direction			:= gSuperTrak.Par.Target[Index].Config.Direction;	
						
						StTargetState[Index]	:= 1;
					END_IF;
				1:	// Update motion parameters for the commanded movement
					StTargetExt_[Index].SetPalletMotionPar										:= TRUE;
					
					// Once the update is complete, move to the next state in the state machine
					IF StTargetExt_[Index].CommandDone THEN
						StTargetExt_[Index].SetPalletMotionPar									:= FALSE;
						StTargetState[Index]													:= 2;	
					END_IF;
			
				2:	// Update destination target and travel direction for the commanded movement		
					StTargetExt_[Index].Update													:= TRUE;
				
					// Once the update is complete, move to the next state in the state machine
					IF StTargetExt_[Index].UpdateDone THEN
						StTargetExt_[Index].Update												:= FALSE;
						StTargetState[Index]													:= 3;
					END_IF;	
				3:
					//Pass the release command (either target or offset) to the StTarget function block and execute
					CASE releaseModeTarget[Index] OF
						0:		StTargetExt_[Index].ReleaseToTarget								:= TRUE;
						1:		StTargetExt_[Index].ReleaseToOffset								:= TRUE;
						2:		StTargetExt_[Index].IncrementOffset								:= TRUE;
					END_CASE;				
					
					IF StTargetExt_[Index].CommandDone THEN
						StTargetExt_[Index].ReleaseToTarget										:= FALSE;
						StTargetExt_[Index].ReleaseToOffset										:= FALSE;
						StTargetExt_[Index].IncrementOffset										:= FALSE;
						StTargetState[Index]													:= 4;
					END_IF;	
				4:
					// Once the pallet is released, notify the main application w/ PalletReleased and reset the state machine
					gSuperTrak.Status.Target[Index].PalletReleased								:= TRUE;
					IF gSuperTrak.Par.Target[Index].ReleaseToTarget = FALSE AND gSuperTrak.Par.Target[Index].ReleaseToOffset = FALSE AND gSuperTrak.Par.Target[Index].IncrementOffset = FALSE THEN
						gSuperTrak.Status.Target[Index].PalletReleased							:= FALSE;
						StTargetState[Index]													:= 0;
					END_IF;
					
				5:
				6:
				7:
				8:
				9:
				
			END_CASE;
		END_FOR;
		
		
		
		// Loop through all possible pallets to accept new configuration parameters & release commands
		FOR Index := 0 TO ((SIZEOF(StPallet_) / SIZEOF(StPallet_[0]))-1) DO
			CASE StPalletState[Index] OF
				0:	// Begin state machine if a release command is sent by the main application
					IF gSuperTrak.Par.Pallet[Index].ReleaseToTarget OR
						gSuperTrak.Par.Pallet[Index].ReleaseToOffset OR
						gSuperTrak.Par.Pallet[Index].IncrementOffset THEN
						
						// Grab all command information within the same cycle, in case MainCtrl modifies these commands in subsequent cycles
						IF gSuperTrak.Par.Pallet[Index].ReleaseToTarget THEN
							releaseModePallet[Index]			:= 0;
						ELSIF gSuperTrak.Par.Pallet[Index].ReleaseToOffset THEN
							releaseModePallet[Index]			:= 1;
						ELSIF gSuperTrak.Par.Pallet[Index].IncrementOffset THEN
							releaseModePallet[Index]			:= 2;
						END_IF;
												
						// Do the same for motion parameters & release configS
						SuperTrakPalletParameters[Index].PalletConfig.Motion.Acceleration			:= gSuperTrak.Par.Pallet[Index].Config.Acceleration;
						SuperTrakPalletParameters[Index].PalletConfig.Motion.Velocity				:= gSuperTrak.Par.Pallet[Index].Config.Velocity;
						SuperTrakPalletParameters[Index].AdvancedReleaseConfig.DestinationTarget	:= gSuperTrak.Par.Pallet[Index].Config.DestinationTarget;
						SuperTrakPalletParameters[Index].AdvancedReleaseConfig.TargetOffset			:= gSuperTrak.Par.Pallet[Index].Config.TargetOffset;
						SuperTrakPalletParameters[Index].AdvancedReleaseConfig.IncrementalOffset	:= gSuperTrak.Par.Pallet[Index].Config.IncrementOffset;
						SuperTrakPalletParameters[Index].AdvancedReleaseConfig.Direction			:= gSuperTrak.Par.Pallet[Index].Config.Direction;
							
						StPalletState[Index]		:= 1;
					END_IF;
				1:	// Update motion parameters for the commanded movement
					StPallet_[Index].SetPalletMotionPar											:= TRUE;
				
					// Once the update is complete, move to the next state in the state machine
					IF StPallet_[Index].CommandDone THEN
						StPallet_[Index].SetPalletMotionPar										:= FALSE;
						StPalletState[Index]													:= 2;
					END_IF;
				2:
					// Update destination target and travel direction for the commanded movement			
					StPallet_[Index].Update														:= TRUE;
				
					// Once the update is complete, move to the next state in the state machine
					IF StPallet_[Index].UpdateDone THEN
						StPallet_[Index].Update													:= FALSE;
						StPalletState[Index]													:= 3;
					END_IF;
				3:
					// Pass the ReleaseToTarget command onto the StTarget function block and execute
					CASE releaseModePallet[Index] OF
						0:		StPallet_[Index].ReleaseToTarget								:= TRUE;
						1:		StPallet_[Index].ReleaseToOffset								:= TRUE;
						2:		StPallet_[Index].IncrementOffset								:= TRUE;
					END_CASE;
						
					
					IF StPallet_[Index].CommandDone THEN
						StPallet_[Index].ReleaseToTarget										:= FALSE;
						StPallet_[Index].ReleaseToOffset										:= FALSE;
						StPallet_[Index].IncrementOffset										:= FALSE;
						StPalletState[Index]													:= 4;
					END_IF;
					
				4:	// Once the pallet is released, notify the main application w/ PalletReleased and reset the state machine
					gSuperTrak.Status.Pallet[Index].PalletReleased								:= TRUE;
					IF gSuperTrak.Par.Pallet[Index].ReleaseToTarget = FALSE AND gSuperTrak.Par.Pallet[Index].ReleaseToOffset = FALSE AND gSuperTrak.Par.Pallet[Index].IncrementOffset = FALSE THEN
						gSuperTrak.Status.Pallet[Index].PalletReleased							:= FALSE;
						StPalletState[Index]													:= 0;
					END_IF;
				5:
				6:
				7:
				8:
				9:
			END_CASE;
		END_FOR;
		
  
		// If the sections are not enabled, reset all commands
	ELSE
		// Loop thru all StTargetExt function blocks
		FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
			// Reset command
			StTargetExt_[Index].ReleaseToTarget   := FALSE;
		END_FOR;
	END_IF;
	
	
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* ERROR RESET TO FUNCTION BLOCKS *)
	
	// Apply global Error Reset command to StControl FUB
	IF StControl_0.StatusID <> 0 THEN
		StControl_0.ErrorReset						:= gSuperTrak.Cmds.ErrorReset;
	ELSE
		StControl_0.ErrorReset						:= FALSE;
	END_IF;
	
	// Apply global Error Reset command to StTarget FUB
	FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) -1 DO
		IF StTargetExt_[Index].StatusID <> 0 THEN
			StTargetExt_[Index].ErrorReset			:= gSuperTrak.Cmds.ErrorReset;
		ELSE
			StTargetExt_[Index].ErrorReset			:= FALSE;
		END_IF;
	END_FOR;
 
	// Apply global Error Reset command to StSection FUB
	FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
		IF StSection_[Index].StatusID <> 0 THEN
			StSection_[Index].ErrorReset			:= gSuperTrak.Cmds.ErrorReset;
		ELSE
			StSection_[Index].ErrorReset			:= FALSE;
		END_IF;
	END_FOR;
	
	// Apply global Error Reset command to StPallet FUB
	FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
		IF StPallet_[Index].StatusID <> 0 THEN
			StPallet_[Index].ErrorReset				:= gSuperTrak.Cmds.ErrorReset;
		ELSE
			StPallet_[Index].ErrorReset				:= FALSE;
		END_IF;
	END_FOR;
	

	(*************************************************************************************************)
	(*************************************************************************************************)
	(* FUNCTION BLOCK CALLS *)
 
	// Call StControl
	StControl_0();
 
	// Loop thru all StTargetExt function blocks
	FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
		// Call StSection
		StSection_[Index]();
	END_FOR;
 
	// Loop thru all StSection function blocks
	FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
		// Call StTargetExt
		StTargetExt_[Index]();
	END_FOR;
	
	// Loop thru all StPallet function blocks
	FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0]))-1 DO
		// Call StPallet
		StPallet_[Index]();
	END_FOR;
 
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* MAPPING OF STATUS VARIABLES *)
	
	SuperTrakGetPalletInfo(ADR(palletInfo),SIZEOF(palletInfo)/SIZEOF(palletInfo[0]),FALSE);
 
	//Actions to map status information into gSuperTrak structure
	
	ReadPNU;
//	WritePNU;
	GetStatus;

	
	
  
END_PROGRAM


