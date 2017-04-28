addEvent ( "client_ReturnPermissions", true )
addEvent ( "client_ReturnAvailableTeleports", true )
addEvent ( "client_ReturnSpecificTeleport", true )
teleRows = {}

function toggleTeleportManager()
	if guiGetVisible ( teleManager ) == true or guiGetVisible ( teleWizard ) == true then
		guiSetVisible ( teleManager, false )
		guiSetVisible ( teleWizard, false )
		showCursor ( false )
		guiGridListClear ( list )
		guiSetInputEnabled ( false )
	else
		guiSetVisible ( teleManager, true )
		showCursor ( true )
		processAvailableTeleports()
	end
end

function processAvailableTeleports()
	triggerServerEvent ( "client_CallAvailableTeleports", getLocalPlayer() )
end

function checkPermissions()
	triggerServerEvent ( "client_CheckPermissions", getLocalPlayer() )
end

function client_ReturnPermissions ( isAdmin )
	if isAdmin == true then
		setElementData ( getLocalPlayer(), "allowedToCreateTele", true )
	elseif isAdmin == false then
		setElementData ( getLocalPlayer(), "allowedToCreateTele", false )
	end
end

function client_ReturnAvailableTeleports ( availableTele, tNodeType, teleNodeX, teleNodeY, teleNodeZ, teleNodeDesc, number )
	if availableTele == false then
		teleRows[1] = guiGridListAddRow ( list )
		guiGridListSetItemText ( list, teleRows[1], listDescColumn, "*No Available Teleports*", false, false )
		guiSetEnabled ( teleManagerUseTele, false )
		guiSetEnabled ( teleManagerDeleteTele, false )
	else
		teleRows[number] = guiGridListAddRow ( list )
		guiGridListSetItemText ( list, teleRows[number], listDescColumn, ""..teleNodeDesc.."", false, false )
		guiGridListSetItemText ( list, teleRows[number], listTypeColumn, tostring(tNodeType), false, false )
		guiSetEnabled ( teleManagerUseTele, true )
		guiSetEnabled ( teleManagerDeleteTele, true )
	end
end

function client_ReturnSpecificTeleport ( x, y, z, rot, warpType )
	if rot == nil or rot == false then rot = 0 end
	if warpType == nil or warpType == false then warpType = "foot only" end
	if isPedInVehicle ( getLocalPlayer() ) == true then
		if getVehicleController ( getPedOccupiedVehicle ( getLocalPlayer() ) ) == getLocalPlayer() then
			if warpType == "both" or warpType == "vehicle only" then
				setTimer ( setVehicleFrozen, 1500, 1, getPedOccupiedVehicle ( getLocalPlayer() ), true )
				fadeCamera ( false, 1 )
				setTimer ( setElementPosition, 1500, 1, getPedOccupiedVehicle ( getLocalPlayer() ), x, y, z )
				setTimer ( setElementRotation, 1500, 1, getPedOccupiedVehicle ( getLocalPlayer() ), 0, 0, rot )
				setTimer ( setVehicleFrozen, 3000, 1, getPedOccupiedVehicle ( getLocalPlayer() ), false )
				setTimer ( fadeCamera, 3000, 1, true, 1 )
			elseif warpType == "foot only" then
				outputChatBox ( "*You have to be on foot to use this warp", 255, 0, 0 )
			end
		end
	elseif isPedInVehicle ( getLocalPlayer() ) == false then
		if warpType == "both" or warpType == "foot only" then
			fadeCamera ( false, 1 )
			setTimer ( setElementPosition, 2000, 1, getLocalPlayer(), x, y, z )
			setTimer ( setPedRotation, 2000, 1, getLocalPlayer(), tonumber(rot) )
			setTimer ( fadeCamera, 3000, 1, true, 1 )
		elseif warpType == "vehicle only" then
			outputChatBox ( "*You have to be in a vehicle to use this warp", 255, 0, 0 )
		end
	end
end

bindKey ("F3", "down", toggleTeleportManager )
addEventHandler ( "client_ReturnPermissions", getRootElement(), client_ReturnPermissions )
addEventHandler ( "client_ReturnAvailableTeleports", getRootElement(), client_ReturnAvailableTeleports )
addEventHandler ( "client_ReturnSpecificTeleport", getRootElement(), client_ReturnSpecificTeleport )