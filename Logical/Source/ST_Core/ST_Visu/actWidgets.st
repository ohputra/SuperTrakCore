
ACTION SuperTrakPaperWidget:
	
	
	WidgetData.SectionCount	:= CONFIG_ST_MAX_SECTIONS;
	WidgetData.ShuttleCount := gSuperTrak.Status.System.ActivePallets;
	
	FOR index := 1 TO gSuperTrak.Status.System.ActivePallets DO
		// Calculate pallet position in terms of total distance along track- including some scaling for Curve Sections
		IF gSuperTrak.Status.Section[gSuperTrak.Status.Pallet[index].Section].IsCurveSection = FALSE THEN
			WidgetData.ShuttlePos[index]			:= 	(UINT_TO_REAL(gSuperTrak.Status.Pallet[index].Section) - 1.0) * (1000.0) +
			(gSuperTrak.Status.Pallet[index].Position / 1000.0) * (1000.0);
		ELSE
			WidgetData.ShuttlePos[index]			:= 	(UINT_TO_REAL(gSuperTrak.Status.Pallet[index].Section) - 1.0) * (1000.0) +
			(gSuperTrak.Status.Pallet[index].Position / 1030.0) * (1000.0);				
		END_IF;
	END_FOR;
	
	
	WidgetData.TargetCount	:= 0;

	FOR index := 1 TO CONFIG_ST_MAX_TARGETS DO
		
		IF gSuperTrak.Status.Target[index].Section <> 0 THEN
			WidgetData.TargetCount		:= WidgetData.TargetCount + 1;
		END_IF;
		
		// Calculate target position in terms of total distance along track- including some scaling for Curve Sections
		IF gSuperTrak.Status.Section[gSuperTrak.Status.Target[index].Section].IsCurveSection = FALSE THEN
			WidgetData.TargetPos[index]				:= (UINT_TO_REAL(gSuperTrak.Status.Target[index].Section) - 1.0) * (1000.0) +
			(gSuperTrak.Status.Target[index].Position / 1000.0) * (1000.0);
		ELSE
			WidgetData.TargetPos[index]				:= (UINT_TO_REAL(gSuperTrak.Status.Target[index].Section) - 1.0) * (1000.0) +
			(gSuperTrak.Status.Target[index].Position / 1030.0) * (1000.0);
		END_IF;		
	END_FOR;
	
	
	
	pTargetStatusRef		ACCESS ADR(gSuperTrak.Status.Target[targetStatusIndex+1]);
	pSectionStatusRef		ACCESS ADR(gSuperTrak.Status.Section[sectionStatusIndex+1]);
	pPalletStatusRef		ACCESS ADR(gSuperTrak.Status.Pallet[palletStatusIndex+1]);	
		
		
	

END_ACTION


