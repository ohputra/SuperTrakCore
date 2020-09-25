
TYPE
	MainState_enum : 
		( (*State machine for main application*)
		DISABLED, (*SuperTrak is powered Off*)
		BEGIN_ENABLE, (*SuperTrak is powering On*)
		START_RECOVERY, (*Begin pallet recovery operation*)
		PALLETS_RECOVERING, (*Pallets currently moving to a recovery target*)
		BEGIN_STOP, (*Single-cycle state to set controlled-stop behavior*)
		STOPPING, (*System executing a controlled stop*)
		READY, (*Powering complete. Ready to begin pallet routing*)
		RUN, (*Pallet routing active*)
		ERROR, (*System in error mode*)
		RESETTING, (*System resetting from error condition*)
		TEST (*Empty case in state machine for debugging through watch window*)
		);
END_TYPE
