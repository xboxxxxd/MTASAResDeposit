---------------- Script by Mr.Worm aka Skill3d -----------------------


ID = 503

function TXDFile ()
	TXD = engineLoadTXD( "1.txd" ) 
	engineImportTXD( TXD, ID )
end 
addEventHandler( "onClientResourceStart", resourceRoot, TXDFile )


function DFFFile ()
	DFF = engineLoadDFF( "1.dff", 0 ) 
	engineReplaceModel ( DFF, ID )

end 
addEventHandler( "onClientResourceStart", resourceRoot, DFFFile )

---------------- Script by Mr.Worm aka Skill3d -----------------------
