---------------- Script by Mr.Worm aka Skill3d -----------------------


ID = 13

function TXDFile ()
	TXD = engineLoadTXD( "bfyst.txd" ) 
	engineImportTXD( TXD, ID )
end 
addEventHandler( "onClientResourceStart", resourceRoot, TXDFile )


function DFFFile ()
	DFF = engineLoadDFF( "bfyst.dff", 0 ) 
	engineReplaceModel ( DFF, ID )

end 
addEventHandler( "onClientResourceStart", resourceRoot, DFFFile )

---------------- Script by Mr.Worm aka Skill3d -----------------------
