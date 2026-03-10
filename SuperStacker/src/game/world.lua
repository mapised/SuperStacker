local g3d = require("g3d")
local resources = require("src.resources")
local stack = require("src.game.stack")
local placer = require("src.game.placer")

local gamemodes = {
    static = require("src.game.modes.static");
    classic = require("src.game.modes.classic");
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
        
        self.mode = gamemodes[mode].new(self)

        return self
    end
end

function world:lose()
    love.audio.play(resources.sounds.conefall)
    require("src.scenes"):switch("menu")
end

function world:createcone(color)
    local texture = resources.textures[color] or resources.textures.trafficcone
    local cone = g3d.newModel(resources.models.cone, texture, {0, 0, 0}, {math.pi/2, 0, 0})

    return cone
end

function world:dropcone()
    self.mode:dropcone()
end

function world:draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.stack.length, 30, 30, 0, 2, 2)
    love.graphics.setColor(1, 1, 1)
    self.mode:draw()
    if not self.mode.custombehavior then
        self.stack:draw()
        self.placer:draw()
    end
end

function world:update(dt)
    if not self.mode.custombehavior then
        self.placer:update(dt)
    end
    self.mode:update(dt)
end

return world