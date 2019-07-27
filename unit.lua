-- TO DO :
-- 1 : сделать что нибудь с этой таблицей {{1}}
-- : Сделать функции отбора и мутации 

local unit = {}

	unit.gensArray = {}  ----------------------------------основной массив генов

		unit.iterCount = 1 --------------------------------количество генираций
--===============================================================================================================
-- Саб функции

function chFind(str, pos) -- Нахождение чара по позиции 
	rez = str:sub(pos,pos)
	return rez
end

--===============================================================================================================
-- Функции работы с датой

function unit.genInit( params ) -- Создание набора генов
	local gen = {} --{{1}}

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
	local data = ""
	local array = unit.gensArray

		for i=1, unit.gensArray.counter do
			data = data .. string.format("%s>%s:%s/", array[i].HEXname, array[i].gen, array[i].lifeCircyle) .."\n"
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

function unit.gensDataRead()
	local path = system.pathForFile( "gens.txt", system.DocumentsDirectory )

	local file, errorString = io.open( path, "r" )

	if not file then
	    print( "File error: " .. errorString )
	else
		counter = 0

	    for line in file:lines() do
	        counter = counter + 1
			unit.gensArray[counter] = {}

				unit.gensArray[counter].HEXname		= string.sub(line, 1, 10)
				unit.gensArray[counter].gen 			= string.sub(line, 12, 75)
				unit.gensArray[counter].lifeCircyle	= tonumber(string.sub(line, 77, string.find(line, "/")-1))

				print("gen #"..counter .. "--")
				print("HEXname 		: " .. unit.gensArray[counter].HEXname)
				print("gen 		: " .. unit.gensArray[counter].gen)
				print("lifeCircyle 	: " ..unit.gensArray[counter].lifeCircyle .. "\n")
	    end

	    unit.gensArray.counter = counter
	    print(counter)
	    
	    io.close( file )
	end
end

function unit.dataSave()
	local data = ""
	local date = os.date("%c")
	local array = unit.gensArray

		data = "--" .. date .. "\n\n"

		for i=1, unit.gensArray.counter do
			data = data .. string.format("%s>%s:%s/", array[i].HEXname, array[i].gen, array[i].lifeCircyle) .."\n"
		end 

	local path = system.pathForFile("gen-" .. unit.iterCount .. ".txt", system.DocumentsDirectory )

	local file, errorString = io.open( path, "w" )

	if not file then
	    print( "File error: " .. errorString )
	else
	    file:write( data )
	    io.close( file )
	end
end

return unit