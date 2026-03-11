local g3d = require("g3d")
local gui = require("src.gui")
local resources = require("src.resources")
local stack = require("src.game.stack")
local placer = require("src.game.placer")

local gamemodes = {
    static = require("src.game.modes.static");
    classic = require("src.game.modes.classic");
    arcade = require("src.game.modes.arcade");
}

local world = {}
world.__index = world

function world.new(mode, override)
    if gamemodes[mode] then
        local self = {}
        setmetatable(self, world)

        -- custom behavior?
        if not gamemodes[mode].custombehavior then
            self.stack = stack.new(self)
            self.placer = placer.new(self)

            self.stack:addcone()
        end
        
        self.gameover = false
        self.score = 0
        self.mode = gamemodes[mode].new(self)

        return self
    end
end

function world:lose()
    self.gameover = true

    if self.mode.lose then
        self.mode:lose()
    end
end

function world:createcone(color)
    local texture = resources.textures[color] or resources.textures.trafficcone
    local cone = g3d.newModel(resources.models.cone, texture, {0, 0, 0}, {math.pi/2, 0, 0})

    return cone
end

function world:dropcone()
    if not self.gameover then
        self.mode:dropcone()
    end
end

function world:draw()
    if not self.mode.custombehavior then
        self.stack:draw()
        self.placer:draw()
        self.mode:draw()
    end

    if self.gameover then -- draw game over screen
        gui:drawtext("Game Over!", 0, 0, resources.fonts.regular40px, "center", "center")
        gui:drawtext("Score " .. self.score, 0, 30, resources.fonts.regular20px, "center", "center")
    end
end

function world:update(dt)
    if not self.mode.custombehavior then
        self.placer:update(dt)
    end
    self.mode:update(dt)
end

return world