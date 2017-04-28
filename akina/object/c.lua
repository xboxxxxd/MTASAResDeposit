﻿function akina()
    txd = engineLoadTXD ( "akina.txd" )
        engineImportTXD ( txd, 3914 )
        engineImportTXD ( txd, 3911 )
        engineImportTXD ( txd, 3905 )
        engineImportTXD ( txd, 3907 )
        engineImportTXD ( txd, 3906 )
    col = engineLoadCOL ( "akina1.col" )
    col1 = engineLoadCOL ( "akina2.col" )
    col2 = engineLoadCOL ( "akina3.col" )
    col3 = engineLoadCOL ( "akina4.col" )
    col4 = engineLoadCOL ( "akina5.col" )
    dff = engineLoadDFF ( "akina1.dff", 0 )
    dff1 = engineLoadDFF ( "akina2.dff", 0 )
    dff2 = engineLoadDFF ( "akina3.dff", 0 )
    dff3 = engineLoadDFF ( "akina4.dff", 0 )
    dff4 = engineLoadDFF ( "akina5.dff", 0 )
    engineReplaceCOL ( col, 3914 )
    engineReplaceCOL ( col1, 3911 )
    engineReplaceCOL ( col2, 3905 )
    engineReplaceCOL ( col3, 3907 )
    engineReplaceCOL ( col4, 3906 )
    engineReplaceModel ( dff, 3914 )
    engineReplaceModel ( dff1, 3911 )
    engineReplaceModel ( dff2, 3905 )
    engineReplaceModel ( dff3, 3907 )
    engineReplaceModel ( dff4, 3906 )
    engineSetModelLODDistance(3914, 2000)
    engineSetModelLODDistance(3911, 2000)
    engineSetModelLODDistance(3905, 2000)
    engineSetModelLODDistance(3907, 2000)
    engineSetModelLODDistance(3906, 2000)
end
 
setTimer ( akina, 1000, 1)
addCommandHandler("akina",akina)
addCommandHandler("akinas",akina)
addCommandHandler("akinauh",akina)
addCommandHandler("akinauhs",akina)
addCommandHandler("mapas",akina)
addCommandHandler("akina",chat)
 
addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
    function()
        engineRestoreCOL(3914)
        engineRestoreCOL(3911)
        engineRestoreCOL(3905)
        engineRestoreCOL(3907)
        engineRestoreCOL(3906)
        engineRestoreModel(3914)
        engineRestoreModel(3911)
        engineRestoreModel(3905)
        engineRestoreModel(3907)
        engineRestoreModel(3906)
        destroyElement(dff)
        destroyElement(dff1)
        destroyElement(dff2)
        destroyElement(dff3)
        destroyElement(dff4)
        destroyElement(col)
        destroyElement(col1)
        destroyElement(col2)
        destroyElement(col3)
        destroyElement(col4)
        destroyElement(txd)
    end
)