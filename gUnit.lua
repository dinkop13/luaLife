-- TO DO :
-- 1 : сделать что нибудь с этой таблицей {{1}}
-- : Сделать функции отбора и мутации 

local unit = {}


	unit.gensArray = {}  ----------------------------------основной массив генов

		unit.genN = 32

		unit.iterCount = 1 --------------------------------количество генираций
	
	array = unit.gensArray --------------------------сокращенная форма записи
--===============================================================================================================
-- Саб функции

function chrFind(str, pos) -- Нахождение чара по позиции 
	rez = str:sub(pos,pos)
	return rez
end

function chrRep( str, pos, chr )
	newStr = str:sub(1,pos-1) .. chr .. str:sub(pos+1)
	return newStr
end

--===============================================================================================================
-- Функции работы с датой

function unit.genInit( params ) -- Создание генов
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

function unit.gensDataInit(params) -- Создание наборов генов 
	local data = ""

		if params.genN == "" then 
			params.genN = 32
		end

		unit.genN = params.genN

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

function unit.gensDataWrite() -- Запись данных в файл
	local data = ""

		for i=1, array.counter do
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

function unit.gensDataRead() -- Чтение данных с файла 
	local path = system.pathForFile( "gens.txt", system.DocumentsDirectory )

	local file, errorString = io.open( path, "r" )

	if not file then
	    print( "File error: " .. errorString )
	else
		counter = 0

	    for line in file:lines() do
	        counter = counter + 1
			unit.gensArray[counter] = {}

				array[counter].HEXname		= string.sub(line, 1, 10)
				array[counter].gen 			= string.sub(line, 12, 75)
				array[counter].lifeCircyle	= tonumber(string.sub(line, 77, string.find(line, "/")-1))

				print("gen #"..counter .. "--")
				print("HEXname 		: " .. array[counter].HEXname)
				print("gen 		: " .. array[counter].gen)
				print("lifeCircyle 	: " .. array[counter].lifeCircyle .. "\n")
	    end

	    unit.gensArray.counter = counter
	    print(counter)
	    
	    io.close( file )
	end
end

function unit.dataSave() -- Создание лога
	local data = ""
	local date = os.date("_%H_%M_%S")
	local dateU = os.date("-- %c")
	local array = unit.gensArray

		data = "--" .. dateU .. "\n\n"

		for i=1, unit.gensArray.counter do
			data = data .. string.format("%s>%s:%s/", array[i].HEXname, array[i].gen, array[i].lifeCircyle) .."\n"
		end 

	local path = system.pathForFile("logs/log".. date .. ".txt", system.DocumentsDirectory )

	local file, errorString = io.open( path, "w" )

	if not file then
	    print( "File error: " .. errorString )
	else
	    file:write( data )
	    io.close( file )
	end
end

function unit.bigDATA()
	local path = system.pathForFile( "big_data.txt", system.DocumentsDirectory )

	local file, errorString = io.open( path, "r" )

	local bData = {} 

	local nBData = ""

	if not file then
	    print( "File error: " .. errorString )
	else
		counter = 0

	    for line in file:lines() do
	        counter = counter + 1

	        bData[counter] = line
	    end
    
	    io.close( file )
	end

	local file, errorString = io.open( path, "w" )

	for i=1, counter do
		file:write ( bData[i] .."\n" )
	end	

	for i=1, array.counter do
		file:write ( string.format("%s>%s:", array[i].HEXname, array[i].gen) .. os.date("Msk+3.0(%c)//") .. array[i].lifeCircyle .. "\n")
	end	

    io.close( file )
end

function unit.HEXfind( HEX )
	error_msg = "can't find array"
	
	for i=1, array.counter do
		
		if array[i].HEXname == HEX then
			return array[i]
		else
			return error_msg
		end
	end
end
--===============================================================================================================
-- Функции преобразования 

return unit