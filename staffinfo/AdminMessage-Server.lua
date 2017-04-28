
Groups = {  
"Admin",
"Console", 
} 

function check ( thePlayer, commandName, ... )
        local accName = getAccountName ( getPlayerAccount ( thePlayer ) ) 
        local veve = { ... }
        local message = table.concat ( veve, " " )
        for i, v in ipairs ( Groups ) do
          if isObjectInACLGroup ( "user."..accName, aclGetGroup ( v ) ) then        
        setElementData ( resourceRoot, "MessageAdmin", message )
        SaveMessage (  )
        triggerClientEvent ( "sora", getRootElement(  ), getElementData ( resourceRoot, "MessageAdmin" ) )
        end
    end
end
addCommandHandler( "Admin", check )

addEventHandler ( "onResourceStart", resourceRoot, function (  )
        executeSQLQuery("CREATE TABLE IF NOT EXISTS SaveMessagee (Message, Server)")
end
)

addEvent ( "SetMessage", true )
addEventHandler ( "SetMessage", root, function (  )
   getMessage (  )
end
)

SaveMessage = function (  )
local msg = executeSQLQuery ( "SELECT * FROM SaveMessagee WHERE Server = '" .. getServerName ( ) .."'" )
if ( #msg ~= 0  )   then
   return executeSQLQuery("UPDATE SaveMessagee SET Message=? WHERE Server=? ", tostring ( getElementData ( resourceRoot, "MessageAdmin"  ) ), getServerName ( ) )
else
   return executeSQLQuery("INSERT INTO SaveMessagee (Message,Server) VALUES(?,?)", tostring ( getElementData ( resourceRoot, "MessageAdmin" ) ), getServerName ( ) )
   end
end

getMessage = function (  )
local msg = executeSQLQuery ( "SELECT * FROM SaveMessagee" )
if ( #msg ~= 0  ) then
    setElementData ( resourceRoot, "MessageAdmin", msg[1]["Message"] )
    return setTimer ( triggerClientEvent, 100, 1, "sora", getRootElement(  ), getElementData ( resourceRoot, "MessageAdmin" ) )
else
   return setTimer ( triggerClientEvent, 100, 1, "sora", getRootElement(  ), " " )
  end
end 




