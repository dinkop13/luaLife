game = require("gameUnit")

local unit = {}

	unit.cells = {}

	unit.cells.params = {}
	unit.cells.grp = display.newGroup()

	function cellsInit( xP, yP, x, y )

		for i=1, x do

			unit.cells[i] = {}

			for j=1, y do
				
				unit.cells[i][j] = display.newRect( unit.cells.grp, (xP + ((i-1)*6)) , (yP + ((j-1)*6)) , 5, 5 )

			end
		end
	end

	function unit.upd(field)
		for i=1,  unit.cells.params.X_SIZE do
			for j=1,  unit.cells.params.Y_SIZE do
				if field[i][j].type == "e" then

					unit.cells[i][j]:setFillColor( math.random(20,25) / 100 )

				elseif field[i][j].type == "r" then

					unit.cells[i][j]:setFillColor( math.random(60,70) / 100 )

				end
			end
		end
	end

	function unit.start(params)
		print( os.date( "__ log %c" ) 	)
		print( "!! UI INIT" )

		unit.cells.params = params

		cellsInit(20, 20, unit.cells.params.X_SIZE, unit.cells.params.Y_SIZE)

		unit.upd(game.getf())
	end

return unit