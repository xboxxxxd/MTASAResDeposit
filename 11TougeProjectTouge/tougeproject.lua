function map()
	txd = engineLoadTXD ( "springshorse.txd" )
		engineImportTXD ( txd, 2277 )
	col = engineLoadCOL ( "springshorse.col" )
	dff = engineLoadDFF ( "projectouge.dff", 0 )
	engineReplaceCOL ( col, 2277 )
	engineReplaceModel ( dff, 2277 )
	engineSetModelLODDistance(2277, 2000)

end

setTimer ( map, 1000, 1)
addCommandHandler("reloadmap",map)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
		engineRestoreCOL(2277)
		engineRestoreModel(2277)
		destroyElement(dff)
		destroyElement(col)
		destroyElement(txd)
	end
)