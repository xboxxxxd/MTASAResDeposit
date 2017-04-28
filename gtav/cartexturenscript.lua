---------------- Script by Mr.Worm aka Skill3d -----------------------


ID = 261

function TXDFile ()
	TXD = engineLoadTXD( "wmycd1.txd" ) 
	engineImportTXD( TXD, ID )
end 
addEventHandler( "onClientResourceStart", resourceRoot, TXDFile )


function DFFFile ()
	DFF = engineLoadDFF( "wmycd1.dff", 0 ) 
	engineReplaceModel ( DFF, ID )

end 
addEventHandler( "onClientResourceStart", resourceRoot, DFFFile )

---------------- Script by Mr.Worm aka Skill3d -----------------------
