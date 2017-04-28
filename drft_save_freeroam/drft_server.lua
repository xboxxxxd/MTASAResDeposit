local root = getRootElement()
local thisResourceRoot = getResourceRootElement(getThisResource())
local drift_records = {}
--local drift_record_number = 0
--local drift_record_player = "N/A"

-- Record Saving

function XMLInit()
xmlRecordsFile = xmlLoadFile("recordDrift.xml")
scorenode = xmlFindChild( xmlRecordsFile, "score", 0 )
xmlRecordScore = xmlNodeGetValue( scorenode )

playernode = xmlFindChild ( xmlRecordsFile, "name", 0 )
xmlRecordPlayer = xmlNodeGetValue( playernode )

drift_record_number = tonumber(xmlRecordScore)

drift_record_player = xmlRecordPlayer

--outputChatBox("The Current Drift Record holder is: "..xmlRecordPlayer.." with "..xmlRecordScore.." Points!", root, 255, 255, 255 )
xmlUnloadFile( xmlRecordsFile )
end


function XMLSetRecord(record,user)
xmlRecordsFile = xmlLoadFile("recordDrift.xml")

scorexml = xmlFindChild( xmlRecordsFile, "score", 0 )

xmlNodeSetValue( scorexml, record )


playerxml = xmlFindChild( xmlRecordsFile, "name", 0 )

xmlNodeSetValue( playerxml, user )
xmlSaveFile( xmlRecordsFile )





xmlUnloadFile( xmlRecordsFile )

end
addEventHandler("onResourceStart", thisResourceRoot, XMLInit )

-- Drift Ranks
call(getResourceFromName("scoreboard"), "addScoreboardColumn", "Drift Rank")
function updatelvl()
    local players = getElementsByType ( "player" )
    for theKey,thePlayer in ipairs(players) do
        totaldrift = tonumber(getElementData(thePlayer, "Drift Score" )) or 0
        if totaldrift < 99000 then
        setElementData(thePlayer, "Drift Rank", "Newbie" )
        elseif totaldrift > 100000 and totaldrift < 500000 then
        setElementData(thePlayer, "Drift Rank", "Trained" )
        elseif totaldrift > 500000 and totaldrift < 1000000 then
        setElementData(thePlayer, "Drift Rank", "Drifter" )
        elseif totaldrift > 1000000 and totaldrift < 5000000 then
        setElementData(thePlayer, "Drift Rank", "Adv. Drifter" )
        elseif totaldrift > 5000000 and totaldrift < 25000000 then
        setElementData(thePlayer, "Drift Rank", "Best Drifter" )
        elseif totaldrift > 25000000 and totaldrift < 50000000 then
        setElementData(thePlayer, "Drift Rank", "Drift Expert" )
        elseif totaldrift > 50000000 and totaldrift < 100000000 then
        setElementData(thePlayer, "Drift Rank", "Drift King" )
        elseif totaldrift > 100000000 and totaldrift < 250000000 then
        setElementData(thePlayer, "Drift Rank", "Drift Master" )
		elseif totaldrift > 250000000 and totaldrift < 500000000 then
        setElementData(thePlayer, "Drift Rank", "Drift Legend" )
        elseif totaldrift > 500000000 then
        setElementData(thePlayer, "Drift Rank", "Drift Elite" )
        end
 end
end
setTimer( updatelvl, 30000, 0 )


addEventHandler ( "onResourceStart", thisResourceRoot,
	function()
		call(getResourceFromName("scoreboard"), "addScoreboardColumn", "Best Drift")
		call(getResourceFromName("scoreboard"), "addScoreboardColumn", "Last Drift")
		call(getResourceFromName("scoreboard"), "addScoreboardColumn", "Drift Score")
		XMLInit()
		addEvent("driftClienteListo", true)
		addEventHandler("driftClienteListo", root, function(player)
			triggerClientEvent(player, "driftActualizarRecord", root, drift_record_number, drift_record_player)
			if drift_record_number == 0 then
				outputChatBox("There's no drift record set!", player)
			else
				outputChatBox(string.format("The current drift record is %d points (%s)", drift_record_number, drift_record_player), player)
			end
		end)
	end
)

addEventHandler ( "onResourceStop", thisResourceRoot,
	function()
		call(getResourceFromName("scoreboard"), "removeScoreboardColumn", "Best Drift")
		call(getResourceFromName("scoreboard"), "removeScoreboardColumn", "Last Drift")
		call(getResourceFromName("scoreboard"), "removeScoreboardColumn", "Drift Score")
	end
)

addEventHandler ( "onGamemodeMapStop", root, function(mapResource)
end)

addEventHandler("onVehicleDamage", root, function()
	thePlayer = getVehicleOccupant(source, 0)
	if thePlayer then
		triggerClientEvent(thePlayer, "driftCarCrashed", root, source)
	end
end)

addEvent("driftNuevoRecord", true)
addEventHandler("driftNuevoRecord", root, function(score, name)
	if score > drift_record_number then
		outputChatBox(string.format("New drift record! (%d points) (%s)",score,name)) 
		drift_record_number = score
		drift_record_player = name
		XMLSetRecord( score, name )
		triggerClientEvent(root, "driftActualizarRecord", root, drift_record_number, drift_record_player)
	end
end)


function gcash(player,money)
givePlayerMoney( player, tonumber(money) )
end
addEvent("updatecash", true )
addEventHandler("updatecash", root, gcash )


-- saving / Load


function loadDrift (thePreviousAccount, theCurrentAccount, autoLogin)
  if  not (isGuestAccount (getPlayerAccount (source))) then

      if getAccountData(theCurrentAccount, "Drift Score") == false or getAccountData(theCurrentAccount, "Drift Score") == nil then
	  setAccountData(theCurrentAccount, "Drift Score", 0 )
	  setElementData(source, "Drift Score", 0 )
	  end
	  setElementData( source, "Drift Score", getAccountData(theCurrentAccount, "Drift Score" ) )
	  
	  
	   if getAccountData(theCurrentAccount, "Best Drift") == false or getAccountData(theCurrentAccount, "Best Drift") == nil then
	  setAccountData(theCurrentAccount, "Best Drift", 0 )
	  setElementData(source, "Best Drift", 0 )
	  end
	  setElementData( source, "Best Drift", getAccountData(theCurrentAccount, "Best Drift" ) )
	  
	  
  end
end
addEventHandler ("onPlayerLogin", getRootElement(), loadDrift)


function saveDrift (quitType, reason, responsibleElement)
  if not (isGuestAccount (getPlayerAccount (source))) then
    account = getPlayerAccount (source)
    if (account) then
  	  if getElementData(source, "Drift Score") == false or getElementData(source, "Drift Score") == nil then
	  setAccountData(account, "Drift Score", 0 )
	  setElementData(source, "Drift Score", 0 )
	  end
	 setAccountData(account, "Drift Score", getElementData(source, "Drift Score" ) )
	  
	  if getElementData(source, "Best Drift") == false or getElementData(source, "Best Drift") == nil then
	  setAccountData(account, "Best Drift", 0 )
	  setElementData(source, "Best Drift", 0 )
	  end
	  setAccountData(account, "Best Drift", getElementData(source, "Best Drift" ) )
	  
  
 end
end
end
addEventHandler ("onPlayerQuit", getRootElement(), saveDrift)
