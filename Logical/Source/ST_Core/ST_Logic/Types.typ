(************************************************************************************************************************************)
(************************************************************************************************************************************)
(*Structures for SuperTrak control*)

TYPE
	SuperTrakCtrlType : 	STRUCT  (*Control structure for SuperTrak*)
		Command : SuperTrakCtrlCmdType; (*SuperTrak commands*)
		Parameter : SuperTrakCtrlParType; (*SuperTrak parameters*)
		Status : SuperTrakCtrlStatType; (*SuperTrak status*)
	END_STRUCT;
	SuperTrakCtrlCmdType : 	STRUCT  (*Command strucutre for SuperTrak*)
		EnableAllSections : BOOL; (*Command to enable all sections on the system*)
	END_STRUCT;
	SuperTrakCtrlParType : 	STRUCT  (*Parameter structure for SuperTrak*)
		Reserved : BOOL; (*Reserved for future development*)
	END_STRUCT;
	SuperTrakCtrlStatType : 	STRUCT  (*Status strucutre for SuperTrak*)
		AllSectionsEnabled : BOOL; (*Indicating if all sections on the system are enabled*)
	END_STRUCT;
	ReleaseStates_enum : 
		(
		WAIT,
		SET_VEL,
		RELEASE,
		ERROR
		);
	WriteState_enum : 
		(
		WS_WAIT,
		WS_SET_PARAMETERS,
		WS_WRITE,
		WS_APPLY,
		WS_ITERATE_SECTION,
		WS_DEBUG
		);
	ReadState_enum : 
		(
		RS_WAIT := 0,
		RS_SET_PARAMETERS := 1,
		RS_READ := 2,
		RS_APPLY := 3,
		RS_ITERATE_SECTION := 4,
		RS_DEBUG := 5
		);
	Buffer_typ : 	STRUCT 
		Entry : ARRAY[0..60]OF UINT;
	END_STRUCT;
END_TYPE
