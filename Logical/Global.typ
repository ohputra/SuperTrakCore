
TYPE
	SysCmds_typ : 	STRUCT  (*System-wide commands to control SuperTrak*)
		Enable : BOOL; (*Commands sections to power on and locate pallets*)
		Start : BOOL; (*Begin application code & pallet routing*)
		ErrorReset : BOOL; (*Acknowledges recoverable & inactive errors*)
	END_STRUCT;
	SysPalletPar_typ : 	STRUCT  (*Configuration parameters for Pallet commands*)
		Config : SysReleaseConfig_typ; (*Includes motion parameters for specific pallet*)
		IncrementOffset : BOOL; (*Command to add a specific offset to the pallet at the target (e.g. for calibration) Relative*)
		ReleaseToOffset : BOOL; (*Command to add a specific offset to the pallet at the target (e.g. for calibration) Absolute*)
		ReleaseToTarget : BOOL; (*Command to release the pallet ID to a specified destination target*)
		Synchronize : BOOL;
	END_STRUCT;
	SysPalletStatus_typ : 	STRUCT  (*Status information for Pallets*)
		Section : USINT; (*Pallet current section*)
		Position : REAL; (*Pallet current position along section*)
		Velocity : REAL; (*Pallet current set velocity*)
		Acceleration : REAL; (*Pallet current set acceleration*)
		PalletReleased : BOOL; (*Pallet has been released. Used to acknowledge ReleaseToTarget command*)
		PalletAllocated : BOOL;
		DestinationTarget : UINT;
	END_STRUCT;
	SysPar_typ : 	STRUCT  (*Configuration parameters for System commands*)
		System : SysSystemPar_typ; (*System-wide parameters*)
		Pallet : ARRAY[0..CONFIG_ST_MAX_PALLETS]OF SysPalletPar_typ; (*Pallet-specific parameters*)
		Target : ARRAY[0..CONFIG_ST_MAX_TARGETS]OF SysTargetsPar_typ; (*Target-specific parameters*)
	END_STRUCT;
	SysReleaseConfig_typ : 	STRUCT  (*Release configuration type*)
		TargetOffset : REAL;
		Velocity : UINT; (*Set velocity for next movement [mm/s]*)
		Acceleration : UINT; (*Set acceleration for next movement [mm/s2]*)
		Direction : StParamAdvReleaseConfigDirEnum; (*Direction of movement (assumes facing an upright track). Can use constants: stCOM_DIR_RIGHT, stCOM_DIR_LEFT*)
		DestinationTarget : USINT; (*Destination target of an absolute movement*)
		IncrementOffset : REAL;
		SyncTarget : UDINT;
	END_STRUCT;
	SysSectionDetails_typ : 	STRUCT  (*Status information for specific section*)
		MotorTemp : ARRAY[0..5]OF REAL; (*Motor temperatures [C]. Each section has 10 temp sensors*)
		MotorVoltage : REAL; (*Motor voltage [V]*)
		ElectronicsTemp : REAL; (*Electronics temps [C]*)
	END_STRUCT;
	SysSectionDiag_typ : 	STRUCT  (*Diagnostic information for a section*)
		Enabled : BOOL; (*Section is enabled*)
		UnrecPallPresent : BOOL; (*Indicates whether pallets on the section are not recognized*)
		MotorPowerOn : BOOL; (*Indicates whether the motor power is on*)
		PalletsRecovering : BOOL; (*Indicates whether pallets are currently recovering*)
		LocatingPallets : BOOL; (*Indicates whether pallets are being automatically 'jogged' so that their location can be determined*)
		DisabledExternally : BOOL; (*Indicates if the section is disabled due to an external condition*)
		WarningActive : BOOL;
		FaultActive : BOOL;
		Warnings : ARRAY[0..31]OF BOOL; (*Warning bits for the section- used as alarm conditions*)
		Faults : ARRAY[0..31]OF BOOL; (*Fault bits for the section- usued as alarm conditions*)
	END_STRUCT;
	SysSectionStatus_typ : 	STRUCT  (*Status categories for sections*)
		Right : SysSectionDetails_typ; (*Right driver board*)
		Diag : SysSectionDiag_typ; (*Diagnostics information*)
		Left : SysSectionDetails_typ; (*Left driver board*)
		IsCurveSection : BOOL; (*Determines if the section is a curve or not*)
	END_STRUCT;
	SysStatus_typ : 	STRUCT  (*Status categories*)
		System : SysSystemStatus_typ; (*System-wide status*)
		Section : ARRAY[0..CONFIG_ST_MAX_SECTIONS]OF SysSectionStatus_typ; (*Individual section status*)
		Target : ARRAY[0..CONFIG_ST_MAX_TARGETS]OF SysTargetStatus_typ; (*Individual target status*)
		Pallet : ARRAY[0..CONFIG_ST_MAX_PALLETS]OF SysPalletStatus_typ; (*Individual pallet status*)
	END_STRUCT;
	SysSystemPar_typ : 	STRUCT  (*System-wide configuration parameters*)
		RecoveryTarget : USINT; (*Defines a target for pallets to recover to after a system halt*)
		RecoveryDirection : StParamAdvReleaseConfigDirEnum; (*Defines a direction for pallets to head towards the recovery target*)
		RecoveryAccel : UINT; (*Defines an acceleration parameter for pallets while moving towards a recovery target*)
		RecoveryVelocity : UINT; (*Defines a maximum velocity for pallets while moving towards a recovery target*)
	END_STRUCT;
	SysSystemStatus_typ : 	STRUCT  (*System-wide status information*)
		Enabled : BOOL; (*Indicates that all sections are powered*)
		Ready : BOOL; (*Indicates that sections are powered and shuttles have been located*)
		Running : BOOL; (*Indicates that the application code is active and shuttle routing is underway *)
		WarningActive : BOOL; (*Indicates that at least one system warning is active*)
		FaultsActive : BOOL; (*Indicates that at least one system fault is active*)
		Warnings : ARRAY[0..31]OF BOOL; (*Alarm status bits for system warnings*)
		Faults : ARRAY[0..31]OF BOOL; (*Alarm status bits for system faults*)
		ActiveSections : USINT;
		ActivePallets : USINT; (*Counts number of active pallets on the system*)
		EMA_Throughput : REAL := 0.0; (*Calculates Exponential Moving Average of the throughput*)
		Throughput : REAL; (*Calculates instantaneous system throughput*)
	END_STRUCT;
	SysTargetsPar_typ : 	STRUCT  (*Target configuration parameters*)
		Config : SysReleaseConfig_typ; (*Motion parameter configuration datatype*)
		IncrementOffset : BOOL; (*Command to add a specific offset to the pallet at the target (e.g. for calibration) Relative*)
		ReleaseToOffset : BOOL; (*Command to add a specific offset to the pallet at the target (e.g. for calibration) Absolute*)
		ReleaseToTarget : BOOL; (*Command to release the pallet at the target to a specified destination target*)
	END_STRUCT;
	SysTargetStatus_typ : 	STRUCT  (*Target status information. Used to detect pallet presence & ID*)
		PalletId : USINT; (*Pallet ID*)
		PalletReleased : BOOL; (*Pallet has been released. Used to acknowledge ReleaseToTarget command*)
		PalletPreArrival : BOOL; (*Pallet is about to arrive at the target*)
		PalletPresent : BOOL; (*Pallet is detected at the target*)
		Section : UINT; (*Configured Section for the target*)
		Position : REAL; (*Configured Position for the target [mm]*)
		PalletHovering : BOOL; (*Pallet is detected over (but not necessarily destined for) a target with Hover enabled*)
	END_STRUCT;
	SysTrak_typ : 	STRUCT  (*High level control structure for handling the SuperTrak system*)
		Cmds : SysCmds_typ; (*Commands datatype. INPUTS to the SuperTrak*)
		Par : SysPar_typ; (*Parameters datatype. INPUTS to the SuperTrak*)
		Status : SysStatus_typ; (*Status datatype. OUTPUTS from the SuperTrak*)
	END_STRUCT;
END_TYPE
