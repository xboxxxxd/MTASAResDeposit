---------------- Script by Sherman -----------------------


ID = 579

function TXDFile ()
	TXD = engineLoadTXD( "huntley.txd" ) 
	engineImportTXD( TXD, ID )
end 
addEventHandler( "onClientResourceStart", resourceRoot, TXDFile )


function DFFFile ()
	DFF = engineLoadDFF( "huntley.dff", 0 ) 
	engineReplaceModel ( DFF, ID )

end 
addEventHandler( "onClientResourceStart", resourceRoot, DFFFile )

---------------- Script by Sherman -----------------------
