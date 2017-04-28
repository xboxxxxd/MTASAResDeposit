---------------- Script by ssmoke-----------------------


ID = 31

function TXDFile ()
	TXD = engineLoadTXD( "dwfolc.txd" ) 
	engineImportTXD( TXD, ID )
end 
addEventHandler( "onClientResourceStart", resourceRoot, TXDFile )


function DFFFile ()
	DFF = engineLoadDFF( "dwfolc.dff", 0 ) 
	engineReplaceModel ( DFF, ID )

end 
addEventHandler( "onClientResourceStart", resourceRoot, DFFFile )

---------------- Script by ssmoke-----------------------
