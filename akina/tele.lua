function tele (thePlayer)
	setElementPosition ( thePlayer, -2502.301, 2136.427, 320.146 )
		outputChatBox ('#FFFFFF[#7CFC00Tele#FFFFFF]: #00FFFF' .. getPlayerName(thePlayer) .. ' #00BFFFFoi Para a Pista de Drift Akina #FFFFFF(#7CFC00/akina#FFFFFF)', root, 255, 255, 255, true)
end
addCommandHandler ( "akina", tele )