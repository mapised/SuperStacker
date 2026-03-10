local g3d = require("g3d")
local world = require("src.game.world")

local game = {
    canvases = {};
    worlds = {};
}

local function getdimensions(i, players, sw, sh)
    if players <= 3 then
        return (i - 1) * (sw / players), 0, (sw / players), sh
    else
        -- split the views in half vertically
        if i <= players / 2 then
            return (i - 1) * (sw / (players / 2)), 0, (sw / (players / 2)), sh / 2
        else
            return ((i - (players / 2) - 1) * (sw / (players / 2))), sh / 2, (sw / (players / 2)), sh / 2
        end
    end
end

function game:enter(oldScene, mode, players)
    local sw, sh = love.graphics.getDimensions()
    if players then
        for i = 1, players do
            local x, y, w, h = getdimensions(i, players, sw, sh)
            self.canvases[i] = love.graphics.newCanvas(w, h)
            self.worlds[i] = world.new(mode)
        end
    else
        self.worlds[1] = world.new(mode)
    end
end

function game:update(dt)
    for _, world in pairs(self.worlds) do
        world:update(dt)
    end
end

function game:draw()
    if #self.worlds == 1 then
        self.worlds[1]:draw()
    else
        local sw, sh = love.graphics.getDimensions()

        for i, world in pairs(self.worlds) do
            local x, y, w, h = getdimensions(i, #self.worlds, sw, sh)
            local canvas = self.canvases[i]
            -- draw splitscreen world
            love.graphics.setCanvas({canvas, depth = true})
                love.graphics.clear()
                love.resize(w, h)
                world:draw()
            love.graphics.setCanvas()
            love.graphics.draw(canvas, x, y)
        end

        -- draw lines
        love.graphics.setColor(0, 0, 0)
        if #self.worlds <= 3 then
            for i = 1, #self.worlds - 1 do
                local x, y, w, h = getdimensions(i, #self.worlds, sw, sh)
                love.graphics.line(x + w, y, x + w, y + h)
            end
        else
            love.graphics.line(0, sh / 2, sw, sh / 2)
            for i = 1, (#self.worlds / 2) - 1 do
                local x, y, w, h = getdimensions(i, #self.worlds, sw, sh)
                love.graphics.line(x + w, y, x + w, y + h)
            end
            for i = (#self.worlds / 2) + 1, #self.worlds - 1 do
                local x, y, w, h = getdimensions(i, #self.worlds, sw, sh)
                love.graphics.line(x + w, y, x + w, y + h)
            end
        end
        love.graphics.setColor(1, 1, 1)
    
        love.graphics.setCanvas()
    end
end

function game:keypressed(key)
    if #self.worlds > 1 then
         -- multiple inputs
        if key == "lshift" then
            self.worlds[1]:dropcone()
        elseif key == "space" then
            self.worlds[2]:dropcone()
        elseif key == "return" then
            self.worlds[3]:dropcone()
        end
    else
         -- solo inputs
        if key == "space" or key == "return" or key == "w" or key == "up" then
            self.worlds[1]:dropcone()
        end
    end
end

function game:exit()
    -- do this to prevent weird g3d camera bugs when switching back to menu
    love.resize(love.graphics.getDimensions())
    self.worlds = {}
end

return game