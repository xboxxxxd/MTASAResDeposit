---------------- Script by Sherman -----------------------


ID = 63

function TXDFile ()
	TXD = engineLoadTXD( "bfypro.txd" ) 
	engineImportTXD( TXD, ID )
end 
addEventHandler( "onClientResourceStart", resourceRoot, TXDFile )


function DFFFile ()
	DFF = engineLoadDFF( "bfypro.dff", 0 ) 
	engineReplaceModel ( DFF, ID )

end 
addEventHandler( "onClientResourceStart", resourceRoot, DFFFile )

---------------- Script by Sherman -----------------------
