local unit = {}

	unit.array = {} -- основной массив

	unit.array.params = {} -- массив переданных параметров
	
	function unit.getf()

		return unit.array
	end

	local function rockGenerate(params)
		
		seedCount = 14
		seedAdd = 0
		erosiaTier = 20

		local function seedSpawn( c )
			for i=1, c do
				
				unit.array[math.random(2, unit.array.params.X_SIZE - 1)][math.random(2, unit.array.params.Y_SIZE - 1)].type = "r"

			end
		end

		local function erosia()
			for i=1,unit.array.params.X_SIZE do
				for j=1,unit.array.params.Y_SIZE do

					if unit.array[i][j].type == "r" then

						way = math.random( 1, 4 )

						if way == 1 then
							if j ~= 1 then
								unit.array[i][j-1].type = "nr"
							end

						elseif way == 2 then
							if i ~= unit.array.params.X_SIZE then
								unit.array[i+1][j].type = "nr"
							end
						elseif way == 3 then
							if j ~= unit.array.params.Y_SIZE then
								unit.array[i][j+1].type = "nr"
							end
						elseif way == 4 then
							if i ~= 1 then
								unit.array[i-1][j].type = "nr"
							end
						end

					end
				end
			end

			for i=1,unit.array.params.X_SIZE do
				for j=1,unit.array.params.Y_SIZE do

					if unit.array[i][j].type == "nr" then
						unit.array[i][j].type = "r"
					end
				end
			end
		end

		seedSpawn(seedCount)

			erosia()

			erosia()

			erosia()

		for i=1,erosiaTier do
			
			erosia()

			seedSpawn( seedAdd )

			if (i % 4) == 0 then
				seedAdd = seedAdd + 1
			end
		end
	end

	local function foodGenerate(params)

		foodCount = 17
		foodPlace = 0

		repeat

			coordRNDX = math.random(2, unit.array.params.X_SIZE - 1)
			coordRNDY = math.random(2, (unit.array.params.Y_SIZE - 1) - math.random (2, (unit.array.params.Y_SIZE - 20)))
   			
			if unit.array[coordRNDX][coordRNDY].type == "e" then
				unit.array[coordRNDX][coordRNDY].type = "f" 
				foodPlace = foodPlace + 1 
			end

		until( foodPlace == foodCount )

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

	function unit.step( ... )
		foodGenerate()
	end

	function unit.start(params) -- запуск игры
		print( os.date( "__ log %c" ) 	)
		print( "!! GAME INIT" )

		unit.array.params = params

		gameInit(unit.array.params.X_SIZE,unit.array.params.Y_SIZE)
		rockGenerate(unit.array.params)
		foodGenerate(unit.array.params)
	end

return unit