
ACTION ReadPNU:




	// Read Target Section Values --------------------------------------------------------------------------------------------------------
	result		:= SuperTrakServChanRead( 0, stSTAT_TARGET_PAR_VALUES, 0, CONFIG_ST_MAX_TARGETS, ADR(servChanResponseUINT), SIZEOF(servChanResponseUINT));
	nxt_adr		:= memcpy(ADR(targetSections),ADR(servChanResponseUINT),SIZEOF(servChanResponseUINT));
	// Apply values
	FOR index := 0 TO CONFIG_ST_MAX_TARGETS DO
		gSuperTrak.Status.Target[index].Section			:= targetSections[index];
	END_FOR;





	// Read Target Position Values [initially um, converted to mm] -----------------------------------------------------------------------
	result		:= SuperTrakServChanRead( 0 , stSTAT_TARGET_POS_VALUES, 0, CONFIG_ST_MAX_TARGETS, ADR(servChanResponseUINT), SIZEOF(servChanResponseUINT));
	nxt_adr		:= memcpy(ADR(targetPositions),ADR(servChanResponseUINT),SIZEOF(servChanResponseUINT));
	// Apply values
	FOR index := 0 TO CONFIG_ST_MAX_TARGETS DO
		gSuperTrak.Status.Target[index].Position		:= DINT_TO_REAL(targetPositions[index]) / 1000.0;
	END_FOR;




	// Read Pallet Velocity Values -------------------------------------------------------------------------------------------------------
	result		:= SuperTrakServChanRead( 0, 1314, 0, CONFIG_ST_MAX_PALLETS, ADR(servChanResponseUINT), SIZEOF(servChanResponseUINT));
	nxt_adr		:= memcpy(ADR(palletVelocities),ADR(servChanResponseUINT),SIZEOF(servChanResponseUINT));
	// Apply values
	FOR index := 0 TO CONFIG_ST_MAX_PALLETS - 1 DO
		IF result = 0 THEN
			gSuperTrak.Status.Pallet[index+1].Velocity		:= UINT_TO_REAL(palletVelocities[index]);
		END_IF;
	END_FOR;






	// Read Pallet Acceleration Values ---------------------------------------------------------------------------------------------------
	result		:= SuperTrakServChanRead( 0, 1312, 0, CONFIG_ST_MAX_PALLETS, ADR(servChanResponseUINT), SIZEOF(servChanResponseUINT));
	nxt_adr		:= memcpy(ADR(palletAccelerations),ADR(servChanResponseUINT),SIZEOF(servChanResponseUINT));
	// Apply values
	FOR index := 0 TO CONFIG_ST_MAX_PALLETS DO
		IF result = 0 THEN

			gSuperTrak.Status.Pallet[index].Acceleration	:= palletAccelerations[index];

		END_IF;
	END_FOR;




	// Read Section Temperature Values ---------------------------------------------------------------------------------------------------
	result		:= SuperTrakServChanRead( CurrentReadSection, stSTAT_HARDWARE_SENSOR_VALUES, 0, 16, ADR(servChanResponseUINT), SIZEOF(servChanResponseUINT));
	nxt_adr		:= memcpy(ADR(sectionTemperatures),ADR(servChanResponseUINT),SIZEOF(servChanResponseUINT));
	// Apply values
	gSuperTrak.Status.Section[CurrentReadSection].Left.MotorTemp[1]			:= UINT_TO_REAL(sectionTemperatures[0]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Left.MotorTemp[2]			:= UINT_TO_REAL(sectionTemperatures[1]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Left.MotorTemp[3]			:= UINT_TO_REAL(sectionTemperatures[2]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Left.MotorTemp[4]			:= UINT_TO_REAL(sectionTemperatures[3]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Left.MotorTemp[5]			:= UINT_TO_REAL(sectionTemperatures[4]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Left.ElectronicsTemp		:= UINT_TO_REAL(sectionTemperatures[5]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Left.MotorVoltage			:= UINT_TO_REAL(sectionTemperatures[6]) / 100.0;

	gSuperTrak.Status.Section[CurrentReadSection].Right.MotorTemp[1]		:= UINT_TO_REAL(sectionTemperatures[0]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Right.MotorTemp[2]		:= UINT_TO_REAL(sectionTemperatures[1]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Right.MotorTemp[3]		:= UINT_TO_REAL(sectionTemperatures[2]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Right.MotorTemp[4]		:= UINT_TO_REAL(sectionTemperatures[3]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Right.MotorTemp[5]		:= UINT_TO_REAL(sectionTemperatures[4]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Right.ElectronicsTemp		:= UINT_TO_REAL(sectionTemperatures[5]) / 100.0;
	gSuperTrak.Status.Section[CurrentReadSection].Right.MotorVoltage		:= UINT_TO_REAL(sectionTemperatures[6]) / 100.0;






	// Read Pallet Destination Targets ----------------------------------------------------------------------------------------------------
	result		:= SuperTrakServChanRead( 0, stSTAT_PALLET_DEST_TARGET, 0, CONFIG_ST_MAX_PALLETS, ADR(servChanResponseUINT), SIZEOF(servChanResponseUINT));
	nxt_adr		:= memcpy(ADR(palletDestinations),ADR(servChanResponseUINT),SIZEOF(servChanResponseUINT));
	// Apply values
	FOR index := 0 TO (CONFIG_ST_MAX_PALLETS - 1) DO
		gSuperTrak.Status.Pallet[index+1].DestinationTarget		:= palletDestinations[index];
	END_FOR;








	// Read Section Types ------------------------------------------------------------------------------------------------------------------
	result		:= SuperTrakServChanRead( CurrentReadSection, stSTAT_SECTION_TYPE, 0, 1, ADR(servChanResponseUINT), SIZEOF(servChanResponseUINT));
	nxt_adr		:= memcpy(ADR(sectionTypes),ADR(servChanResponseUINT),SIZEOF(servChanResponseUINT));
	// Apply values
	gSuperTrak.Status.Section[CurrentReadSection].IsCurveSection			:= UINT_TO_BOOL(sectionTypes[0]);




	// Index CurrentReadSection, used by some reads above
	CurrentReadSection				:= CurrentReadSection + 1;
	IF CurrentReadSection > CONFIG_ST_MAX_SECTIONS THEN
		CurrentReadSection	:= 1;
	END_IF;



END_ACTION


ACTION WritePNU:

	StWritePnu_0.Enable									:= StControl_0.Active;

	// Example write - PNU 1600 is for Region Options
	WritePnuPara[0].ValidDataSize						:= 4;
	WritePnuPara[0].ParameterNumber						:= 1600;
	WritePnuPara[0].ParameterValueCount					:= 2;
	WritePnuPara[0].SectionID							;	//	:= CurrentWriteSection;
	WritePnuPara[0].StartParameterIndex					:= 0;

	CASE WriteState OF

		WS_WAIT://-----------------------------------------------------------------------

			// Timer adds a small delay to manage system resource usage
			hwParameterWriteTimer.PT				:= t#1s;
			hwParameterWriteTimer.IN				:= TRUE;

			StWritePnu_0.Update						:= FALSE;
			StWritePnu_0.Write						:= FALSE;

			IF hwParameterWriteTimer.Q THEN
				hwParameterWriteTimer.IN			:= FALSE;
				WriteState							:= WS_APPLY;
			END_IF;

		WS_APPLY://-------------------------------------------------------------------------------

			IF enableRegionSample THEN
				WriteDataBuffer[0].Entry[0]			:= 3;
				WriteDataBuffer[0].Entry[1]			:= 3;
			ELSE
				WriteDataBuffer[0].Entry[0]			:= 2;
				WriteDataBuffer[0].Entry[1]			:= 2;
			END_IF;

			WriteState								:= WS_SET_PARAMETERS;

		WS_SET_PARAMETERS://-----------------------------------------------------------------------

			StWritePnu_0.Parameters					:= ADR(WritePnuPara[writeIndex]);
			StWritePnu_0.DataAddress				:= ADR(WriteDataBuffer[writeIndex].Entry);
			StWritePnu_0.DataSize					:= SIZEOF(WriteDataBuffer[writeIndex].Entry);

			StWritePnu_0.Update						:= TRUE;

			IF StWritePnu_0.UpdateDone THEN
				StWritePnu_0.Update					:= FALSE;
				WriteState							:= WS_WRITE;
			END_IF;

		WS_WRITE://-----------------------------------------------------------------------

			StWritePnu_0.Write						:= TRUE;

			IF StWritePnu_0.CommandDone THEN
				StWritePnu_0.Write					:= FALSE;
				WriteState							:= WS_ITERATE_SECTION;
			END_IF;

		WS_ITERATE_SECTION://-----------------------------------------------------------------------

			writeIndex								:= writeIndex + 1;
			WriteState								:= WS_APPLY;

			IF writeIndex = stNUM_WRITE_GROUPS THEN
				writeIndex							:= 0;
				CurrentWriteSection					:= CurrentWriteSection + 1;
				WriteState							:= WS_WAIT;
			END_IF;

			IF ( CurrentWriteSection < 1 ) OR ( CurrentWriteSection > CONFIG_ST_MAX_SECTIONS ) THEN
				CurrentWriteSection					:= 1;
			END_IF;


		WS_DEBUG://-----------------------------------------------------------------------

	END_CASE;

	hwParameterWriteTimer();
	StWritePnu_0();

END_ACTION
