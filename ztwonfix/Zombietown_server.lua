function outbreak()
	resetSkyGradient (0,25,0,0,25,0)

	local theMarker = createMarker ( 2333.09375, 61.634765625, 26.70578956604, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "ammuout" )
	
	local theMarker = createMarker ( 2332.2121582031, 61.490077972412, 20.832027435303, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "ammuint" )
	
	local theMarker = createMarker ( 2304.078125, 55.7265625, 26.4765625, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "furnout" )
	
	local theMarker = createMarker ( 2305.703125, 56.63151550293, 9.0494155883789, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "furnint" )
	
	local theMarker = createMarker ( 2331.8125, 75.2802734375, 26.620975494385, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "pizzaout" )
	
	local theMarker = createMarker ( 2330.861328125, 74.905715942383, 16.110990524292, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "pizzaint" )
	
	local theMarker = createMarker ( 2273.6450195313, 82.049018859863, 26.484375, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "hotel1out" )
	
	local theMarker = createMarker ( 2276.6938476563, 82.356628417969, 20.435848236084, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "hotel1int" )
	
	local theMarker = createMarker ( 2284.2814941406, 72.007194519043, 26.484375, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "hotel2out" )
	
	local theMarker = createMarker ( 2283.7065429688, 72.301872253418, 20.443227767944, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "hotel2int" )
	
	local theMarker = createMarker ( 2275.4919433594, 66.336357116699, 26.484375, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "hotel3out" )
	
	local theMarker = createMarker ( 2276.1843261719, 63.71821975708, 20.435848236084, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "hotel3int" )
	
	local theMarker = createMarker ( 2258.5754394531, 79.443206787109, 26.484375, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "hotel4out" )
	
	local theMarker = createMarker ( 2262.7377929688, 83.400741577148, 20.435317993164, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "hotel4int" )
	
	local theMarker = createMarker ( 2265.0988769531, 82.049797058105, 26.484375, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "hotel5out" )
	
	local theMarker = createMarker ( 2269.4897460938, 83.070610046387, 20.435848236084, "cylinder", 1.0, 255, 255, 0, 170 )
	setElementData ( theMarker, "doorid", "hotel5int" )
end
addEventHandler("onResourceStart", resourceRoot, outbreak)

function doorhit ( hitPlayer, matchingDimension )
	if ( getElementData ( hitPlayer, "warpstatus" ) ~="warping" ) and (isPedOnGround (hitPlayer)) then
		setElementData ( hitPlayer, "warpstatus", "warping" )	
		setTimer ( setElementData, 1500, 1, hitPlayer, "warpstatus", nil)		
		local doorid = getElementData ( source, "doorid" )
		if doorid == "ammuout" then
			setElementPosition ( hitPlayer, 2332.2121582031, 61.490077972412, 20.832027435303 )
		elseif doorid == "ammuint" then
			setElementPosition ( hitPlayer, 2333.09375, 61.634765625, 26.70578956604 )
		elseif doorid == "furnout" then
			setElementPosition ( hitPlayer, 2305.703125, 56.63151550293, 9.0494155883789)
		elseif doorid == "furnint" then
			setElementPosition ( hitPlayer, 2304.078125, 55.7265625, 26.4765625 )
		elseif doorid == "pizzaout" then
			setElementPosition ( hitPlayer, 2330.861328125, 74.905715942383, 16.110990524292 )
		elseif doorid == "pizzaint" then
			setElementPosition ( hitPlayer, 2331.8125, 75.2802734375, 26.620975494385 )
		elseif doorid == "hotel1out" then
			setElementPosition ( hitPlayer, 2276.6938476563, 82.356628417969, 20.435848236084 )
		elseif doorid == "hotel1int" then
			setElementPosition ( hitPlayer, 2273.6450195313, 82.049018859863, 26.484375 )
		elseif doorid == "hotel2out" then
			setElementPosition ( hitPlayer, 2283.7065429688, 72.301872253418, 20.443227767944 )
		elseif doorid == "hotel2int" then
			setElementPosition ( hitPlayer, 2284.2814941406, 72.007194519043, 26.484375 )
		elseif doorid == "hotel3out" then
			setElementPosition ( hitPlayer, 2276.1843261719, 63.71821975708, 20.435848236084 )
		elseif doorid == "hotel3int" then
			setElementPosition ( hitPlayer, 2275.4919433594, 66.336357116699, 26.484375 )
		elseif doorid == "hotel4out" then
			setElementPosition ( hitPlayer, 2262.7377929688, 83.400741577148, 20.435317993164 )
		elseif doorid == "hotel4int" then
			setElementPosition ( hitPlayer, 2258.5754394531, 79.443206787109, 26.484375 )
		elseif doorid == "hotel5out" then
			setElementPosition ( hitPlayer, 2269.4897460938, 83.070610046387, 20.435848236084 )
		elseif doorid == "hotel5int" then
			setElementPosition ( hitPlayer, 2265.0988769531, 82.049797058105, 26.484375 )
		end
	end
end
addEventHandler("onMarkerHit", getRootElement (), doorhit)