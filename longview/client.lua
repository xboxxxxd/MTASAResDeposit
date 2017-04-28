
-- ONIX1337 scripting
-- Allowed to modify
-- Version 1.0.3 (Final)
-- Recommended to use only in client-side

function v1()
	setFarClipDistance(7000)
    setCloudsEnabled(false)	
	setFogDistance(0) 
	outputChatBox("*longview turned on, in case of low FPS use: /PCLAG")
end
addEventHandler("onClientResourceStart", resourceRoot, v1)
addEventHandler("onPlayerJoin", resourceRoot, v1)
addCommandHandler("pcfast", v1)

function v2()
	setFarClipDistance(1000) 
	setCloudsEnabled(false)
	setFogDistance(0)
    outputChatBox("*longview turned off, use: /PCFAST")	
end
addCommandHandler("pclag", v2)




