-- Simple Script By : Twister--

function Disco_shake(thePlayer)
    local accName = getAccountName ( getPlayerAccount ( thePlayer ) ) 
     if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin") ) then 
     local x, y, z = getElementPosition(thePlayer)
triggerClientEvent ( "Disco_shake_sound", root, "disco.mp3", x, y, z, false)
setTimer(
function()
end, 15000, 1)
setTimer(
function()
triggerClientEvent ( "DiscoShakeDance", root, thePlayer, "nil")
destroyElement(shakePed1)
end, 65000, 1)
 end
end 
addCommandHandler("Dj", Disco_shake)
addCommandHandler("dj", Disco_shake)

