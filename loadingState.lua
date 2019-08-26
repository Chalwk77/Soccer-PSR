local loader = require 'love-loader'
local loadingState = {}

local function drawLoadingBar()
    local ww, wh = love.graphics.getDimensions()
    local separation = 30
    local w = ww - 2*separation
    local h = 20
    local x,y = separation, wh - separation - h

    local posX, posY = 250, 180
    love.graphics.setColor(105,105,105, 1)
    love.graphics.rectangle("line", x + posX, y + posY, w, h)

    x, y = x + 3, y + 3
    w, h = w - 6, h - 7

    if (loader.loadedCount > 0) then
        w = w * (loader.loadedCount / loader.resourceCount)

        local font = love.graphics.newFont("fonts/arial.ttf", 20)
        love.graphics.setFont(font)

        local percent_complete = math.floor(100 * loader.loadedCount / loader.resourceCount)
        local width = love.graphics.getWidth()

        local percent = 0
        if (loader.resourceCount ~= 0) then
            percent = loader.loadedCount / loader.resourceCount
        end
        love.graphics.printf(("Loading .. %d%%"):format(percent * 100), 0, y + 150, width, "center")
    end

    love.graphics.setColor(47,79,79, 1)
    love.graphics.rectangle("fill", x + posX, y + posY, w, h)
end

function loadingState.start(game, finishCallback)
    math.randomseed(os.time())
    loader.newImage(game.images, 1, 'media/images/field.png')
    loader.newImage(game.images, 2, 'media/images/red_player.png')
    loader.newImage(game.images, 3, 'media/images/green_player.png')

    loader.newFont(game.fonts, 1, 'fonts/confcrg.ttf', 120)

    loader.start(finishCallback, print)
end

function loadingState.draw()
    drawLoadingBar()
end

function loadingState.update(dt)
    loader.update()
end

return loadingState
