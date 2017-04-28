---------------- Script by ssmoke-----------------------


ID = 32

function TXDFile ()
	TXD = engineLoadTXD( "dwmolc1.txd" ) 
	engineImportTXD( TXD, ID )
end 
addEventHandler( "onClientResourceStart", resourceRoot, TXDFile )


function DFFFile ()
	DFF = engineLoadDFF( "dwmolc1.dff", 0 ) 
	engineReplaceModel ( DFF, ID )

end 
addEventHandler( "onClientResourceStart", resourceRoot, DFFFile )

---------------- Script by ssmoke-----------------------
