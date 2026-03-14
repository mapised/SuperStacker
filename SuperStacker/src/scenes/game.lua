local keybinds = require("src.keybinds")
local world = require("src.game.world")

local game = {
    resettimer = 3;
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
            self.worlds[i] = world.new(mode, i, players)
        end
    else
        self.worlds[1] = world.new(mode)
    end
end

function game:update(dt)
    if self.resettimer > 0 then
        self.resettimer = self.resettimer - 1
    end

    -- check win condition / update for singleplayer
    if #self.worlds == 1 then
        self.worlds[1]:update(dt)
        if self.worlds[1].gameover and self.resettimer <= 0 then
            require("src.scenes"):switch("menu")
        end
    else
        local canreset = true
        for _, world in pairs(self.worlds) do
            if not world.gameover then
                canreset = false
            end
        end
        if canreset then
            require("src.scenes"):switch("menu")
        end
    end
end

function game:drawduels()
    -- SPLITSCREEN
    local sw, sh = love.graphics.getDimensions()

    for i, world in pairs(self.worlds) do
        -- update world before drawing to prevent weird bugs with the g3d camera
        world:update(love.timer.getDelta())
        -- draw the canvas
        local x, y, w, h = getdimensions(i, #self.worlds, sw, sh)
        local canvas = self.canvases[i]

        love.graphics.setCanvas({canvas, depth = true})
            love.graphics.clear(world.backgroundcolor)
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

function game:draw()
    if #self.worlds == 1 then
        self.worlds[1]:draw()
    else
        self:drawduels()
    end
end

function game:keypressed(key)
    if keybinds[#self.worlds] then
        for i, keys in pairs(keybinds[#self.worlds]) do
            for _, keybind in pairs(keys) do
                if key == keybind then
                    self.worlds[i]:input()
                end
            end
        end
    end
end

function game:exit()
    -- do this to prevent weird g3d camera bugs when switching back to menu
    love.resize(love.graphics.getDimensions())
    self.canvases = {}
    self.worlds = {}
end

return game