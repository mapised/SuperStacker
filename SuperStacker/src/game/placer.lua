local resources = require("src.resources")
local constants = require("src.constants")

local placer = {}
placer.__index = placer

function placer.new(world)
    local self = {}
    setmetatable(self, placer)

    self.cone = nil

    self.world = world
    self.direction = -1
    self.speed = 4
    self.x = 0
    self.y = 0

    return self
end

function placer:setcone(cone)
    if cone then
        self.cone = cone
    end
end

function placer:update(dt)
    if self.cone then
        -- moving left and right
        self.x = self.x + ((self.direction * self.speed) * dt)
        if self.direction < 0 then
            if self.x < -constants.placerX then
                self.direction = 1
            end
        else
            if self.x > constants.placerX then
                self.direction = -1
            end
        end
        -- get height
        if self.world.stack then
            self.y = (self.world.stack.length * constants.coneoffset) + constants.placerY
        end
        -- move cone
        self.cone:setTranslation(self.x, 0, self.y)
    end
end

function placer:getaccuracy()
    return (1 - math.abs(self.x)) * 100
end

function placer:draw()
    if self.cone then
        self.cone:draw()
    end
end

return placer