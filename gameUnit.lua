local unit = {}

	unit.array = {} -- основной массив

	local params = {} -- массив переданных параметров

	local function rockGenerate()
		-- body
	end

	local function gameInit(x,y) -- Функция создания массива поля

		for i=1, x do

			unit.array[i] = {}

			for j=1, y do
				
				unit.array[i][j] = {}
				unit.array[i][j].type = "e"
			end
		end

		print( os.date( "__ log %c" ) 	)
		print( "Create empty gameField " .. x .. "X" .. y .. "cell" 		)
	end

	function unit.start(params) -- запуск игры
		print( os.date( "__ log %c" ) 	)
		print( "!! GAME INIT" )

		unit.array.params = params

		gameInit(params.X_SIZE,params.Y_SIZE)
	end

	function unit.getf()
		return unit.array
	end

return unit