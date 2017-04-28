function ReplaceTexture()
txd0 = engineLoadTXD ('justlowbpan.txd')
engineImportTXD (txd0, 4821)
txd1 = engineLoadTXD ('justlowbpan.txd')
engineImportTXD (txd1, 4853)
txd2 = engineLoadTXD ('justlowbpan.txd')
engineImportTXD (txd2, 5033)
end
addEventHandler( 'onClientResourceStart', getResourceRootElement(getThisResource()), ReplaceTexture)