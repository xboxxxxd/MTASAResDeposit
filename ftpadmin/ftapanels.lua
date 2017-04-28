r = math.random(1,255)
g = math.random(1,255)
b = math.random(1,255)


function isPlayerAdmin(source)
    local user = "user."..getAccountName ( getPlayerAccount ( source ) )
      for id, object in ipairs ( aclGroupListObjects ( aclGetGroup ( "F4" ) ) or  aclGroupListObjects ( aclGetGroup ( "Console" ) ) ) do
        if object == user then -- if the user has rights
            triggerClientEvent("ClientGui",getRootElement(),source)
        end
    end
end

function onLoad ()
    for index, player in ipairs ( getElementsByType ( "player" ) ) do
        bindKey ( player, "F4", "down", isPlayerAdmin )
    end
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource() ), onLoad)  


function onJoin ()
    bindKey ( source, "F4", "down", isPlayerAdmin )
	-- local openmotd = fileOpen("motdk.txt")
	-- local motdt = fileRead (openmotd, 100)
	-- triggerClientEvent ( root, "rendertxt", source, motdt )
end
addEventHandler ( "onPlayerJoin", getRootElement(), onJoin )

function outputMessage(text)
    outputTopChat ("#FFD700Admin#FFFF00: "..text, getRootElement(), 255, 255, 255, true ) --output that text
end
addEvent("ServerOutput",true)
addEventHandler("ServerOutput", getRootElement(),outputMessage)

function adminChat ( thePlayer, commandName, ... )
    local text = table.concat ( { ... }, " " )
    local playerName = getPlayerName ( thePlayer )
    for _, player in ipairs ( getElementsByType ( "player" ) ) do
        local account = getAccountName ( getPlayerAccount ( player ) )
        if ( isObjectInACLGroup ( "user.".. account, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ( "user.".. account, aclGetGroup ( "Admin" ) ) ) then
            outputTopChat ( "#FF0000[#CCCCCCAdmin#FF0000] #FF0000".. playerName .."#CCCCCC: #FF0000".. text, player, 255, 255, 255, true )
        end
    end
end
addCommandHandler ( "ac", adminChat )
-----------------------
-- Show/Hide Nametag --
-----------------------
function hideNameTag ( source )
    if isPlayerNametagShowing ( source ) == true then
        setPlayerNametagShowing ( source, false )
    end
end
addEvent("hideName",true)
addEventHandler("hideName", getRootElement(),hideNameTag)

function showNameTag ( source )
    setPlayerNametagShowing ( source, true )
end
addEvent("showName",true)
addEventHandler("showName", getRootElement(), showNameTag)
----------------------
--   Toggle Blip    --
----------------------
function hideRadarBlip ( source )
    for index, element in ipairs ( getAttachedElements ( source ) ) do 
        if ( getElementType ( element ) == "blip" ) then 
        destroyElement ( element ) 
        end         
    end
end
addEvent("hideBlip",true)
addEventHandler("hideBlip", resourceRoot,hideRadarBlip)

function createRadarBlip ( source )
    pBlip = createBlipAttachedTo ( source, 0, 2, r, g, b )
end
addEvent("createBlips",true)
addEventHandler("createBlips", resourceRoot, createRadarBlip)

function destroyBlipsAttachedTo()
    local attached = getAttachedElements ( source )
    if ( attached ) then
        for k,element in ipairs(attached) do
            if getElementType ( element ) == "blip" then
                destroyElement ( element )
            end
        end
    end
end
addEventHandler ( "onPlayerQuit", getRootElement(), destroyBlipsAttachedTo )
----------------------
--   Invisibility   --
----------------------
function invisible ( source )
    if not ( getElementAlpha(source) == 0 ) then
        setElementAlpha ( source, 0 )
    end
end
addEvent("noalpha",true)
addEventHandler("noalpha", resourceRoot, invisible)
function notinvisible ( source )
    if ( getElementAlpha(source) == 0 ) then
        setElementAlpha ( source, 255 )
    end
end
addEvent("noalpha1",true)
addEventHandler("noalpha1", resourceRoot, notinvisible)
----------------------
--    Car Damage    --
----------------------
function nocardamage ( source )
    if ( isPedInVehicle ( source ) ) then
        if ( isVehicleDamageProof ( getPedOccupiedVehicle ( source ) )  == false )    then
            setVehicleDamageProof ( getPedOccupiedVehicle ( source ), true )
        end
    else
        outputTopChat ( "You must be inside a vehicle to set this.", source )
    end
end
addEvent("cardamage", true )
addEventHandler("cardamage", resourceRoot, nocardamage )

function disabledamage ( source )
    if ( isPedInVehicle ( source ) ) then
        setVehicleDamageProof ( getPedOccupiedVehicle ( source ), false )
    end
end
addEvent("nodamage", true)
addEventHandler("nodamage", resourceRoot, disabledamage )
-------------------------
--  Car Invisibility   --
-------------------------
function carinvis(source)
    if not ( getElementAlpha ( getPedOccupiedVehicle ( source ) ) == 0 ) then
        setElementAlpha ( getPedOccupiedVehicle ( source ), 0 )
    end
end
addEvent("nocaralpha",true)
addEventHandler("nocaralpha", resourceRoot,carinvis)
function tcarinvis(source)
    setElementAlpha ( getPedOccupiedVehicle ( source ), -1 )
end
addEvent("nocaralpha1",true)
addEventHandler("nocaralpha1", resourceRoot,tcarinvis)
-------------------------
--    Kill Function    --
-------------------------
function noElementHealth ( playerName )
    setElementHealth ( getPlayerFromName ( playerName ), 0 )
end
addEvent("nohp", true)
addEventHandler("nohp",resourceRoot, noElementHealth )
-------------------------
--    Nametag Text     --
-------------------------
function setnametxt ( playerName1, textt )
    setPlayerNametagText ( getPlayerFromName ( tostring(playerName1) ), textt )
end
addEvent ("nametxt",true)
addEventHandler("nametxt", resourceRoot, setnametxt )
-------------------------
--     Unlock/Lock     --
-------------------------
function slock ( targetLock )
    local targetvehicle = getPedOccupiedVehicle ( getPlayerFromName ( targetLock ) )
    if ( targetvehicle ) then
        setVehicleLocked ( targetvehicle, true )
    end
end
addEvent ("sslock",true)
addEventHandler("sslock", resourceRoot, slock )

function sunlock ( targetunlock )
    local targetsvehicle = getPedOccupiedVehicle ( getPlayerFromName ( targetunlock ) )
    if ( targetsvehicle ) then
        setVehicleLocked ( targetsvehicle, false )
    end
end
addEvent ("ssunlock",true)
addEventHandler("ssunlock", resourceRoot, sunlock )
-------------------------
--     Head/Less       --
-------------------------
function headless( targethead )
    if not ( isPedHeadless ( getPlayerFromName ( targethead ) ) ) then
        setPedHeadless ( getPlayerFromName ( targethead ), true )
    else
        setPedHeadless ( getPlayerFromName ( targethead ), false )
    end
end
addEvent ("toghead",true)
addEventHandler("toghead", resourceRoot, headless )
-------------------------
--    Nametag Color    --
-------------------------
function colorTag (targettag, getR, getG, getB)
    setPlayerNametagColor ( getPlayerFromName ( targettag ), tonumber(getR), tonumber(getG), tonumber(getB) )
end
addEvent ("tagcolor",true)
addEventHandler ("tagcolor", resourceRoot, colorTag)
--------------------
-- Hide Nametags  --
--------------------
function invisibles ( targethide )
    setPlayerNametagShowing ( getPlayerFromName(targethide), false )

end
addEvent("noalphat",true)
addEventHandler("noalphat", resourceRoot, invisibles)

function notinvisibles ( targethide )
    setPlayerNametagShowing ( getPlayerFromName(targethide), true )

end
addEvent("noalpha1t",true)
addEventHandler("noalpha1t", resourceRoot, notinvisibles)
