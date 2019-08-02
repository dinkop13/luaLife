c 		= require("consolUnit")
gens 	= require("gUnit")
ui 		= require("UIUnit")
game 	= require("gameUnit")

local unit = {}

	function unit.withSetup( option )
		
	end

	function unit.test()

		zoom_state = 0

		option = {
			X_SIZE = 64,
			Y_SIZE = 64,
		}

		c.out(".. .. START game")
		game.start(option)

		c.out(".. .. START ui")
		ui.start(option)

		function step()
			
			game.step()
			ui.upd(game.getf())

		end

		loop = timer.performWithDelay( 4, step, 0 )

		function play( speed )
				timer.cancel(loop)

				local loop = timer.performWithDelay( 1100 - 100*speed, step, 0 )
		end

		local function onKeyEvent( event )
		    --print( "Key '" .. event.keyName .. "' was pressed " .. event.phase )
		 
		    if ( event.keyName == "down" ) and ( event.phase == "down") then
		    	print("d")

		    	ui.cells.mainGrp.y = ui.cells.mainGrp.y - 35

		    elseif ( event.keyName == "up" ) and ( event.phase == "down") then
		    	print("u")

		    	ui.cells.mainGrp.y = ui.cells.mainGrp.y + 35

		    elseif ( event.keyName == "left" ) and ( event.phase == "down") then
		    	print("l")

		    	ui.cells.mainGrp.x = ui.cells.mainGrp.x + 35

		    elseif ( event.keyName == "right" ) and ( event.phase == "down") then
		    	print("r")

		    	ui.cells.mainGrp.x = ui.cells.mainGrp.x - 35

		    elseif ( event.keyName == "0" ) and ( event.phase == "down") then
		    	print("0")

		    		ui.cells.mainGrp.x = display.contentCenterX + 200
					ui.cells.mainGrp.y = display.contentCenterY - 45 	

		    elseif ( event.keyName == "+" ) and ( event.phase == "down") then
		    	print("+")

		    	if zoom_state < 10 then
		    			zoom_state = zoom_state + 1

		    		ui.cells.mainGrp.xScale = 0.8 + (zoom_state/5)
		    		ui.cells.mainGrp.yScale = 0.8 + (zoom_state/5)

		    	end

		    elseif ( event.keyName == "-" ) and ( event.phase == "down") then
		    	print("-")

		    	if zoom_state > -5 then
		    			zoom_state = zoom_state - 1

		    		ui.cells.mainGrp.xScale = 0.8 + (zoom_state/5)
		    		ui.cells.mainGrp.yScale = 0.8 + (zoom_state/5)
		    	end

		    end
		 
		    return false
		end

		Runtime:addEventListener( "key", onKeyEvent )

		c.out(".. .. input start")
	end

return unit