function ReplaceSkin()
txd = engineLoadTXD('wmybmx.txd', 23)
engineImportTXD(txd, 23)
dff = engineLoadDFF('wmybmx.dff', 23)
engineReplaceModel(dff, 23)
txd = engineLoadTXD('wmydrug.txd', 29)
engineImportTXD(txd, 29)
dff = engineLoadDFF('wmydrug.dff', 29)
engineReplaceModel(dff, 29)
txd = engineLoadTXD('bmypol2.txd', 67)
engineImportTXD(txd, 67)
dff = engineLoadDFF('bmypol2.dff', 67)
engineReplaceModel(dff, 67)
txd = engineLoadTXD('fam1.txd', 105)
engineImportTXD(txd, 105)
dff = engineLoadDFF('fam1.dff', 105)
engineReplaceModel(dff, 105)
txd = engineLoadTXD('fam2.txd', 106)
engineImportTXD(txd, 106)
dff = engineLoadDFF('fam2.dff', 106)
engineReplaceModel(dff, 106)
end
addEventHandler( 'onClientResourceStart', getResourceRootElement(getThisResource()), ReplaceSkin)