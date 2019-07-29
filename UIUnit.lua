game = require("gameUnit")

local unit = {}

	unit.cells = {}

	unit.cells.params = {}

	unit.cells.grp = display.newGroup()
	unit.cells.foodGrp = display.newGroup()

	unit.cells.mainGrp = display.newGroup()

	function cellsInit( x, y )

		unit.cells.food = {}

		for i=1, x do

			unit.cells[i] = {}
			unit.cells.food[i] = {}

			for j=1, y do
				
				unit.cells[i][j] = display.newRect( 
					unit.cells.grp,
					(-(((x/2)-1)*6) + ((i-1)*6)),
					(-(((y/2)-1)*6) + ((j-1)*6)),
					6,6
				)

				unit.cells.food[i][j] = display.newCircle( 
					unit.cells.foodGrp ,
					(-(((x/2)-1)*6) + ((i-1)*6)),
					(-(((y/2)-1)*6) + ((j-1)*6)),
					2
				)

					unit.cells.food[i][j].alpha = 0
			end
		end
	end

	function unit.upd(field)
		for i=1,  unit.cells.params.X_SIZE do
			for j=1,  unit.cells.params.Y_SIZE do
				if field[i][j].type == "e" then

					unit.cells[i][j]:setFillColor( 0.23)
					unit.cells.food[i][j].alpha = 0

				elseif field[i][j].type == "r" then

					unit.cells[i][j]:setFillColor( 0.65)
					unit.cells.food[i][j].alpha = 0

				elseif field[i][j].type == "f" then

					unit.cells[i][j]:setFillColor(0.23 )
					unit.cells.food[i][j]:setFillColor( math.random( 120, 200 ) / 255 , 1 , 0.3)
					unit.cells.food[i][j].alpha = 1

				end
			end
		end
	end

	function unit.start(params)
		print( os.date( "__ log %c" ) 	)
		print( "!! UI INIT" )

		unit.cells.params = params

		cellsInit(unit.cells.params.X_SIZE, unit.cells.params.Y_SIZE)

		unit.upd(game.getf())

		unit.cells.mainGrp:insert( unit.cells.grp )
		unit.cells.mainGrp:insert( unit.cells.foodGrp )

		unit.cells.mainGrp.x = display.contentCenterX
		unit.cells.mainGrp.y = display.contentCenterY

		unit.cells.mainGrp:scale(1.6, 1.6)
	end

return unit