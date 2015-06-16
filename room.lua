local args = {...}
local direction = 0
local minedblocks = 0

local x, y, z = 0, 0, 0

local function printstats()
	term.clear()
	term.setCursorPos(1, 1)
	print("Room Digger - by martin2250")
	print("")
	print("Mining out a "..args[1].."x"..args[2].."x"..args[3].." area")
	print("")
	print("My position is "..x.." "..y.." "..z)
	print("       (relative to my starting point)")
	print("I mined "..minedblocks.. " blocks")
	print("My fuel level is "..turtle.getFuelLevel())


end

local function left()
	turtle.turnLeft()                         --    0        +x
	direction = direction - 1                 --  3   1   -z    +z
	if direction == -1 then direction = 3 end --    2        -x
end

local function right()
	turtle.turnRight()
	direction = direction + 1
	if direction == 4 then direction = 0 end
end

local function forward()
	local sucess = turtle.forward()
	if sucess then
		if direction == 0 then x = x + 1 end
		if direction == 1 then z = z + 1 end
		if direction == 2 then x = x - 1 end
		if direction == 3 then z = z - 1 end
	end
	return sucess
end

local function up()
	if turtle.up() then y = y + 1 return true end return false
end

local function down()
	if turtle.down() then y = y - 1 return true end return false
end

local function goforward(laenge, digup)
	local pos = 0
	while pos < laenge do
		printstats()
		if turtle.dig() then minedblocks = minedblocks + 1 end
		if digup then while turtle.detectUp() do if turtle.digUp() then minedblocks = minedblocks + 1 end  end end
		if forward() then pos = pos + 1 end
		if digup then while turtle.detectUp() do if turtle.digUp() then minedblocks = minedblocks + 1 end  end end
	end
end

local function forcefwd()
	repeat if turtle.dig() then minedblocks = minedblocks + 1 end
	until forward()
end

local function forceup()
	repeat if turtle.digUp() then minedblocks = minedblocks + 1 end
	until up()
end
----------------------------------------------------------------------------
if not turtle then
	print("this program can only be used on turtles")
end

if #args ~= 3 then
	print("Usage: ")
	print("room <length> <width> <height>")
	return
end


local maxx = tonumber(args[1]) - 1
local maxz = tonumber(args[2])
local maxy = tonumber(args[3])

term.clear()
term.setCursorPos(1, 1)

local zdir = true
zdir = true

local candigup = false

while y < maxy do

	if maxy - y > 1 then candigup = true else candigup = false end	
	
	while true do
		goforward(maxx, candigup)
		
		if zdir then
		
			if (z + 1) < maxz then	
			if direction == 0 then right() forcefwd()  right() 
			else left() forcefwd() left() end
			else
				break
			end
			
		else
		
			if z > 0 then
			if direction == 0 then left() forcefwd() left()
			else right() forcefwd() right()  end
			else
				break
			end
			
		end
	end
	zdir = not zdir
	
	if y ~= maxy - 1 then
	forceup() if candigup then forceup() end right() right() else y = y + 1 end
	
end
y = y - 1
printstats()
print("finished!")