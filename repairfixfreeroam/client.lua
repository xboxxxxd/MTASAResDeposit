addEvent ( "DiscoShakeDance", true )
addEventHandler("DiscoShakeDance", root,
function (thePed, block, anim)
    setPedAnimation( thePed, block, anim )
end)


addEvent ( "Disco_shake_sound", true )
addEventHandler ( "Disco_shake_sound", root,
    function (sound, x, y, z, bol )
   local shake = playSound3D("disco.mp3", x, y, z, bol) 
    setSoundMaxDistance( disco, 1000 )
    setSoundEffectEnabled(disco, echo, true)
 end
)