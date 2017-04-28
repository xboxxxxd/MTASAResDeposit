col = createColCuboid ( 95.974617004395, 1751.3895263672, 17.640625, 255, 255, 255 )
zone = createRadarArea ( 95.974617004395, 1751.3895263672, 255, 255, 255, 0, 0, 170 )
setElementData (zone, "zombieProof", true)


function enterAdmin(hitElement,matchingDimension)
if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(hitElement)),aclGetGroup("zombiebase")) then
    toggleControl (hitElement, "fire", true )
    toggleControl (hitElement, "aim_weapon", true)
    toggleControl (hitElement, "vehicle_fire", true)
    outputChatBox("Welcome to Army Base", hitElement, 0, 170, 255)
       else
	outputChatBox("Access denied - Army Only", hitElement, 255, 0, 0)
         killPed (hitElement)
end
end
addEventHandler( "onColShapeHit", col, enterAdmin )