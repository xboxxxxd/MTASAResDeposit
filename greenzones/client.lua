--[[

 Greenzone Script by JasperNL=D
 
      _                           _   _ _      
     | |                         | \ | | |     
     | | __ _ ___ _ __   ___ _ __|  \| | |     
 _   | |/ _` / __| '_ \ / _ \ '__| . ` | |     
| |__| | (_| \__ \ |_) |  __/ |  | |\  | |____ 
 \____/ \__,_|___/ .__/ \___|_|  |_| \_|______|
                 | |                           
                 |_|                           

  Use it where you want and give to everybody you like or don't like, but don't re-publish! (�)
]]--

function godmodeHandler ()
  cancelEvent ()
end

addEvent ("enableGodMode",true)
addEventHandler ("enableGodMode",getRootElement(),
function()
  if (source == getLocalPlayer()) then
    addEventHandler ("onClientPlayerDamage",getRootElement(),godmodeHandler)
  end
end)

addEvent ("disableGodMode",true)
addEventHandler ("disableGodMode",getRootElement(),
function()
  if (source == getLocalPlayer()) then
    removeEventHandler ("onClientPlayerDamage",getRootElement(),godmodeHandler)
  end
end)