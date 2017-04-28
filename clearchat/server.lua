function cleanAll (player)
    for index, player in ipairs ( getElementsByType ( "player" ) ) do
        unbindKey ( player, "O", "down", showPanel )             
    end
end
addEventHandler ( "onResourceStop", getResourceRootElement ( getThisResource() ), cleanAll)

function adminText()
if ( hasObjectPermissionTo ( source, "command.aexec", true ) ) then
	outputChatBox ( "Press 'o' to open your c-panel", source,0,0,255 )
    else
	end
end
addEventHandler ( "onPlayerLogin", getRootElement(), adminText)

function cc(thePlayer)
    if ( hasObjectPermissionTo ( thePlayer, "command.aexec", true ) ) then
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
		outputChatBox(" ")		
		outputChatBox("INFO: ADMIN CLEARED THE CHAT",255,12,15, false)		
	   else
	   outputChatBox ("C-Panel: Access denied", thePlayer, 193, 13, 13)
     end
end
addCommandHandler("clearchat", cc)