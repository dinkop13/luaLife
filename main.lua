run = require("runUnit") -- модуль сборки модулей интерфейса и цикла
c 	= require("consolUnit")

c.start() -- старт консоли 

c.out("")
c.out("Press button to select run mode :")
c.out("    > t - run test mode")

		local function onKeyEvent( event ) -- отрабочик нажатий в  менюшки 
		 
		    if ( event.keyName == "t" ) then --тестовый режим запуска 
		    																							--TODO начать пилить запуск с файла 

		    	if event.phase == "down"  then
		    		c.out("")
		    		c.out(".. START .test()") -- log

		    	elseif event.phase == "up" then 
			    	run.test() --Старт сборки теста 
			    	c.out(".. OK") -- log
			    	c.out("___________________________________________________________________________")
			    	c.out(" Use arrows to scroll map and +/- to zoom")

			    	Runtime:removeEventListener( "key", onKeyEvent )

			    end

		    elseif ( event.keyName == "w" ) and ( event.phase == "down") then

		    elseif ( event.keyName == "n" ) and ( event.phase == "down") then

		    elseif ( event.keyName == "x" ) and ( event.phase == "down") then

		    end
		 
		    return false
		end

		Runtime:addEventListener( "key", onKeyEvent )