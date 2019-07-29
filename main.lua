gens = require("gUnit")
ui = require("UIUnit")
game = require("gameUnit")

zoom_state = 0

option = {
	X_SIZE = 128,
	Y_SIZE = 64,
}

game.start(option)
ui.start(option)


function step()
	

	game.step()
	ui.upd(game.getf())

end

loop = timer.performWithDelay( 400, step, 0 )

function play( speed )
		timer.cancel(loop)

		local loop = timer.performWithDelay( 1100 - 100*speed, step, 0 )
end

local function onKeyEvent( event )
    --print( "Key '" .. event.keyName .. "' was pressed " .. event.phase )
 
    if ( event.keyName == "down" ) and ( event.phase == "down") then
    	print("d")

    	ui.cells.mainGrp.y = ui.cells.mainGrp.y - 20 * zoom_state

    elseif ( event.keyName == "up" ) and ( event.phase == "down") then
    	print("u")

    	ui.cells.mainGrp.y = ui.cells.mainGrp.y + 20 * zoom_state

    elseif ( event.keyName == "left" ) and ( event.phase == "down") then
    	print("l")

    	ui.cells.mainGrp.x = ui.cells.mainGrp.x + 20 * zoom_state

    elseif ( event.keyName == "right" ) and ( event.phase == "down") then
    	print("r")

    	ui.cells.mainGrp.x = ui.cells.mainGrp.x - 20 * zoom_state

    elseif ( event.keyName == "+" ) and ( event.phase == "down") then
    	print("+")

    	if zoom_state < 10 then
    		ui.cells.mainGrp:scale(1.2, 1.2)
    			zoom_state = zoom_state + 1
    	end

    elseif ( event.keyName == "-" ) and ( event.phase == "down") then
    	print("-")

    	if zoom_state > 0 then
    		ui.cells.mainGrp:scale(0.8, 0.8)
    			zoom_state = zoom_state - 1
    	end
    end
 
    return false
end

Runtime:addEventListener( "key", onKeyEvent )