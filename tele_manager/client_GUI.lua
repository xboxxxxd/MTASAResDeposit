function initGUI()
	drawMainTele()
	drawTeleWizard()
	addEventHandler ( "onClientGUIClick", teleManager, teleManagerClick )
	addEventHandler ( "onClientGUIClick", teleWizard, teleWizardClick )
	checkPermissions()
end

function drawMainTele()
	local wX = 0.2
	local wY = 0.25
	local wWidth = 0.45
	local wHeight = 0.45
	teleManager = guiCreateWindow ( wX, wY, wWidth, wHeight, "Teleport Manager", true ) guiWindowSetSizable ( teleManager, false ) guiSetVisible ( teleManager, false )
	
	teleManagerClose = guiCreateButton ( 0.25, 0.85, 0.5, 0.1, "Close", true, teleManager )
	teleManagerAddTele = guiCreateButton ( 0.7, 0.15, 0.25, 0.1, "Add Teleport", true, teleManager )
	teleManagerDeleteTele = guiCreateButton ( 0.7, 0.3, 0.25, 0.1, "Delete Teleport", true, teleManager )
	teleManagerUseTele = guiCreateButton ( 0.7, 0.6, 0.25, 0.15, "Use Teleport", true, teleManager )
	
	listLabel = guiCreateLabel ( 0.05, 0.1, 0.5, 0.1, "Available Teleports:", true, teleManager )
	
	list = guiCreateGridList ( 0.05, 0.15, 0.6, 0.6, true, teleManager ) guiGridListSetSortingEnabled ( list, false )
	listDescColumn = guiGridListAddColumn ( list, "Description", 0.6 )
	listTypeColumn = guiGridListAddColumn ( list, "Teleport Type", 0.3 )
end

function drawTeleWizard()
	local wX = 0.2
	local wY = 0.25
	local wWidth = 0.26
	local wHeight = 0.45
	teleWizard = guiCreateWindow ( wX, wY, wWidth, wHeight, "Teleport Wizard", true ) guiWindowSetSizable ( teleWizard, false ) guiSetVisible ( teleWizard, false )
	
	teleWizardClose = guiCreateButton ( 0.15, 0.85, 0.7, 0.1, "Close", true, teleWizard )
	teleWizardAddTele = guiCreateButton ( 0.35, 0.74, 0.3, 0.07, "Add Teleport", true, teleWizard )
	teleWizardGetPos = guiCreateButton ( 0.6, 0.295, 0.2, 0.05, "Get Cur Pos", true, teleWizard )
	teleWizardXLabel = guiCreateLabel ( 0.05, 0.1, 0.3, 0.1, "Teleport X:", true, teleWizard )
	teleWizardYLabel = guiCreateLabel ( 0.05, 0.2, 0.3, 0.1, "Teleport Y:", true, teleWizard )
	teleWizardZLabel = guiCreateLabel ( 0.05, 0.3, 0.3, 0.1, "Teleport Z:", true, teleWizard )
	teleWizardRotLabel = guiCreateLabel ( 0.6, 0.12, 0.3, 0.08, "Player Rotation:", true, teleWizard )
	teleDescriptionLabel = guiCreateLabel ( 0.05, 0.45, 0.9, 0.1, "Teleport Description (Needs to fit inside GUI)", true, teleWizard )
	teleTypeLabel = guiCreateLabel ( 0.05, 0.6, 0.9, 0.1, "Teleport Type", true, teleWizard )
	teleWizardVehOnly = guiCreateRadioButton ( 0.05, 0.64, 0.2, 0.06, "Vehicle Only", true, teleWizard )
	teleWizardFootOnly = guiCreateRadioButton ( 0.35, 0.64, 0.2, 0.06, "Foot Only", true, teleWizard )
	teleWizardBoth = guiCreateRadioButton ( 0.65, 0.64, 0.2, 0.06, "Both", true, teleWizard )
	teleWizardXBox = guiCreateEdit ( 0.22, 0.095, 0.3, 0.05, "", true, teleWizard )
	teleWizardYBox = guiCreateEdit ( 0.22, 0.192, 0.3, 0.05, "", true, teleWizard )
	teleWizardZBox = guiCreateEdit ( 0.22, 0.295, 0.3, 0.05, "", true, teleWizard )
	teleWizardDescBox = guiCreateEdit ( 0.05, 0.5, 0.8, 0.05, "Type your teleport description here.", true, teleWizard )
	
	teleWizardRotBox = guiCreateEdit ( 0.6, 0.192, 0.1, 0.05, "", true, teleWizard )
	

end

addEventHandler ( "onClientResourceStart", getResourceRootElement ( getThisResource() ), initGUI )