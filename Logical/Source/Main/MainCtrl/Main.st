


PROGRAM _INIT
		
	// Recovery positions can be utilized by start logic. By default, these values are utilized by the Pallets Recovering state.
	gSuperTrak.Par.System.RecoveryAccel			:= 2000;
	gSuperTrak.Par.System.RecoveryVelocity		:= 500;
	gSuperTrak.Par.System.RecoveryDirection		:= stCOM_DIR_RIGHT;
	gSuperTrak.Par.System.RecoveryTarget		:= 2;
	
	systemAccel		:= 20000;
	systemVelo		:= 2000;
			
	FOR index := 1 TO 20 DO
		targetTimer[index].PT				:= t#500ms;
	END_FOR;

	nextTarget	:= 5;
	
END_PROGRAM

PROGRAM _CYCLIC

	// Return the state machine to a DISABLED state when the system stops itself
	gSuperTrak.Status.System.Running				:= FALSE;
	IF gSuperTrak.Status.System.Enabled = FALSE THEN
		MainState									:= DISABLED;
	END_IF;
	
	// Return the state machine to a DISABLED state when commanded
	IF gSuperTrak.Cmds.Enable = FALSE THEN
		MainState									:= DISABLED;
	END_IF;


	// Primary state machine for the SuperTrak
	CASE MainState OF
		DISABLED://======================================================================================
			// System is unpowered. Track sections disabled
			// If stuck in this state, check that ST_CONFIG_MAX_SECTIONS is configured correctly

			gSuperTrak.Cmds.Start					:= FALSE;
			IF gSuperTrak.Cmds.Enable THEN
				MainState							:= BEGIN_ENABLE;
			END_IF;

		BEGIN_ENABLE://======================================================================================
			// Confirm system response

			IF gSuperTrak.Status.System.Enabled THEN
				MainState							:= START_RECOVERY;
			END_IF;

		START_RECOVERY://====================================================================================
			// Application-specific recovery logic can be built here. Based on default logic, shuttles need to reach their commanded
			// target to be considered 'ready'. Pallets in queue are not considered fully recovered.

			MainState								:= PALLETS_RECOVERING;

		PALLETS_RECOVERING://======================================================================================
			// Confirm system response. Move shuttles away from the Load Target so that trailing shuttles can reach this position also
		
			IF gSuperTrak.Status.Target[1].PalletPresent THEN
				
				gSuperTrak.Par.Target[1].Config.Acceleration		:= gSuperTrak.Par.System.RecoveryAccel;
				gSuperTrak.Par.Target[1].Config.Velocity			:= gSuperTrak.Par.System.RecoveryVelocity;
				gSuperTrak.Par.Target[1].Config.DestinationTarget	:= gSuperTrak.Par.System.RecoveryTarget;
				gSuperTrak.Par.Target[1].Config.Direction			:= gSuperTrak.Par.System.RecoveryDirection;
			
				gSuperTrak.Par.Target[1].ReleaseToTarget		:= TRUE;				
			ELSE
				gSuperTrak.Par.Target[1].ReleaseToTarget			:= FALSE;
			END_IF;


			// All sections must clear the 'Pallets Recovering' state to enter a Ready mode
			IF gSuperTrak.Status.System.Ready THEN
				MainState							:= READY;
			END_IF;

		READY://======================================================================================
			// System ready. Pallets located. Await RUN command.

			IF gSuperTrak.Cmds.Start THEN
				MainState							:= RUN;
				gSuperTrak.Status.System.Running	:= TRUE;
			END_IF;

		RUN://======================================================================================
			// RUN state. Application pallet routing goes here.
	
			gSuperTrak.Status.System.Running		:= TRUE;
			IF gSuperTrak.Cmds.Start = FALSE THEN
				MainState							:= BEGIN_STOP;
			END_IF;

			FOR index := 1 TO 20 DO
				targetTimer[index].IN				:= FALSE;
			END_FOR;
			
			
			//	----------------------------------------------------------------------- target 1
			
			IF gSuperTrak.Status.Target[1].PalletPresent THEN
				
				targetTimer[1].IN		:= TRUE;
				
				IF targetTimer[1].Q THEN
					gSuperTrak.Par.Target[1].Config.Acceleration		:= systemAccel;
					gSuperTrak.Par.Target[1].Config.Velocity			:= systemVelo;
					gSuperTrak.Par.Target[1].Config.DestinationTarget	:= 2;
					gSuperTrak.Par.Target[1].Config.Direction			:= stCOM_DIR_RIGHT;
					
					gSuperTrak.Par.Target[1].ReleaseToTarget			:= TRUE;
				END_IF;			
			ELSE
				gSuperTrak.Par.Target[1].ReleaseToTarget				:= FALSE;
			END_IF;
			
			
			//	----------------------------------------------------------------------- target 2
			
			IF gSuperTrak.Status.Target[2].PalletPresent THEN
				targetTimer[2].IN			:= TRUE;
				
				IF targetTimer[2].Q THEN
					gSuperTrak.Par.Target[2].Config.Acceleration		:= systemAccel;
					gSuperTrak.Par.Target[2].Config.Velocity			:= systemVelo;
					gSuperTrak.Par.Target[2].Config.DestinationTarget	:= 3;
					gSuperTrak.Par.Target[2].Config.Direction			:= stCOM_DIR_RIGHT;
			
					gSuperTrak.Par.Target[2].ReleaseToTarget		:= TRUE;
				END_IF;
				
			ELSE
				gSuperTrak.Par.Target[2].ReleaseToTarget			:= FALSE;
			END_IF;

			
			//	----------------------------------------------------------------------- target 3
			
			IF EDGENEG( gSuperTrak.Status.Target[3].PalletPresent ) THEN
				CASE nextTarget OF
					4:	nextTarget := 5;
					5:	nextTarget := 4;
				END_CASE;
			END_IF;
			
			
			IF gSuperTrak.Status.Target[3].PalletPresent THEN
				targetTimer[3].IN			:= TRUE;
				
				IF targetTimer[3].Q THEN
					gSuperTrak.Par.Target[3].Config.Acceleration		:= systemAccel;
					gSuperTrak.Par.Target[3].Config.Velocity			:= systemVelo;
					gSuperTrak.Par.Target[3].Config.DestinationTarget	:= nextTarget;
					gSuperTrak.Par.Target[3].Config.Direction			:= stCOM_DIR_RIGHT;
			
					gSuperTrak.Par.Target[3].ReleaseToTarget		:= TRUE;
				END_IF;
				
			ELSE
				gSuperTrak.Par.Target[3].ReleaseToTarget			:= FALSE;
			END_IF;

			
			//	----------------------------------------------------------------------- targets 4 & 5
			
			IF gSuperTrak.Status.Target[4].PalletPresent AND gSuperTrak.Status.Target[5].PalletPresent THEN
				
				targetTimer[4].IN			:= TRUE;
				
				IF targetTimer[4].Q THEN
					gSuperTrak.Par.Target[5].Config.Acceleration		:= systemAccel;
					gSuperTrak.Par.Target[5].Config.Velocity			:= systemVelo;
					gSuperTrak.Par.Target[5].Config.DestinationTarget	:= 6;
					gSuperTrak.Par.Target[5].Config.Direction			:= stCOM_DIR_RIGHT;
					
					gSuperTrak.Par.Target[4].Config.Acceleration		:= systemAccel;
					gSuperTrak.Par.Target[4].Config.Velocity			:= systemVelo;
					gSuperTrak.Par.Target[4].Config.DestinationTarget	:= 6;
					gSuperTrak.Par.Target[4].Config.Direction			:= stCOM_DIR_RIGHT;
					
					gSuperTrak.Par.Target[4].ReleaseToTarget		:= TRUE;
					gSuperTrak.Par.Target[5].ReleaseToTarget		:= TRUE;
				END_IF;
			ELSE
				gSuperTrak.Par.Target[4].ReleaseToTarget		:= FALSE;
				gSuperTrak.Par.Target[5].ReleaseToTarget		:= FALSE;
			END_IF;
			
			
			//	----------------------------------------------------------------------- target 6
			
			blueZoneClear		:= TRUE;
			FOR index := 0 TO CONFIG_ST_MAX_PALLETS DO
				IF gSuperTrak.Status.Pallet[index].Section = 2 THEN
					blueZoneClear	:= FALSE;
				END_IF;
			END_FOR;
			
			IF gSuperTrak.Status.Target[6].PalletPresent AND blueZoneClear THEN
				targetTimer[6].IN			:= TRUE;
				
				IF targetTimer[6].Q THEN
					gSuperTrak.Par.Target[6].Config.Acceleration		:= systemAccel;
					gSuperTrak.Par.Target[6].Config.Velocity			:= systemVelo;
					gSuperTrak.Par.Target[6].Config.DestinationTarget	:= 2;
					gSuperTrak.Par.Target[6].Config.Direction			:= stCOM_DIR_RIGHT;
			
					gSuperTrak.Par.Target[6].ReleaseToTarget		:= TRUE;
				END_IF;
				
			ELSE
				gSuperTrak.Par.Target[6].ReleaseToTarget			:= FALSE;
			END_IF;

			
			
			
			gSuperTrak.Status.Target[1].PalletId;
			
			


			
			
			

			
			(****************	ENTER TARGET LOGIC HERE		****************)

			
			
			//			IF gSuperTrak.Status.Target[targetNum].PalletPresent THEN
			//				targetTimer[targetNum].IN			:= TRUE;
			//				
			//				IF targetTimer[targetNum].Q THEN
			//					gSuperTrak.Par.Target[targetNum].Config.Acceleration		:= systemAccel;
			//					gSuperTrak.Par.Target[targetNum].Config.Velocity			:= systemVelo;
			//					gSuperTrak.Par.Target[targetNum].Config.DestinationTarget	:= destination;
			//					gSuperTrak.Par.Target[targetNum].Config.Direction			:= stCOM_DIR_RIGHT;
			//			
			//					gSuperTrak.Par.Target[targetNum].ReleaseToTarget		:= TRUE;
			//				END_IF;
			//				
			//			ELSE
			//				gSuperTrak.Par.Target[targetNum].ReleaseToTarget			:= FALSE;
			//			END_IF;


			
			
			//----------------------------------------------------------------
			

			


		BEGIN_STOP://==========================================================================================
			// Single-tick state for setting system stop commands

			FOR index := 1 TO CONFIG_ST_MAX_PALLETS DO
				gSuperTrak.Par.Target[index].ReleaseToTarget						:= FALSE;
			END_FOR;

			FOR index := 1 TO CONFIG_ST_MAX_PALLETS DO
				IF gSuperTrak.Status.Pallet[index].PalletAllocated THEN

					gSuperTrak.Par.Pallet[index].Config.Acceleration				:= gSuperTrak.Par.System.RecoveryAccel;
					gSuperTrak.Par.Pallet[index].Config.Velocity					:= gSuperTrak.Par.System.RecoveryVelocity;
					gSuperTrak.Par.Pallet[index].Config.DestinationTarget			:= gSuperTrak.Par.System.RecoveryTarget;
					gSuperTrak.Par.Pallet[index].Config.Direction					:= gSuperTrak.Par.System.RecoveryDirection;

					gSuperTrak.Par.Pallet[index].ReleaseToTarget					:= TRUE;

				END_IF;
			END_FOR;

			MainState															:= STOPPING;



		STOPPING://========================================================================================
			// Application halt logic goes here.

			FOR index := 0 TO CONFIG_ST_MAX_PALLETS DO
				gSuperTrak.Par.Pallet[index].ReleaseToTarget						:= FALSE;
			END_FOR;

			MainState																:= READY;


		ERROR://==========================================================================================
			// Empty state. Placeholder for additional application logic.

		RESETTING://======================================================================================
			// Empty state. Placeholder for additional application logic.

		TEST://===========================================================================================
		// Empty state. Enter for debugging purposes.

	END_CASE;



	// Function block calls
	FOR index := 0 TO 20 DO
		targetTimer[index]();
	END_FOR;


END_PROGRAM
