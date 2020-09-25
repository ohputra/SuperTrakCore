
PROGRAM _INIT
	(* Insert code here *)

END_PROGRAM

PROGRAM _CYCLIC
	
		
	

	MpAlarmXCore_0(MpLink := ADR(gAlarmXCore), Enable :=TRUE , ErrorReset := gSuperTrak.Cmds.ErrorReset );
	MpAlarmXHistory_0(MpLink :=ADR(gAlarmXHistory) , Enable :=TRUE , ErrorReset :=gSuperTrak.Cmds.ErrorReset , DeviceName := ADR('alarmHistory'), Language := ADR('en'));
	MpAlarmXHistoryUI_0(MpLink :=ADR(gAlarmXHistory) , Enable :=TRUE , ErrorReset :=gSuperTrak.Cmds.ErrorReset, UIConnect := ADR(MpAlarmHistoryUIConnect));
	MpAlarmXListUI_0(MpLink :=ADR(gAlarmXCore) , Enable :=TRUE , ErrorReset :=gSuperTrak.Cmds.ErrorReset, UIConnect :=ADR(MpAlarmUIConnect) );


	
	
	// ======================== FAULTS =============================
		
	FOR index := 0 TO 31 DO
	
		// Clear value of Reporting Sections string
		nxt_adr		:= memset(ADR(reportingSections),0,SIZEOF(reportingSections)-1);
		
		IF gSuperTrak.Status.System.Faults[index] THEN
			reportingSections		:= 'System; ';
		END_IF;
		
		FOR index2 := 0 TO CONFIG_ST_MAX_SECTIONS DO
			IF gSuperTrak.Status.Section[index2].Diag.Faults[index] THEN
				
				sectionString		:= 'Section ';
				appendString		:= USINT_TO_STRING(index2);
				
				nxt_adr				:= strcat(ADR(sectionString),ADR(appendString));
				nxt_adr				:= strcat(ADR(sectionString),ADR('; '));
				nxt_adr				:= strcat(ADR(reportingSections),ADR(sectionString));		
				
			END_IF;		
		END_FOR;
		
		alarmString					:= 'Fault_';
		indexString					:= USINT_TO_STRING(index);
		nxt_adr						:= strcat(ADR(alarmString),ADR(indexString));
	
		IF reportingSections <> '' THEN
			MpAlarmXSet(gAlarmXCore,alarmString);
		ELSE
			MpAlarmXReset(gAlarmXCore,alarmString);
		END_IF;
		
		IF gSuperTrak.Cmds.ErrorReset THEN
			MpAlarmXAcknowledge(gAlarmXCore,alarmString);
		END_IF;
		
	END_FOR;
	
	
	
	
	
	// ===================== WARNINGS ===========================
	
	FOR index := 0 TO 31 DO
		
		// Clear value of Reporting Sections String
		nxt_adr				:= memset(ADR(reportingSections),0,SIZEOF(reportingSections)-1);
		
		IF gSuperTrak.Status.System.Warnings[index] THEN
			reportingSections			:= 'System; ';
		END_IF;
		
		FOR index2 := 0 TO CONFIG_ST_MAX_SECTIONS DO
			IF gSuperTrak.Status.Section[index2].Diag.Warnings[index] THEN
				
				sectionString			:= 'Section ';
				appendString			:= USINT_TO_STRING(index2);
				
				nxt_adr					:= strcat(ADR(sectionString),ADR(appendString));
				nxt_adr					:= strcat(ADR(sectionString),ADR('; '));
				nxt_adr					:= strcat(ADR(reportingSections),ADR(sectionString));
				
			END_IF;
		END_FOR;
		
		alarmString						:= 'Warning_';
		indexString						:= USINT_TO_STRING(index);
		nxt_adr							:= strcat(ADR(alarmString),ADR(indexString));
		
		IF reportingSections <> '' THEN
			MpAlarmXSet(gAlarmXCore,alarmString);
		ELSE
			MpAlarmXReset(gAlarmXCore,alarmString);
		END_IF;	
		
		IF gSuperTrak.Cmds.ErrorReset THEN
			MpAlarmXAcknowledge(gAlarmXCore,alarmString);
		END_IF;
		
	END_FOR;
	
	
	
	
	
	
	
	

	
	
	
	//========================================================================================================
	
	

	(*use this for setting a value through a button on the screen and you want the value that was set to be reset*)
	IF (MpAlarmXHistory_0.Export AND MpAlarmXHistory_0.CommandDone) THEN
		MpAlarmXHistory_0.Export :=	FALSE;
	END_IF




	END_PROGRAM

