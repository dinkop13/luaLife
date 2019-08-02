local unit = {}
		
		grp = display.newGroup( )

		rows = {} -- строки на экране 

		memori = {} -- строки в памяти 
			memori.pointer = 0 -- указатель записи 

	function unit.out(OUTtext)
		memori.pointer = memori.pointer + 1 -- сдвиг указателя 
		memori[memori.pointer] = OUTtext -- запись 

		for i=1,9 do
			rows[11-i].text = rows[10-i].text
		end

		rows[1].text = OUTtext

		grp:toFront( )
	end

	function unit.cls() -- очистка ХУЕВО РАБОТАЕТ 
		for i=1,10 do
			rows[i].text = ""
		end
	end

	function unit.stop() -- функциия скрытия консоли 
		unit.cls()
		grp:removeSelf()
	end

	function unit.start() -- старт консоли 
		backRect = display.newRoundedRect( grp, 0, 0, 560, 210, 15)
			backRect:setFillColor( 0,0,0,0.7 )

		for i=1,10 do
			rows[i] = display.newText( grp, "" , 0, 90 - (i-1)*20 , 500, 20, "Anonymous_Pro.ttf" ) 
		end

		unit.out(os.date("%c"))
		unit.out("Console start")

		grp.x = 290
		grp.y = 540

		return grp
	end

return unit