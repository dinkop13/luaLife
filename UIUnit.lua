c 		= require("consolUnit")
game 	= require("gameUnit")

local unit = {}

	unit.cells = {}

	unit.cells.params = {}

	unit.cells.back = display.newGroup()

	unit.cells.grp = display.newGroup()
	unit.cells.foodGrp = display.newGroup()
	unit.cells.bGrp = display.newGroup()

	unit.cells.mainGrp = display.newGroup()

	unit.cells.WIN = display.newGroup()
	unit.cells.console = display.newGroup()




	function cellsInit( x, y, field )

		unit.cells.food = {}
		unit.cells.bytes = {}

		for i=1, x do

			unit.cells[i] = {}
			unit.cells.food[i] = {}
			unit.cells.bytes[i] = {}

			for j=1, y do
				
				unit.cells[i][j] = display.newRect( 
					unit.cells.grp,
					(-(((x/2)-1)*10) + ((i-1)*10)),
					(-(((y/2)-1)*10) + ((j-1)*10)),
					10,10
				)
				
					if field[i][j].type == "e" then

						unit.cells[i][j]:setFillColor(92/255,(119 + 20/(field[i][j].color))/255,81/255)

					elseif field[i][j].type == "r" then

						unit.cells[i][j]:setFillColor( 1 - ( 1 / (field[i][j].color*10)) )

					elseif field[i][j].type == "g" then

						unit.cells[i][j]:setFillColor(76/255,(99 + 20/(11 - field[i][j].color))/255,67/255)

					end


				unit.cells.food[i][j] = display.newCircle( 
					unit.cells.foodGrp ,
					(-(((x/2)-1)*10) + ((i-1)*10)),
					(-(((y/2)-1)*10) + ((j-1)*10)),
					3
				)
				unit.cells.food[i][j]:setFillColor(((120 + (100/ field[i][j].color)) / 255) , 1 , 0.3)

				unit.cells.bytes[i][j] = display.newCircle( 
					unit.cells.bGrp ,
					(-(((x/2)-1)*10) + ((i-1)*10)),
					(-(((y/2)-1)*10) + ((j-1)*10)),
					4
				)
				unit.cells.bytes[i][j]:setFillColor(1,0.5,0)

					unit.cells.food[i][j].alpha = 0
					unit.cells.bytes[i][j].alpha = 0
			end
		end

		c.out(".. .. .. cell create") -- создание клеток 
	end

	function infoWinInit()

		back = display.newRoundedRect( unit.cells.WIN , 0, 0, 200, 410, 15)
			back:setFillColor( 0.1 )

		unit.label = {}

		unit.label[1] = display.newText( unit.cells.WIN , "___game___", 0, -190, "Anonymous_Pro.ttf")
			unit.label[1]:setFillColor( 0.5, 1, 0	)

		unit.label[2] = display.newText( unit.cells.WIN , "iter -- 0", 0, -170, 180, 20, "Anonymous_Pro.ttf")
		unit.label[3] = display.newText( unit.cells.WIN , "___infield___", 0, -140, "Anonymous_Pro.ttf")
			unit.label[3]:setFillColor( 0.5, 1, 0	)

		unit.label[4] = display.newText( unit.cells.WIN , "food -- 0", 0, -120, 180, 20, "Anonymous_Pro.ttf")
		unit.label[5] = display.newText( unit.cells.WIN , "life -- 0", 0, -100, 180, 20, "Anonymous_Pro.ttf")
		unit.label[6] = display.newText( unit.cells.WIN , "--empty--", 0, -80, 180, 20, "Anonymous_Pro.ttf")


		unit.cells.WIN.x = 120
		unit.cells.WIN.y = 220
		c.out(".. .. .. stat win create") -- создание окна статуса 
	end

	function unit.winUpd(field)
		
		unit.label[4].text = "food -- " .. field.stats.food
		unit.label[2].text = "iter -- " .. game.geti() -- обновление окна статуса
	end

	function unit.upd(field)
		for i=1,  unit.cells.params.X_SIZE do
			for j=1,  unit.cells.params.Y_SIZE do
				
				if field[i][j].item == "e" then
					unit.cells.food[i][j].alpha = 0
					unit.cells.bytes[i][j].alpha = 0

				elseif field[i][j].item == "f" then

					unit.cells.food[i][j].alpha = 1

				elseif field[i][j].item == "b" then
					unit.cells.bytes[i][j].alpha = 1
				end
			end
		end

		unit.winUpd(field)-- обновление интера 
	end

	function unit.start(params)

		fon = display.newRect( unit.cells.back , 700, 350, 2000, 2000 )
			fon:setFillColor( 0.15 )

		unit.cells.params = params

		cellsInit(unit.cells.params.X_SIZE, unit.cells.params.Y_SIZE,game.getf())
		infoWinInit(game.stats())

		unit.upd(game.getf())

		unit.cells.mainGrp:insert( unit.cells.grp )
		unit.cells.mainGrp:insert( unit.cells.foodGrp )
		unit.cells.mainGrp:insert( unit.cells.bGrp )

		ui.cells.mainGrp.x = display.contentCenterX + 200
		ui.cells.mainGrp.y = display.contentCenterY - 45 	

		ui.cells.mainGrp.xScale = 0.8
    	ui.cells.mainGrp.yScale = 0.8 

    	c.out(".. .. OK")
		--unit.cells.mainGrp:scale(1.6, 1.6)старт интерфейса 
	end

return unit