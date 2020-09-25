
ACTION GetStatus: 
	
	// This action maps all status bits from StControl, StPallet, and StTarget into the gSuperTrak global structure
	
	gSuperTrak.Status.System.Enabled   								:= StControl_0.SectionsEnabled;
	
	gSuperTrak.Status.System.FaultsActive							:= StControl_0.Info.SuperTrak.SystemFaultActive;
	gSuperTrak.Status.System.WarningActive							:= StControl_0.Info.SuperTrak.SystemWarningActive;
	
	// Would like to iterate through a FOR loop, but the bitwise structure of StControl prevents this.
	gSuperTrak.Status.System.Warnings[0]							:= StControl_0.Info.SuperTrak.SystemWarningBits.0;
	gSuperTrak.Status.System.Warnings[1]							:= StControl_0.Info.SuperTrak.SystemWarningBits.1;
	gSuperTrak.Status.System.Warnings[2]							:= StControl_0.Info.SuperTrak.SystemWarningBits.2;
	gSuperTrak.Status.System.Warnings[3]							:= StControl_0.Info.SuperTrak.SystemWarningBits.3;
	gSuperTrak.Status.System.Warnings[4]							:= StControl_0.Info.SuperTrak.SystemWarningBits.4;
	gSuperTrak.Status.System.Warnings[5]							:= StControl_0.Info.SuperTrak.SystemWarningBits.5;
	gSuperTrak.Status.System.Warnings[6]							:= StControl_0.Info.SuperTrak.SystemWarningBits.6;
	gSuperTrak.Status.System.Warnings[7]							:= StControl_0.Info.SuperTrak.SystemWarningBits.7;
	gSuperTrak.Status.System.Warnings[8]							:= StControl_0.Info.SuperTrak.SystemWarningBits.8;
	gSuperTrak.Status.System.Warnings[9]							:= StControl_0.Info.SuperTrak.SystemWarningBits.9;
	gSuperTrak.Status.System.Warnings[10]							:= StControl_0.Info.SuperTrak.SystemWarningBits.10;
	gSuperTrak.Status.System.Warnings[11]							:= StControl_0.Info.SuperTrak.SystemWarningBits.11;
	gSuperTrak.Status.System.Warnings[12]							:= StControl_0.Info.SuperTrak.SystemWarningBits.12;
	gSuperTrak.Status.System.Warnings[13]							:= StControl_0.Info.SuperTrak.SystemWarningBits.13;
	gSuperTrak.Status.System.Warnings[14]							:= StControl_0.Info.SuperTrak.SystemWarningBits.14;
	gSuperTrak.Status.System.Warnings[15]							:= StControl_0.Info.SuperTrak.SystemWarningBits.15;
	gSuperTrak.Status.System.Warnings[16]							:= StControl_0.Info.SuperTrak.SystemWarningBits.16;
	gSuperTrak.Status.System.Warnings[17]							:= StControl_0.Info.SuperTrak.SystemWarningBits.17;
	gSuperTrak.Status.System.Warnings[18]							:= StControl_0.Info.SuperTrak.SystemWarningBits.18;
	gSuperTrak.Status.System.Warnings[19]							:= StControl_0.Info.SuperTrak.SystemWarningBits.19;
	gSuperTrak.Status.System.Warnings[20]							:= StControl_0.Info.SuperTrak.SystemWarningBits.20;
	gSuperTrak.Status.System.Warnings[21]							:= StControl_0.Info.SuperTrak.SystemWarningBits.21;
	gSuperTrak.Status.System.Warnings[22]							:= StControl_0.Info.SuperTrak.SystemWarningBits.22;
	gSuperTrak.Status.System.Warnings[23]							:= StControl_0.Info.SuperTrak.SystemWarningBits.23;
	gSuperTrak.Status.System.Warnings[24]							:= StControl_0.Info.SuperTrak.SystemWarningBits.24;
	gSuperTrak.Status.System.Warnings[25]							:= StControl_0.Info.SuperTrak.SystemWarningBits.25;
	gSuperTrak.Status.System.Warnings[26]							:= StControl_0.Info.SuperTrak.SystemWarningBits.26;
	gSuperTrak.Status.System.Warnings[27]							:= StControl_0.Info.SuperTrak.SystemWarningBits.27;
	gSuperTrak.Status.System.Warnings[28]							:= StControl_0.Info.SuperTrak.SystemWarningBits.28;
	gSuperTrak.Status.System.Warnings[29]							:= StControl_0.Info.SuperTrak.SystemWarningBits.29;
	gSuperTrak.Status.System.Warnings[30]							:= StControl_0.Info.SuperTrak.SystemWarningBits.30;
	
	gSuperTrak.Status.System.Faults[0]								:= StControl_0.Info.SuperTrak.SystemFaultBits.0;
	gSuperTrak.Status.System.Faults[1]								:= StControl_0.Info.SuperTrak.SystemFaultBits.1;
	gSuperTrak.Status.System.Faults[2]								:= StControl_0.Info.SuperTrak.SystemFaultBits.2;
	gSuperTrak.Status.System.Faults[3]								:= StControl_0.Info.SuperTrak.SystemFaultBits.3;
	gSuperTrak.Status.System.Faults[4]								:= StControl_0.Info.SuperTrak.SystemFaultBits.4;
	gSuperTrak.Status.System.Faults[5]								:= StControl_0.Info.SuperTrak.SystemFaultBits.5;
	gSuperTrak.Status.System.Faults[6]								:= StControl_0.Info.SuperTrak.SystemFaultBits.6;
	gSuperTrak.Status.System.Faults[7]								:= StControl_0.Info.SuperTrak.SystemFaultBits.7;
	gSuperTrak.Status.System.Faults[8]								:= StControl_0.Info.SuperTrak.SystemFaultBits.8;
	gSuperTrak.Status.System.Faults[9]								:= StControl_0.Info.SuperTrak.SystemFaultBits.9;
	gSuperTrak.Status.System.Faults[10]								:= StControl_0.Info.SuperTrak.SystemFaultBits.10;
	gSuperTrak.Status.System.Faults[11]								:= StControl_0.Info.SuperTrak.SystemFaultBits.11;
	gSuperTrak.Status.System.Faults[12]								:= StControl_0.Info.SuperTrak.SystemFaultBits.12;
	gSuperTrak.Status.System.Faults[13]								:= StControl_0.Info.SuperTrak.SystemFaultBits.13;
	gSuperTrak.Status.System.Faults[14]								:= StControl_0.Info.SuperTrak.SystemFaultBits.14;
	gSuperTrak.Status.System.Faults[15]								:= StControl_0.Info.SuperTrak.SystemFaultBits.15;
	gSuperTrak.Status.System.Faults[16]								:= StControl_0.Info.SuperTrak.SystemFaultBits.16;
	gSuperTrak.Status.System.Faults[17]								:= StControl_0.Info.SuperTrak.SystemFaultBits.17;
	gSuperTrak.Status.System.Faults[18]								:= StControl_0.Info.SuperTrak.SystemFaultBits.18;
	gSuperTrak.Status.System.Faults[19]								:= StControl_0.Info.SuperTrak.SystemFaultBits.19;
	gSuperTrak.Status.System.Faults[20]								:= StControl_0.Info.SuperTrak.SystemFaultBits.20;
	gSuperTrak.Status.System.Faults[21]								:= StControl_0.Info.SuperTrak.SystemFaultBits.21;
	gSuperTrak.Status.System.Faults[22]								:= StControl_0.Info.SuperTrak.SystemFaultBits.22;
	gSuperTrak.Status.System.Faults[23]								:= StControl_0.Info.SuperTrak.SystemFaultBits.23;
	gSuperTrak.Status.System.Faults[24]								:= StControl_0.Info.SuperTrak.SystemFaultBits.24;
	gSuperTrak.Status.System.Faults[25]								:= StControl_0.Info.SuperTrak.SystemFaultBits.25;
	gSuperTrak.Status.System.Faults[26]								:= StControl_0.Info.SuperTrak.SystemFaultBits.26;
	gSuperTrak.Status.System.Faults[27]								:= StControl_0.Info.SuperTrak.SystemFaultBits.27;
	gSuperTrak.Status.System.Faults[28]								:= StControl_0.Info.SuperTrak.SystemFaultBits.28;
	gSuperTrak.Status.System.Faults[29]								:= StControl_0.Info.SuperTrak.SystemFaultBits.29;
	gSuperTrak.Status.System.Faults[30]								:= StControl_0.Info.SuperTrak.SystemFaultBits.30;
	
	
	// Start by assuming system is Ready. Code below conditionally resets
	gSuperTrak.Status.System.Ready									:= TRUE;
	
	// Start by assuming zero active sections. Code below conditionally resets
	gSuperTrak.Status.System.ActiveSections							:= 0;
	
	FOR Index := 0 TO SIZEOF(StSection_) / SIZEOF(StSection_[0]) - 1 DO
		
		// Then count sections with a Status other than zero
		IF StSection_[Index].Section <> 0 THEN
			gSuperTrak.Status.System.ActiveSections					:= gSuperTrak.Status.System.ActiveSections + 1;	
		END_IF;		
		
		// Verbose mapping of status bits to gSuperTrak structure
		gSuperTrak.Status.Section[Index].Diag.Enabled				:= StSection_[Index].SectionEnabled;
		gSuperTrak.Status.Section[Index].Diag.UnrecPallPresent		:= StSection_[Index].UnrecognizedPallets;
		gSuperTrak.Status.Section[Index].Diag.MotorPowerOn			:= StSection_[Index].MotorPowerOn;
		gSuperTrak.Status.Section[Index].Diag.PalletsRecovering		:= StSection_[Index].PalletsRecovering;
		gSuperTrak.Status.Section[Index].Diag.LocatingPallets		:= StSection_[Index].LocatingPallets;
		gSuperTrak.Status.Section[Index].Diag.DisabledExternally	:= StSection_[Index].DisabledExternally OR StSection_[Index].Info.SuperTrak.SectionFaultBits.28;
		
		gSuperTrak.Status.Section[Index].Diag.FaultActive			:= StSection_[Index].Info.SuperTrak.SectionFaultActive;
		gSuperTrak.Status.Section[Index].Diag.WarningActive			:= StSection_[Index].Info.SuperTrak.SectionWarningActive;
		
		gSuperTrak.Status.Section[Index].Diag.Faults[0]				:= StSection_[Index].Info.SuperTrak.SectionFaultBits.0;		
		gSuperTrak.Status.Section[Index].Diag.Faults[1]				:= StSection_[Index].Info.SuperTrak.SectionFaultBits.1;
		gSuperTrak.Status.Section[Index].Diag.Faults[2]				:= StSection_[Index].Info.SuperTrak.SectionFaultBits.2;
		gSuperTrak.Status.Section[Index].Diag.Faults[3]				:= StSection_[Index].Info.SuperTrak.SectionFaultBits.3;
		gSuperTrak.Status.Section[Index].Diag.Faults[4]				:= StSection_[Index].Info.SuperTrak.SectionFaultBits.4;
		gSuperTrak.Status.Section[Index].Diag.Faults[5]				:= StSection_[Index].Info.SuperTrak.SectionFaultBits.5;
		gSuperTrak.Status.Section[Index].Diag.Faults[6]				:= StSection_[Index].Info.SuperTrak.SectionFaultBits.6;
		gSuperTrak.Status.Section[Index].Diag.Faults[7]				:= StSection_[Index].Info.SuperTrak.SectionFaultBits.7;
		gSuperTrak.Status.Section[Index].Diag.Faults[8]				:= StSection_[Index].Info.SuperTrak.SectionFaultBits.8;
		gSuperTrak.Status.Section[Index].Diag.Faults[9]				:= StSection_[Index].Info.SuperTrak.SectionFaultBits.9;
		gSuperTrak.Status.Section[Index].Diag.Faults[10]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.10;
		gSuperTrak.Status.Section[Index].Diag.Faults[11]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.11;
		gSuperTrak.Status.Section[Index].Diag.Faults[12]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.12;
		gSuperTrak.Status.Section[Index].Diag.Faults[13]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.13;
		gSuperTrak.Status.Section[Index].Diag.Faults[14]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.14;
		gSuperTrak.Status.Section[Index].Diag.Faults[15]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.15;
		gSuperTrak.Status.Section[Index].Diag.Faults[16]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.16;
		gSuperTrak.Status.Section[Index].Diag.Faults[17]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.17;
		gSuperTrak.Status.Section[Index].Diag.Faults[18]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.18;
		gSuperTrak.Status.Section[Index].Diag.Faults[19]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.19;
		gSuperTrak.Status.Section[Index].Diag.Faults[20]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.20;
		gSuperTrak.Status.Section[Index].Diag.Faults[21]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.21;
		gSuperTrak.Status.Section[Index].Diag.Faults[22]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.22;
		gSuperTrak.Status.Section[Index].Diag.Faults[23]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.23;
		gSuperTrak.Status.Section[Index].Diag.Faults[24]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.24;
		gSuperTrak.Status.Section[Index].Diag.Faults[25]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.25;
		gSuperTrak.Status.Section[Index].Diag.Faults[26]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.26;
		gSuperTrak.Status.Section[Index].Diag.Faults[27]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.27;
		gSuperTrak.Status.Section[Index].Diag.Faults[28]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.28;
		gSuperTrak.Status.Section[Index].Diag.Faults[29]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.29;
		gSuperTrak.Status.Section[Index].Diag.Faults[30]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.30;
		gSuperTrak.Status.Section[Index].Diag.Faults[31]			:= StSection_[Index].Info.SuperTrak.SectionFaultBits.31;
		
		gSuperTrak.Status.Section[Index].Diag.Warnings[0]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.0;
		gSuperTrak.Status.Section[Index].Diag.Warnings[1]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.1;
		gSuperTrak.Status.Section[Index].Diag.Warnings[2]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.2;
		gSuperTrak.Status.Section[Index].Diag.Warnings[3]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.3;
		gSuperTrak.Status.Section[Index].Diag.Warnings[4]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.4;
		gSuperTrak.Status.Section[Index].Diag.Warnings[5]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.5;
		gSuperTrak.Status.Section[Index].Diag.Warnings[6]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.6;
		gSuperTrak.Status.Section[Index].Diag.Warnings[7]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.7;
		gSuperTrak.Status.Section[Index].Diag.Warnings[8]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.8;
		gSuperTrak.Status.Section[Index].Diag.Warnings[9]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.9;
		gSuperTrak.Status.Section[Index].Diag.Warnings[10]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.10;
		gSuperTrak.Status.Section[Index].Diag.Warnings[11]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.11;
		gSuperTrak.Status.Section[Index].Diag.Warnings[12]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.12;
		gSuperTrak.Status.Section[Index].Diag.Warnings[13]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.13;
		gSuperTrak.Status.Section[Index].Diag.Warnings[14]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.14;
		gSuperTrak.Status.Section[Index].Diag.Warnings[15]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.15;
		gSuperTrak.Status.Section[Index].Diag.Warnings[16]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.16;
		gSuperTrak.Status.Section[Index].Diag.Warnings[17]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.17;
		gSuperTrak.Status.Section[Index].Diag.Warnings[18]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.18;
		gSuperTrak.Status.Section[Index].Diag.Warnings[19]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.19;
		gSuperTrak.Status.Section[Index].Diag.Warnings[20]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.20;
		gSuperTrak.Status.Section[Index].Diag.Warnings[21]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.21;
		gSuperTrak.Status.Section[Index].Diag.Warnings[22]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.22;
		gSuperTrak.Status.Section[Index].Diag.Warnings[23]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.23;
		gSuperTrak.Status.Section[Index].Diag.Warnings[24]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.24;
		gSuperTrak.Status.Section[Index].Diag.Warnings[25]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.25;
		gSuperTrak.Status.Section[Index].Diag.Warnings[26]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.26;
		gSuperTrak.Status.Section[Index].Diag.Warnings[27]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.27;
		gSuperTrak.Status.Section[Index].Diag.Warnings[28]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.28;
		gSuperTrak.Status.Section[Index].Diag.Warnings[29]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.29;
		gSuperTrak.Status.Section[Index].Diag.Warnings[30]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.30;
		gSuperTrak.Status.Section[Index].Diag.Warnings[31]			:= StSection_[Index].Info.SuperTrak.SectionWarningBits.31;
		
		// Status Ready bit. Pallets should be recovered and all sections 
		IF Index <> 0 THEN
			IF (gSuperTrak.Status.Section[Index].Diag.Enabled = FALSE) OR (gSuperTrak.Status.Section[Index].Diag.PalletsRecovering = TRUE) OR (gSuperTrak.Status.Section[Index].Diag.LocatingPallets = TRUE) THEN
				gSuperTrak.Status.System.Ready						:= FALSE;
			END_IF;
		END_IF;
	END_FOR;
	
	// Map target status bits to gSuperTrak
	FOR Index := 0 TO SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])-1 DO
		gSuperTrak.Status.Target[Index].PalletId					:= StTargetExt_[Index].PalletID;
		gSuperTrak.Status.Target[Index].PalletPresent				:= StTargetExt_[Index].PalletPresent;
		gSuperTrak.Status.Target[Index].PalletPreArrival			:= StTargetExt_[Index].PalletPreArrival;
		gSuperTrak.Status.Target[Index].PalletHovering				:= StTargetExt_[Index].PalletOverTarget;
	END_FOR;
	
	// Start by assuming active pallets zero
	gSuperTrak.Status.System.ActivePallets							:= 0;

	// Calculation for instantaneous throughput of shuttles [shuttles/s]
	// AverageShuttleVelocity [m/s] * ShuttleCount [] / TotalTrackLength [m]
	// Start AverageShuttleVelocity calculation by assuming totalVelocity is zero
	totalVelocity													:= 0;
	
	FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0]))-2 DO
		
		// Map pallet status bits to gSuperTrak
		gSuperTrak.Status.Pallet[Index+1].Position					:= DINT_TO_REAL(palletInfo[Index].position) / 1000.0;
		gSuperTrak.Status.Pallet[Index+1].Section					:= palletInfo[Index].section;
		gSuperTrak.Status.Pallet[Index+1].PalletAllocated			:= (palletInfo[Index].status <> 0);
		
		// For active pallets, sum all velocities
		IF gSuperTrak.Status.Pallet[Index+1].PalletAllocated THEN
			gSuperTrak.Status.System.ActivePallets					:= gSuperTrak.Status.System.ActivePallets + 1;
			totalVelocity											:= totalVelocity + gSuperTrak.Status.Pallet[Index+1].Velocity / 1000.0;			
		END_IF;
		
	END_FOR;
	
	// Protect div0
	IF gSuperTrak.Status.System.ActiveSections <> 0 AND gSuperTrak.Status.System.ActivePallets <> 0 THEN
		// Divide by shuttle count to calculate AverageShuttleVelocity
		averageVelocity											:= totalVelocity / USINT_TO_REAL(gSuperTrak.Status.System.ActivePallets);
		// Calculate system throughput [shuttles/min]
		gSuperTrak.Status.System.Throughput						:= USINT_TO_REAL(gSuperTrak.Status.System.ActivePallets) * averageVelocity * 60.0 / USINT_TO_REAL(gSuperTrak.Status.System.ActiveSections);
		// Calculate Exponential weighted moving average. Weighting factor 'alphaEMA' can be modified to make this measurement more or less responsive
		gSuperTrak.Status.System.EMA_Throughput					:= ( alphaEMA * gSuperTrak.Status.System.Throughput ) + (( 1.0 - alphaEMA ) * gSuperTrak.Status.System.EMA_Throughput );
	ELSE
		gSuperTrak.Status.System.Throughput						:= 0.0;
		gSuperTrak.Status.System.EMA_Throughput					:= 0.0;
	END_IF;
	

	
END_ACTION

