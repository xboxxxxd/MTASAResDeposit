
function rdx ( message )
    removeEventHandler ( "onClientRender", getRootElement(  ), dx )
    function dx(  )
    dxDrawText ( "Admin :", 33.0, 267.0, 155.0, 182.0, tocolor ( 255, 255, 0, 0 ), 1.2, "default-bold", "left", "top", false, false, false )
     dxDrawText ( message, 25.0, 188.0, 799.0, 224.0, tocolor(math.random(255,255),math.random(0,0),math.random(0,0)), 1.2, "default-bold", "left", "top", false, false, false )
    end
    addEventHandler("onClientRender", getRootElement(  ), dx )
end
addEvent ( "sora", true )
addEventHandler ( "sora", getRootElement(  ), rdx )
bindKey ( "i", "down", "chatbox", "Admin" )


addEventHandler ( "onClientResourceStart", resourceRoot, function (  )
triggerServerEvent ( "SetMessage", localPlayer )
end
)
