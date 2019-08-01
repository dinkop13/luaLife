run = require("runUnit")

u01 = display.newText("Press key to run :\n",
	display.contentCenterX, display.contentCenterY, "Anonymous_Pro.ttf", 22)

u02 = display.newText("> t - to run test\n> w - to run gens.txt\n> n - to run new generation\n> x - лучше блять не трогай",
	display.contentCenterX, display.contentCenterY+ 60 , "Anonymous_Pro.ttf", 22)
u02 : setFillColor( 0.3 )

		local function onKeyEvent( event )
		 
		    if ( event.keyName == "t" ) and ( event.phase == "down") then

		    	run.test()

		    	Runtime:removeEventListener( "key", onKeyEvent )

		    	u01:removeSelf()
		    	u02:removeSelf()

		    elseif ( event.keyName == "w" ) and ( event.phase == "down") then

		    elseif ( event.keyName == "n" ) and ( event.phase == "down") then

		    elseif ( event.keyName == "x" ) and ( event.phase == "down") then

		    end
		 
		    return false
		end

		Runtime:addEventListener( "key", onKeyEvent )