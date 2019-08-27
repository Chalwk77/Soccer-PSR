local playingState = { }

-- Game Variables:
local game_state = "menu"

-- Game Tables:
local player, map
local background, field = { }, { }

local team1, green_slots = { }, { }
local team2, red_slots = { }, { }
local messages = { }

local buttons, button_click = { }, nil
local button_height, button_font = 64, nil

function playingState.start(game)
	-- Setup Soccer field parameters:
    field.img = game.images[1]
    field.opacity = { 255, 255, 255, 1 }
    field.sx, field.sy = getScaling(field.img)

    background.img = game.images[2]
    background.buttonImg = game.images[3]
    background.opacity = { 255, 255, 255, 1 }
    background.sx, background.sy = getScaling(background.img)

    team_title_font = game.fonts[1]
    title_font = game.fonts[2]
    button_font = game.fonts[3]
    aboutMsgFont = game.fonts[4]

    ------------------ CREATE MENU BUTTONS ------------------
    local function newButton(text, fn)
        return {
            text = text,
            fn = fn,
            now = false,
            last = false,
        }
    end

    table.insert(buttons, newButton(
        "Start Game", -- Text
        function()
            game_state = "playing"
        end)
    )
    table.insert(buttons, newButton(
        "Options", -- Text
        function()
            print('OPTIONS BUTTON CLICKED')
        end)
    )
    table.insert(buttons, newButton(
        "Exit Game", -- Text
        function()
            love.event.quit(0)
        end)
    )

    player = {
        grid_x = 640,
		grid_y = 384,
		posX = 200,
		posY = 200,
		speed = 10
	}

    map = { -- 39 x 23
        { 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 5, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 7, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 5, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9},
        { 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9},
	}

    for x = 1,#map do
        for y = 1, #map[x] do
            if (map[x][y] == 2) then
                table.insert(team1, {x,y})
            elseif (map[x][y] == 3) then
                table.insert(team2, {x,y})
            end
        end
    end

    Shuffle(team1, 10)
    Shuffle(team2, 11)
end


function playingState.draw(dt)

    if (game_state == "menu") then
        RenderMenuButtons()

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
    			if (map[y][x] == 1) then -- draw grid
                    love.graphics.setColor(0, 0, 0, 0.2)
                    love.graphics.rectangle("line", x * 32 + gridX, y * 32 + gridY, 32, 32)
                elseif (map[y][x] == 9) then -- Boundary
                    love.graphics.setColor(0, 0, 0, 0.3)
                    love.graphics.rectangle("fill", x * 32 + gridX, y * 32 + gridY, 32, 32)
                elseif (map[y][x] == 5) then -- Goal Keeper
                    love.graphics.setColor(255, 255, 255, 1)
                    love.graphics.rectangle("fill", x * 32 + gridX, y * 32 + gridY, 32, 32)
                elseif (map[y][x] == 7) then -- white square middle-grid
                    love.graphics.setColor(75, 75, 75, 0.5)
                    love.graphics.rectangle("fill", x * 32 + gridX, y * 32 + gridY, 32, 32)
                elseif (map[y][x] == 10) then -- green team squares
                    love.graphics.setColor(0, 255, 0, 1)
                    love.graphics.rectangle("fill", x * 32 + gridX, y * 32 + gridY, 32, 32)
                elseif (map[y][x] == 11) then -- red team squares
                    love.graphics.setColor(255, 0, 0, 1)
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

local picked = { }
local function getTable(exclude, table)
    math.randomseed(os.time())
    local t = table[love.math.random(#table)]
    if (t == exclude) then
        getTable(t, table)
    else
        picked[#picked + 1] = t
        return t
    end
end

function Shuffle(table, color)
    local iterations = 5 -- Determines how many players to draw.
    for _ = 1, iterations do

        local t = table[love.math.random(#table)]

        local function set(type)
            if (type == 1) then
                picked[#picked + 1] = t
                local x,y = t[1], t[2]
                map[x][y] = color
            elseif (type == 2) then
                local nt = getTable(t, table)
                local x,y = nt[1], nt[2]
                map[x][y] = color
            end
        end

        if (#picked <= 0) then
            set(1)
        else
            for i = 1,#picked do
                if (picked[i] == t) then
                    set(2)
                else
                    set(1)
                end
            end
        end

        if (#picked >= iterations) then
            picked = { }
        end
    end
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

local function centerText(str, strW, font)
    local ww, wh = love.graphics.getDimensions()
    return {
        w = math.floor(ww/2),
        h = math.floor(wh/2),
        strW = math.floor(strW/2),
        fontH = math.floor(font:getHeight()/2),
    }
end

function RenderMenuButtons()

    love.graphics.setColor(unpack(background.opacity))
    love.graphics.draw(background.img, 0, 0, 0, background.sx, background.sy)

    love.graphics.setColor(70/255, 130/255, 180/255, 1)
    local title = "Soccer RPS 2019"
    local strwidth = title_font:getWidth(title)
    local t = centerText(title, strwidth, title_font)
    love.graphics.setFont(title_font)
    love.graphics.print(title, t.w, t.h - 300, 0, 1, 1, t.strW, t.fontH)

    local aboutMsg = {
        {"Soccer RPS 2019, Windows PC | Android, iOS", 330},
        {"Copyright (c) 2019, Jericho Crosby <jericho.crosby227@gmail.com>", 345},
        {"Credits to Hussain Alfakhar (and family) for original concept.", 360}
    }

    -- About Message:
    love.graphics.setFont(aboutMsgFont)
    love.graphics.setColor(0/255, 0/255, 0/255, 1)

    for i = 1,#aboutMsg do
        local strwidth = aboutMsgFont:getWidth(aboutMsg[i][1])
        local t = centerText(aboutMsg[i][1], strwidth, aboutMsgFont)
        love.graphics.print(aboutMsg[i][1], t.w, t.h + aboutMsg[i][2], 0, 1, 1, t.strW, t.fontH)
    end

    local ww, wh = love.graphics.getDimensions()
    local button_width = ww * (1 / 3)

    local margin = 16
    local cursor_y = 0

    for _, button in ipairs(buttons) do
        local total_height = (button_height + margin) * #buttons
        button.last = button.now

        local bx = (ww * 0.5) - (button_width * 0.5)
        local by = (wh * 0.5) - (total_height * 0.5) + cursor_y - 90

        -----------------------------------------------------------------------
        local button_alpha = 0.5
        local color = { 0.4, 0.4, 0.5, button_alpha }
        local mx, my = love.mouse.getPosition()

        local hovering = mx > bx and mx < bx + button_width and
                my > by and my < by + button_height

        if (hovering) then
            if (button.text == "Start Game") then
                color = { 0 / 255, 255 / 255, 0 / 255, button_alpha }
            elseif (button.text == "Options") then
                color = { 180 / 255, 255 / 255, 0 / 255, button_alpha }
            elseif (button.text == "Exit Game") then
                color = { 255, 0 / 255, 0 / 255, button_alpha }
            end
        end

        button.now = love.mouse.isDown(1)
        if (button.now and not button.last and hovering) then
            button.fn()
        end

        love.graphics.setColor(unpack(color))
        love.graphics.rectangle(
            "fill",
            bx,
            by,
            button_width,
            button_height
        )

        local textW = button_font:getWidth(button.text)
        local textH = button_font:getHeight(button.text)

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print(
                button.text,
                button_font,
                (ww * 0.5) - textW * 0.5,
                by + textH * 0.5 + 5
        )
        cursor_y = cursor_y + (button_height + margin)
    end
end

return playingState
