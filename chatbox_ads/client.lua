serverName = "MOGA Drift Freeroam" --Default: "Default MTA Server" | Used in: Welcome to <serverName>! | Dont leave this blank!

--DO NOT EDIT ANYTHING BELOW THIS --
--UNLESS YOU ARE SURE OF WHAT     --
--YOU ARE ABOUT TO DO.            --
--#####################################################################################--
--## Copyright (c) MrTasty, | Under the Creative Commons 2.0 Licence | 2010 - Present #--
--#####################################################################################--

screenX, screenY = guiGetScreenSize()
topChat = {
  {"Welcome to ".. serverName or "Default MTA Server" .. "!", 255, 50, 50},
  {"Enjoy the server, "..getPlayerName(localPlayer), 255, 50, 50}
}

setTimer(function() table.remove(topChat, 1) end, 70000, 1)
setTimer(function() table.remove(topChat, 1) end, 70000, 1)


addEventHandler("onClientPreRender",root, 
  function()
    dxDrawRectangle(screenX/4+(screenX/16),1*20-20,screenX/2-(screenX/16),20.0,tocolor(0,0,0,150),false)
    local x, y, z = getElementPosition(localPlayer)
    dxDrawText("    Local Player Name: #ff6400"..getPlayerName(localPlayer).."#ffffff | Zone: #ffff00"..getZoneName(x, y, z, false).."#ffffff (#ffff00"..getZoneName(x, y, z, true).."#ffffff)",screenX/4+(screenX/16),1*40-40,screenX/2-(screenX/16),20.0,tocolor(255, 255, 255, 255),1.0,"default-bold","left","center",false,false,false, true)
    if #topChat >= 8 then table.remove(topChat, 1) end
    for k, v in ipairs(topChat) do
      dxDrawRectangle(screenX/4+(screenX/16),k*20,screenX/2-(screenX/16),20.0,tocolor(0,0,0,150),false)
      dxDrawText("    "..v[1],screenX/4+(screenX/16),k*40,screenX/2-(screenX/16),20.0,tocolor(v[2],v[3],v[4],255),1.0,"default-bold","left","center",false,false,false, true)
    end
  end
)

function outputTopChat(message, r, g, b)
  table.insert(topChat, { message, r, g, b })
  local thetime = getRealTime()
  outputConsole("["..string.format("%.2d:%.2d:%.2d", thetime.hour, thetime.minute, thetime.second).."] "..message:gsub("#%x%x%x%x%x%x", ""))
  setTimer(function() table.remove(topChat, 1) end, 60000, 1)
end
addEvent("outputTopChat", true)
addEventHandler("outputTopChat", root, outputTopChat)




addEventHandler("onClientPlayerJoin", root,
  function()
    outputTopChat("* " .. getPlayerName(source) .. " has joined the game", 255, 100, 100)
  end
)

addEventHandler('onClientPlayerChangeNick', root,
  function(oldNick, newNick)
    outputTopChat("* " .. oldNick .. " is now known as " .. newNick, 255, 100, 100)
  end
)

addEventHandler('onClientPlayerQuit', root,
  function(reason)
    outputTopChat("* " .. getPlayerName(source) .. " has left the game [" .. reason .. "]", 255, 100, 100)
  end
)

function showInfo()
  outputTopChat("* MOGA TOP CHAT.", 255, 100, 100)
  outputTopChat("* <3", 255, 100, 100)
  outputTopChat("* <3", 255, 100, 100)
  local thetime = getRealTime()
  outputTopChat("* Yo Yo Yo!".. thetime.year+1900 .." ssmoke.", 255, 100, 100)
end
addCommandHandler("ver", showInfo)
addCommandHandler("sver", showInfo)
addCommandHandler("credits", showInfo)
