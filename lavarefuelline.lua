local x, y, direction = 0, 0, 1

local length, maxdepth = ...
length, maxdepth = tonumber(length), tonumber(maxdepth)

if not length then
	print("usage: lavarefuelline <length> [maxdepth = -10]")
	return
end

if not maxdepth then
	maxdepth = -10
end

if maxdepth >= 0 then
	print("maxdepth must be negative")
	return
end

local function up()
	while not turtle.up() do turtle.digUp() end
	y = y + 1
end

local function down()
	while not turtle.down() do turtle.digDown() end
	y = y - 1
end

local function fwd()
	while not turtle.forward() do turtle.dig() end
	x = x + direction
end

local function turnAround()
	turtle.turnRight()
	turtle.turnRight()
	direction = - direction
end

turtle.select(1)
if turtle.getItemCount(1) == 0 or turtle.getItemDetail(1).name ~= "minecraft:bucket" then
	print("please place an empty bucket in slot #1")
	return
end




while x < length do
	fwd()
	
	while not turtle.detectDown() and y > maxdepth do
		if turtle.placeDown() then turtle.refuel() end
		down()
	end
	
	while y < 0 do
		up()
	end
end

turnAround()

while x > 0 do
	fwd()
end

print("New fuel level is " .. turtle.getFuelLevel())