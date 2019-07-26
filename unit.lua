local unit = {}

	unit.gensMass = {}

function unit.genInit( params )
	local gen = {}
	local genStr = ""
	local HEX = ""

	if params.initType	== "default" then
		local gen = {}

		for i=1, 64 do
			gen[i] = string.char(math.random(97, 122))
			genStr = genStr	.. gen[i]
		end
	end

	for i=1, 4 do
		HEX = HEX .. string.char(math.random(97, 122))
	end

	for i=1, 6 do
		HEX = HEX .. string.char(math.random(48, 57))
	end

	if params.flag == "-s" then
		returnStr = HEX .. ">" .. genStr .. ":"

		return returnStr

	elseif params.flag == "-sh" then
		returnStr = HEX .. ">" .. string.sub(genStr, 1, 5) .. "... :"

		return returnStr

	elseif params.flag == "" then
		returnStr = genStr

		return returnStr
	end
end

function unit.gensDataInit(params)
	local data = ""

		for i=1, params.genN do
			data = data ..unit.genInit({initType = "default", flag = "-s"}) .. "0/" .."\n"
		end 

	local path = system.pathForFile( "gens.txt", system.DocumentsDirectory )

	local file, errorString = io.open( path, "w" )

	if not file then
	    print( "File error: " .. errorString )
	else
	    file:write( data )
	    io.close( file )
	end
end

function unit.gensDataWrite()
	local path = system.pathForFile( "gens.txt", system.DocumentsDirectory )

	local file = io.open( path )

	if not file then
	    print( "File error: " .. errorString )
	else
	    file:write( "Test" )
	    io.close( file )
	end
end

function unit.gensDataRead()
	local path = system.pathForFile( "gens.txt", system.DocumentsDirectory )

	local file, errorString = io.open( path, "r" )

	if not file then
	    print( "File error: " .. errorString )
	else
		counter = 0

	    for line in file:lines() do
	        counter = counter + 1
			unit.gensMass[counter] = {}

				unit.gensMass[counter].HEXname		= string.sub(line, 1, 10)
				unit.gensMass[counter].gen 			= string.sub(line, 12, 75)
				unit.gensMass[counter].lifeCircyle	= string.sub(line, 77, string.find(line, "/")-1)

				print("gen #"..counter .. "--")
				print("HEXname 		: " .. unit.gensMass[counter].HEXname)
				print("gen 		: " .. unit.gensMass[counter].gen)
				print("lifeCircyle 	: " ..unit.gensMass[counter].lifeCircyle .. "\n")
	    end

	    print(counter)
	    
	    io.close( file )
	end
end

return unit