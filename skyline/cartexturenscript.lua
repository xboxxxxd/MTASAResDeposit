---------------- Script by Mr.Worm aka Skill3d -----------------------


ID = 529

function TXDFile ()
	TXD = engineLoadTXD( "willard.txd" ) 
	engineImportTXD( TXD, ID )
end 
addEventHandler( "onClientResourceStart", resourceRoot, TXDFile )


function DFFFile ()
	DFF = engineLoadDFF( "willard.dff", 0 ) 
	engineReplaceModel ( DFF, ID )

end 
addEventHandler( "onClientResourceStart", resourceRoot, DFFFile )

---------------- Script by Mr.Worm aka Skill3d -----------------------
