local g3d = require("g3d")
local resources = require("src.resources")

local classic = {}
classic.custombehavior = false
classic.__index = classic

function classic.new(world)
    local self = {}
    setmetatable(self, classic)

    self.score = 0
    self.height = 0
    self.world = world

    self.world.placer:setcone(self.world:createcone())

    return self
end

function classic:dropcone()
    if self.world.placer.cone then
        local accuracy = self.world.placer:getaccuracy()

        if accuracy > 50 then
            love.audio.stop(resources.sounds.conedrop)
            love.audio.play(resources.sounds.conedrop)
            -- place cone
            self.world.stack:addcone(self.world.placer.cone)
            self.world.placer:setcone(self.world:createcone())
            self.world.placer.x = 0
            -- increase speed a little bit
            self.world.placer.speed = math.min(self.world.placer.speed + 1, 5)
        else
            --self.world:lose()
        end
    end
end

function classic:update(dt)
    self.height = lerp(self.height, self.world.placer.y, dt * 4)
end

function classic:draw()
    local x, y, z = -3, 3, self.height + 2
    local lookX, lookY, lookZ = 0, 0, self.height
    
    g3d.camera.lookAt(x, y, z, lookX, lookY, lookZ)
end

return classic