---------------- Script by Mr.Worm aka Skill3d -----------------------


ID = 602

function TXDFile ()
	TXD = engineLoadTXD( "alpha.txd" ) 
	engineImportTXD( TXD, ID )
end 
addEventHandler( "onClientResourceStart", resourceRoot, TXDFile )


function DFFFile ()
	DFF = engineLoadDFF( "alpha.dff", 0 ) 
	engineReplaceModel ( DFF, ID )

end 
addEventHandler( "onClientResourceStart", resourceRoot, DFFFile )

---------------- Script by Mr.Worm aka Skill3d -----------------------
