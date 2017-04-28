
------------
-- Events --
------------

function playerJoined()
    check(source)
end
addEventHandler("onPlayerJoin",getRootElement(),playerJoined)

function playerChangedNick(oldNick,newNick)
    -- Use timer to wait until the nick really has changed
    setTimer(check,1000,1,source)
end
addEventHandler("onPlayerChangeNick",getRootElement(),playerChangedNick)

function playerQuit()
    removePlayerFromTeam(source)
end
addEventHandler("onPlayerQuit",getRootElement(),playerQuit)

-- Check for ACL Groups on login/logout
function loggedIn()
    check(source)
end
addEventHandler("onPlayerLogin",getRootElement(),loggedIn)

function loggedOut()
    check(source)
end
addEventHandler("onPlayerLogout",getRootElement(),loggedOut)


-- Holds the teams as defined in the settings
local teams = {}

---
-- Reads the settings and creates the teams if enabled.
--
function initiate()
    local rootNode = xmlLoadFile("config.xml")
    local children = xmlNodeGetChildren(rootNode)
    if children == false then
        return
    end
    for _,node in pairs(children) do
        local attributes = xmlNodeGetAttributes(node)
        local name = attributes.name
        local color = {getColorFromString(attributes.color)}
        if not color[1] then
            color = {255,255,255}
        end
        teams[name] = attributes
        teams[name].color = color
        if not toboolean(get("noEmptyTeams")) then
            teams[name].team = createTeam(name,unpack(color))
        end
    end
    for k,v in pairs(getElementsByType("player")) do
        check(v)
    end
end
addEventHandler("onResourceStart",getResourceRootElement(),initiate)

---------------
-- Functions --
---------------

---
-- Checks the player's nick and ACL Groups and sets his team if necessary.
--
-- @param   player   player: The player element
--
function check(player)
    if not isElement(player) or getElementType(player) ~= "player" then
        debug("No player")
        return
    end
    local nick = getPlayerName(player)
    local accountName = getAccountName(getPlayerAccount(player))
    for name,data in pairs(teams) do
        local tagMatch = false
        local aclGroupMatch = false
        if data.tag ~= nil and string.find(nick,data.tag,1,true) then
            tagMatch = true
        end
        if data.aclGroup ~= nil and accountName and isObjectInACLGroup("user."..accountName,aclGetGroup(data.aclGroup)) then
            aclGroupMatch = true
        end
        if data.required == "both" then
            if tagMatch and aclGroupMatch then
                addPlayerToTeam(player,name)
                setTimer(check2, 500, 1)
                return
            end
        else
            if tagMatch or aclGroupMatch then
                addPlayerToTeam(player,name)
                setTimer(check2, 500, 1)
                return
            end
        end
    end
    removePlayerFromTeam(player)
    setPlayerTeam(player,nil)
    setTimer(check2, 500, 1)
end

function check2()
    if toboolean(get("noEmptyTeams")) then
        for i,v in pairs(teams) do
            team2 = teams[i].name
            team = getTeamFromName(teams[i].name)
            if isElement(team) and getElementType(team) == "team" then
                if countPlayersInTeam(team) == 0 then
                    debug("Removed team '" .. tostring(team2) .. "' since it has no players")
                    destroyElement(team)
                end
            end
        end
    end
end

---
-- Adds a player to the team appropriate for the name.
-- It is not checked if the team is really defined in the table, since
-- it should only be called if it is.
--
-- Creates the team if it doesn't exist.
--
-- @param   player   player: The player element
-- @param   string   name: The name of the team
--
function addPlayerToTeam(player,name)
    local team = teams[name].team
    if not isElement(team) or getElementType(team) ~= "team" then
        team = createTeam(teams[name].name,unpack(teams[name].color))
        teams[name].team = team
    end
    setTimer(setPlayerTeam, 500, 1, player, team)
    debug("Added player '"..getPlayerName(player).."' to team '"..name.."'")
end

---
-- Removes a player from a team. Also checks if any team
-- needs to be removed.
--
-- @param   player   player: The player element
--
function removePlayerFromTeam(player)
    setPlayerTeam(player, nil)
    debug("Removed player '"..getPlayerName(player).."' from team")
    --[[if toboolean(get("noEmptyTeams")) then
        for i,v in pairs(teams) do
            team = getTeamFromName(teams[i].name)
            if isElement(team) and getElementType(team) == "team" then
                if countPlayersInTeam(team) == 0 then
                    destroyElement(team)
                end
            end
        end
    end]]
end

---
-- Converts a string-boolean into a boolean.
--
-- @param   string   string: The string (e.g. "false")
-- @return  true/false       Returns false if the string is "false" or evaluates to false (nil/false), true otherwise
--
function toboolean(string)
    if string == "false" or not string then
        return false
    end
    return true
end

-----------
-- Debug --
-----------

-- Little debug function to turn on/off debug
setElementData(getResourceRootElement(),"debug",true)
function debug(string)
    if getElementData(getResourceRootElement(),"debug") then
        outputDebugString("autoteams: "..string)
    end
end
