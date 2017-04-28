function teleManagerClick ( button )
	if button == "left" then
		if source == teleManagerClose then
			guiSetVisible ( teleManager, false )
			showCursor ( false )
			guiGridListClear ( list )
		elseif source == teleManagerAddTele then
			if getElementData ( getLocalPlayer(), "allowedToCreateTele" ) == true then
				guiSetVisible ( teleManager, false )
				guiSetVisible ( teleWizard, true )
				guiSetText ( teleWizardXBox, "" )
				guiSetText ( teleWizardYBox, "" )
				guiSetText ( teleWizardZBox, "" )
				guiSetText ( teleWizardRotBox, "" )
			else
				outputChatBox ( "*You are not allowed to create teleports", 255, 0, 0 )
			end
		elseif source == teleManagerDeleteTele then
			local selRow, selColumn = guiGridListGetSelectedItem ( list )
			if selRow == -1 then
				outputChatBox ( "*You have to select a teleport to delete", 255, 0, 0 )
			else
				if getElementData ( getLocalPlayer(), "allowedToDestroyTele" ) == true then
					triggerServerEvent ( "client_DestroyTeleport", getLocalPlayer(), selRow + 1 )
					guiGridListClear ( list )
				else
					outputChatBox ( "*You are not allowed to delete teleports", 255, 0, 0 )
				end
			end
		elseif source == teleManagerUseTele then
			local selRow, selColumn = guiGridListGetSelectedItem ( list )
			if selRow == -1 then
				outputChatBox ( "*You have to select a teleport to use first", 255, 0, 0 )
			else
				triggerServerEvent ( "client_CallSpecificTeleport", getLocalPlayer(), selRow + 1 )
			end
		end
	end
end

function teleWizardClick ( button )
	if button == "left" then
		guiSetInputEnabled ( true )
		if source == teleWizardClose then
			guiSetVisible ( teleWizard, false )
			guiSetVisible ( teleManager, true )
			guiSetInputEnabled ( false )
		elseif source == teleWizardAddTele then
			local xInput = guiGetText ( teleWizardXBox )
			local yInput = guiGetText ( teleWizardYBox )
			local zInput = guiGetText ( teleWizardZBox )
			local descInput = guiGetText ( teleWizardDescBox )
			local teleRotation = guiGetText ( teleWizardRotBox )
			local teleTypeSelection
			local footOnlyState = guiRadioButtonGetSelected ( teleWizardFootOnly )
			local vehOnlyState = guiRadioButtonGetSelected ( teleWizardVehOnly )
			local bothState = guiRadioButtonGetSelected ( teleWizardBoth )
			if bothState == true then teleTypeSelection = "both" end
			if footOnlyState == true then teleTypeSelection = "foot only" end
			if vehOnlyState == true then teleTypeSelection = "vehicle only" end
			if tonumber(xInput) and tonumber(yInput) and tonumber(zInput) and tonumber(teleRotation) then
				if tostring(descInput) == "" then
					outputChatBox ( "*You need a description for your new teleport", 255, 0, 0 )
				else
					if teleTypeSelection == false or teleTypeSelection == nil then
						outputChatBox ( "*You need to select which type of teleport you want this to be", 255, 0, 0 )
					else
						triggerServerEvent ( "client_CreateNewTeleport", getLocalPlayer(), tonumber(xInput), tonumber(yInput), tonumber(zInput), tostring(descInput), tonumber(teleRotation), tostring(teleTypeSelection) )
						guiGridListClear ( list )
						guiSetVisible ( teleWizard, false )
						guiSetVisible ( teleManager, true )
						processAvailableTeleports()
						guiSetInputEnabled ( false )
					end
				end
			else
				outputChatBox ( "*Invalid data was input into the teleport location fields", 255, 0, 0 )
			end
		elseif source == teleWizardGetPos then
			local cX, cY, cZ = getElementPosition ( getLocalPlayer() )
			local cRot = getPedRotation ( getLocalPlayer() )
			guiSetText ( teleWizardXBox, cX )
			guiSetText ( teleWizardYBox, cY )
			guiSetText ( teleWizardZBox, cZ )
			guiSetText ( teleWizardRotBox, cRot )
		end
	end
end