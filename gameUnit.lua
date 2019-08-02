c 	= require("consolUnit")

local unit = {}

	unit.ITER = 0

	unit.array = {} -- основной массив

	unit.array.params = {} -- массив переданных параметров

	unit.array.stats = {}
	
	function unit.getf()

		return unit.array
	end

	function unit.geti()

		return unit.ITER
	end

	local function rockGenerate(params)
		
		seedCount = 9
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

	local function grassGenerate(params)
		seedCount = 6
		erosiaTier = 20

		local function seedSpawn( c )
			seed = c
			newSeed = 0

			repeat
				
				coordRNDX = math.random( 2, unit.array.params.X_SIZE )
				coordRNDY = math.random( 2, unit.array.params.Y_SIZE )

				if  unit.array[coordRNDX][coordRNDY].type == "e" then
						unit.array[coordRNDX][coordRNDY].type = "g"
						newSeed = newSeed + 1
				end

			until newSeed == seed
		end

		local function erosia()
			for i=1,unit.array.params.X_SIZE do
				for j=1,unit.array.params.Y_SIZE do

					if unit.array[i][j].type == "g" then

						way = math.random( 1, 4 )

						if way == 1 then
							if j ~= 1 then
								unit.array[i][j-1].type = "ng"
							end

						elseif way == 2 then
							if i ~= unit.array.params.X_SIZE then
								unit.array[i+1][j].type = "ng"
							end
						elseif way == 3 then
							if j ~= unit.array.params.Y_SIZE then
								unit.array[i][j+1].type = "ng"
							end
						elseif way == 4 then
							if i ~= 1 then
								unit.array[i-1][j].type = "ng"
							end
						end

					end
				end
			end

			for i=1,unit.array.params.X_SIZE do
				for j=1,unit.array.params.Y_SIZE do

					if unit.array[i][j].type == "ng" then
						unit.array[i][j].type = "g"
					end
				end
			end
		end

		seedSpawn(seedCount)

			erosia()

			erosia()

			erosia()

		for i=1, erosiaTier do
			erosia()
		end
	end

	local function foodInit(params)

		foodCount = 50
		foodPlace = 0

		repeat

			coordRNDX = math.random(2, unit.array.params.X_SIZE - 1)
			coordRNDY = math.random(2, (unit.array.params.Y_SIZE - 1) - math.random (2, (unit.array.params.Y_SIZE - 20)))
   			
			if (unit.array[coordRNDX][coordRNDY].type == "e" or unit.array[coordRNDX][coordRNDY].type == "g") and unit.array[coordRNDX][coordRNDY].item == "e"  then
				unit.array[coordRNDX][coordRNDY].item = "f" 
				foodPlace = foodPlace + 1 
			end

		until( foodPlace == foodCount )

	end

	local function foodGenerate()
		--if unit.array.stats.food < 170 then
			for i=1,2 do
				coordRNDX = math.random(2, unit.array.params.X_SIZE - 1)
				coordRNDY = math.random(2, (unit.array.params.Y_SIZE - 1) - math.random (2, (unit.array.params.Y_SIZE - 20)))
	   			
				if unit.array[coordRNDX][coordRNDY].type == "e" or unit.array[coordRNDX][coordRNDY].type == "g" then
					unit.array[coordRNDX][coordRNDY].item = "f" 
				end
			end
		--end
	end

	local function foodGrassGenerate()
			for i=1,5 do
				coordRNDX = math.random(2, unit.array.params.X_SIZE - 1)
				coordRNDY = math.random(2, (unit.array.params.Y_SIZE - 1))
	   			
				if unit.array[coordRNDX][coordRNDY].type == "g"--[[{}]] then
					unit.array[coordRNDX][coordRNDY].item = "f" 
				end
			end
	end

	local function gameInit(x,y) -- Функция создания массива поля

		for i=1, x do

			unit.array[i] = {}

			for j=1, y do
				
				unit.array[i][j] = {}
				unit.array[i][j].type = "e"
				unit.array[i][j].item = "e"
				unit.array[i][j].color = math.random( 1, 10 )
			end
		end

		print( os.date( "__ log %c" ) 	)
		print( "Create empty gameField " .. x .. "X" .. y .. "cell" 		)
	end

	function unit.stats()
		unit.array.stats.food = 0

		for i=1, unit.array.params.X_SIZE do
			for j=1, unit.array.params.Y_SIZE do
				
				if unit.array[i][j].item == "f" then
					unit.array.stats.food = unit.array.stats.food + 1
				end

			end
		end

		return unit.array.stats
	end

	function unit.step( ... )
		foodGenerate()
		foodGrassGenerate()
		unit.stats()

		unit.ITER = unit.ITER + 1
	end

	function unit.start(params) -- запуск игры
		print( os.date( "__ log %c" ) 	)
		print( "!! GAME INIT" )

		unit.array.params = params

		gameInit(unit.array.params.X_SIZE,unit.array.params.Y_SIZE)
		rockGenerate(unit.array.params)
		grassGenerate(unit.array.params)
		foodInit(unit.array.params)

		unit.stats()

		c.out(".. .. OK")
	end

return unit