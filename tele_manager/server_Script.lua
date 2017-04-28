addEvent ( "client_CheckPermissions", true )
addEvent ( "client_CallAvailableTeleports", true )
addEvent ( "client_DestroyTeleport", true )
addEvent ( "client_CallSpecificTeleport", true )
addEvent ( "client_CreateNewTeleport", true )
isAdminStatus = {}
teleportNodes = {}

function client_CheckPermissions()
	if hasObjectPermissionTo ( client, "function.banPlayer" ) == true then
		isAdminStatus[client] = true
	elseif hasObjectPermissionTo ( client, "function.banPlayer" ) == false then
		isAdminStatus[client] = false
	end
	triggerClientEvent ( client, "client_ReturnPermissions", client, isAdminStatus[client] )
end

function onPlayerLogout ( prevAccount, curAccount )
	setElementData ( source, "allowedToCreateTele", false )
	setElementData ( source, "allowedToDestroyTele", false )
	if hasObjectPermissionTo ( source, "function.banPlayer" ) == false then
		isAdminStatus[source] = false
	elseif hasObjectPermissionTo ( source, "function.banPlayer" ) == true then
		isAdminStatus[source] = true
	end
end

function onPlayerLogin ( prevAccount, curAccount )
	if hasObjectPermissionTo ( source, "function.banPlayer" ) == true then
		isAdminStatus[source] = true
		setElementData ( source, "allowedToDestroyTele", true )
	elseif hasObjectPermissionTo ( source, "function.banPlayer" ) == false then
		isAdminStatus[source] = false
		setElementData ( source, "allowedToDestroyTele", false )
	end
	triggerClientEvent ( source, "client_ReturnPermissions", source, isAdminStatus[source] )
end

function client_CallAvailableTeleports()
	teleFile = xmlLoadFile ( "warps.xml" )
	if teleFile then
		teleNodes = xmlNodeGetChildren ( teleFile )
		for i, node in ipairs ( teleNodes ) do
			--
		end
		local tableSize = table.maxn ( teleNodes )
		if tableSize == 0 then
			teleAvailable = false
			triggerClientEvent ( client, "client_ReturnAvailableTeleports", client, teleAvailable )
		else
			teleAvailable = true
			for i, v in ipairs ( teleNodes ) do
				tNodeX = xmlNodeGetAttribute ( v, "x" )
				tNodeY = xmlNodeGetAttribute ( v, "y" )
				tNodeZ = xmlNodeGetAttribute ( v, "z" )
				tNodeRot = xmlNodeGetAttribute ( v, "rot" )
				tNodeDesc = xmlNodeGetAttribute ( v, "desc" )
				tNodeType = xmlNodeGetAttribute ( v, "type" )
				triggerClientEvent ( client, "client_ReturnAvailableTeleports", client, teleAvailable, tNodeType, tNodeX, tNodeY, tNodeZ, tNodeDesc, i, tNodeRot )
			end
		end
	end
end

function client_DestroyTeleport ( numberInTable )
	xmlDestroyNode ( teleNodes[numberInTable] )
	xmlSaveFile ( teleFile )
	xmlUnloadFile ( teleFile )
	outputChatBox ( "*Teleport deleted", client, 0, 255, 0 )
	client_CallAvailableTeleports()
end

function client_CreateNewTeleport ( x, y, z, desc, rot, warpType )
	teleFile = xmlLoadFile ( "warps.xml" )
	mainNode = xmlFindChild ( teleFile, "teleports", 0 )
	newTeleportNode = xmlCreateChild ( teleFile, "teleport" )
	xmlNodeSetAttribute ( newTeleportNode, "x", tonumber(x) )
	xmlNodeSetAttribute ( newTeleportNode, "y", tonumber(y) )
	xmlNodeSetAttribute ( newTeleportNode, "z", tonumber(z) )
	xmlNodeSetAttribute ( newTeleportNode, "rot", tonumber(rot) )
	xmlNodeSetAttribute ( newTeleportNode, "type", tostring(warpType) )
	xmlNodeSetAttribute ( newTeleportNode, "desc", tostring(desc) )
	xmlSaveFile ( teleFile )
	xmlUnloadFile ( teleFile )
	outputChatBox ( "*New teleport added!", client, 0, 255, 0 )
end

function client_CallSpecificTeleport ( teleportID )
	teleFile = xmlLoadFile ( "warps.xml" )
	teleNodes = xmlNodeGetChildren ( teleFile )
	selectedNode = teleNodes[teleportID]
	warpX = xmlNodeGetAttribute ( selectedNode, "x" )
	warpY = xmlNodeGetAttribute ( selectedNode, "y" )
	warpZ = xmlNodeGetAttribute ( selectedNode, "z" )
	warpRot = xmlNodeGetAttribute ( selectedNode, "rot" )
	warpType = xmlNodeGetAttribute ( selectedNode, "type" )
	triggerClientEvent ( client, "client_ReturnSpecificTeleport", client, warpX, warpY, warpZ, warpRot, warpType )
end

addEventHandler ( "client_CheckPermissions", getRootElement(), client_CheckPermissions )
addEventHandler ( "client_CallAvailableTeleports", getRootElement(), client_CallAvailableTeleports )
addEventHandler ( "client_DestroyTeleport", getRootElement(), client_DestroyTeleport )
addEventHandler ( "onPlayerLogout", getRootElement(), onPlayerLogout )
addEventHandler ( "onPlayerLogin", getRootElement(), onPlayerLogin )
addEventHandler ( "client_CreateNewTeleport", getRootElement(), client_CreateNewTeleport )
addEventHandler ( "client_CallSpecificTeleport", getRootElement(), client_CallSpecificTeleport )