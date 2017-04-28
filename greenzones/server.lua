addEventHandler ("onResourceStart",getResourceRootElement(getThisResource()),
function()
  local allGreenzones = getElementsByType ("radararea")
  for i,v in ipairs (allGreenzones) do
    local r,g,b,a = getRadarAreaColor (v)
    if (r == 0) and (g == 255) and (b == 0) and (a == 127) then
      local x,y = getElementPosition (v)
      local sx,sy = getRadarAreaSize (v)
      local col = createColCuboid (x,y, -50, sx,sy, 7500)
      setElementID (col, "greenzoneColshape")
    end
  end
end)

addEventHandler ("onColShapeHit", getRootElement(), 
function(hitElement, matchingDimension)
  if (isElement(hitElement)) and (getElementType (hitElement) == "player") and (getElementID (source) == "greenzoneColshape") then
    toggleControl (hitElement, "fire", false)
    toggleControl (hitElement, "next_weapon", false)
    toggleControl (hitElement, "previous_weapon", false)
    toggleControl (hitElement, "aim_weapon", false)
    toggleControl (hitElement, "vehicle_fire", false)
    showPlayerHudComponent (hitElement, "ammo", false)
    showPlayerHudComponent (hitElement, "weapon", false)
    triggerClientEvent (hitElement, "enableGodMode", hitElement)
    outputDebugString (getPlayerName(hitElement) .. " has entered the greenzone")
  end
end)

addEventHandler ("onColShapeLeave", getRootElement(), 
function(leaveElement, matchingDimension)
  if (getElementType (leaveElement) == "player") and (getElementID (source) == "greenzoneColshape") then
    toggleControl (leaveElement, "fire", true)
    toggleControl (leaveElement, "next_weapon", true)
    toggleControl (leaveElement, "previous_weapon", true)
    toggleControl (leaveElement, "aim_weapon", true)
    toggleControl (leaveElement, "vehicle_fire", true)
    showPlayerHudComponent (leaveElement, "ammo", true)
    showPlayerHudComponent (leaveElement, "weapon", true)
    triggerClientEvent (leaveElement, "disableGodMode", leaveElement)
    outputDebugString (getPlayerName(leaveElement) .. " has left the greenzone")
  end
end)