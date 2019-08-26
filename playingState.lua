local playingState = { }

-- Game Variables:
local game_state = "playing"

-- Game Tables:
local player, map
local field = { }

local players = { }

function playingState.start(game)
	-- Setup football field parameters:
    field.img = game.images[1]
    field.opacity = { 255, 255, 255, 1 }
    field.sx, field.sy = getScaling(field.img)

    red_player = game.images[2]
    green_player = game.images[3]

    title_font = game.fonts[1]

    player = {
        grid_x = 640,
		grid_y = 384,
		posX = 200,
		posY = 200,
		speed = 10
	}

	map = {
        { 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 0, 0, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 0, 0, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 7, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9},
	}
end

function playingState.draw(dt)

    if (game_state == "menu") then

        love.graphics.setColor(32,32,32,1)
        love.graphics.setFont(title_font)
        love.graphics.printf("Football | PSR",0,100,1000,"center")

    elseif (game_state == "playing") then
    	love.graphics.setColor(unpack(field.opacity))
        love.graphics.draw(field.img, 0, 0, 0, field.sx, field.sy)

    	local gridW, gridH = 32, 32
        local gridX, gridY = 27,-16

        -- Draw Player:
        love.graphics.setColor(120, 120, 0, 1)
        love.graphics.rectangle("fill", player.posX + gridX, player.posY + gridY, 32, 32)

        for y=1, #map do
    		for x=1, #map[y] do
    			if (map[y][x] == 1) then
                    love.graphics.setColor(0, 0, 0, 0.2)
                    love.graphics.rectangle("line", x * 32 + gridX, y * 32 + gridY, 32, 32)
                elseif (map[y][x] == 7) then
                    love.graphics.setColor(75, 75, 75, 0.5)
                    love.graphics.rectangle("fill", x * 32 + gridX, y * 32 + gridY, 32, 32)
                elseif (map[y][x] == 5) then
                    love.graphics.setColor(0, 255, 0, 1)
                    love.graphics.rectangle("fill", x * 32 + gridX, y * 32 + gridY, 32, 32)
                elseif (map[y][x] == 9) then
                    love.graphics.setColor(0, 0, 0, 0.3)
                    love.graphics.rectangle("fill", x * 32 + gridX, y * 32 + gridY, 32, 32)
    			end
    		end
    	end

        love.graphics.setColor(24, 0, 24, 1)
    	love.graphics.print(("DEBUG: (Column: %d: Row: %d)"):format(player.grid_x / 32, player.grid_y / 32), 100, 24)
    end
end

function playingState.update(dt)
    if (game_state == "menu") then

    elseif (game_state == "playing") then
        field.opacity = { 255, 255, 255, 1 }
        player.posY = player.posY - ((player.posY - player.grid_y) * player.speed * dt)
    	player.posX = player.posX - ((player.posX - player.grid_x) * player.speed * dt)
    elseif (game_state == "paused") then
        field.opacity = { 255, 255, 255, 0.5 }
    end
end

function playingState.keypressed(key)
	if (key == "up") then
		if testMap(0, -1) then
			player.grid_y = player.grid_y - 32
		end
	elseif (key == "down") then
		if testMap(0, 1) then
			player.grid_y = player.grid_y + 32
		end
	elseif (key == "left") then
		if testMap(-1, 0) then
			player.grid_x = player.grid_x - 32
		end
	elseif (key == "right") then
		if testMap(1, 0) then
			player.grid_x = player.grid_x + 32
		end
	elseif (key == "escape") then
		love.event.quit(0)
	end
end

function testMap(x, y)
	if (map[(player.grid_y / 32) + y][(player.grid_x / 32) + x] == 1) then
		return false
	end
	return true
end

-- This function will shuffle players at the beginning of the game.
-- Returns: x,y, table
function Shuffle()

end

function getScaling(drawable, canvas)
	local canvas = canvas or nil

	local drawW = drawable:getWidth()
	local drawH = drawable:getHeight()

	local canvasW = 0
	local canvasH = 0

	if (canvas) then
		canvasW = canvas:getWidth()
		canvasH = canvas:getHeight()
	else
		canvasW = love.graphics.getWidth()
		canvasH = love.graphics.getHeight()
	end

	local scaleX = canvasW / drawW
	local scaleY = canvasH / drawH

	return scaleX, scaleY
end

return playingState
