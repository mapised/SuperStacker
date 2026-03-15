local gui = require("src.gui")
local keybinds = require("src.keybinds")
local world = require("src.game.world")
local resources = require("src.resources")

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
    if players and players > 1 then
        self.duels = {
            timer = 0;
            roundcount = 0;
            message = "";
            pointawarded = false;
            victorannounced = false;
        }
        for i = 1, players do
            local x, y, w, h = getdimensions(i, players, sw, sh)
            self.canvases[i] = love.graphics.newCanvas(w, h)
            self.worlds[i] = world.new(mode, i, players)
            self.worlds[i].duelsscore = 0
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
    else
        self:updateduels(dt)
    end
end

function game:draw()
    if #self.worlds == 1 then
        self.worlds[1]:draw()
    else
        self:drawduels()
    end
end

function game:updateduels(dt)
    local canreset = true
    for _, world in pairs(self.worlds) do 
        if not world.gameover then
            canreset = false
        end
    end

    if canreset then
        self.duels.timer = self.duels.timer + dt
        local timer = 4 - math.floor(self.duels.timer)

        if self.duels.timer > 5 then
            if self.duels.victorannounced then
                require("src.scenes"):switch("menu")
            else
                self.duels.roundcount = self.duels.roundcount + 1
                self.duels.pointawarded = false
                self.duels.timer = 0

                for _, world in pairs(self.worlds) do 
                    world:reset()
                end
            end
            self.duels.message = ""
        elseif self.duels.timer > 1 then
            if not self.duels.victorannounced then
                for _, world in pairs(self.worlds) do
                    if world.duelsscore >= 5 then
                        love.audio.stop(resources.sounds.win)
                        love.audio.play(resources.sounds.win)
                        self.duels.victorannounced = true
                        return
                    end
                end
                self.duels.message = "Next Round in " .. timer
            else
                self.duels.message = "Exiting in " .. timer
            end
        elseif self.duels.timer >= 0.5 then
            if not self.duels.pointawarded then
                local winners = self.worlds

                table.sort(winners, function(world1, world2)
                    if world1.duelsscore > world2.duelsscore then
                        return true
                    end
                    return false
                end)

                if winners[1] == winners[2] then
                    -- tie
                    love.audio.stop(resources.sounds.red)
                    love.audio.play(resources.sounds.red)
                    for _, world in pairs(self.worlds) do
                        table.insert(world.messages, {
                            text = "Tie";
                            time = 1;
                        })
                        world:flashcolor({1, 0, 0})
                    end
                else
                    love.audio.stop(resources.sounds.gold)
                    love.audio.play(resources.sounds.gold)
                    winners[1].duelsscore = winners[1].duelsscore + 1
                    table.insert(winners[1].messages, {
                        text = "+1";
                        time = 1;
                    })
                    winners[1]:flashcolor({0, 1, 0})
                end

                self.duels.pointawarded = true
            end
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
    gui:drawtext(self.duels.message, 10, 10, resources.fonts.regular20px, "left", "bottom")
    love.graphics.setColor(1, 1, 1)

    love.graphics.setCanvas()
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
    self.duels = {}
end

return game