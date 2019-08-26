-- Game Title: Football (Rock, Paper, Scissors)
-- A 2D video game written in the Lua Programming Language with Love2D Framework.
-- Copyright (c) 2019, Jericho Crosby <jericho.crosby227@gmail.com>
-- Special credits to Enrique García Cota for love-loader v2.0.3 (utility library).

local loadingState = require 'loadingState'
local playingState = require 'playingState'
local currentState = nil

local game = { images = {}, sounds = {}, fonts = {} }

local function loadingFinished()
    currentState = playingState
    currentState.start(game)
end

function love.load()

    -- Detect native desktop resolution and set window mode to fullscreen:
    local w, h = love.window.getDesktopDimensions()
    love.window.setMode(w, h, {
        fullscreen = true,
        vsync = true,
        centered = false
    })

    -- Set window caption:
    love.graphics.printf("Football - PSR", 0, 48, 800, "center")

    currentState = loadingState
    currentState.start(game, loadingFinished)
end

function love.draw()
    currentState.draw(game)
end

function love.update(dt)
    currentState.update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        local f = love.event.quit or love.event.push
        f('q')
    end
    if currentState.keypressed then
        currentState.keypressed(key)
    end
end
