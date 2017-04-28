--[[-------------------
CLEAR CHAT

By: lLinux (HackerlLinux)
To: http://community.multitheftauto.com/

Contanct:

Skype: lLinux
Facebook: www.facebook.com/lLinux
----
Please do not delete the copyright
]]---------------------

function clear ( thePlayer )
local cuenta = getAccountName( getPlayerAccount(thePlayer) )
if isObjectInACLGroup("user."..cuenta, aclGetGroup("Admin")) then --Group Admin
	spaces(thePlayer)
elseif isObjectInACLGroup("user."..cuenta, aclGetGroup("SuperModerator")) then --Group SuperModerator
	spaces(thePlayer)
elseif isObjectInACLGroup("user."..cuenta, aclGetGroup("Moderator")) then --Group Moderator
	spaces(thePlayer)
else
outputChatBox("TRUE", thePlayer, 255, 0, 0, true) -- For those that are not
end
end
addCommandHandler("vittu", clear)

function spaces(thePlayer)
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox("#000000[CLEARCHAT] #ff0000 THE CHAT WAS CLEANED BY "..getPlayerName(thePlayer), getRootElement(), 255, 255, 255, true)
end