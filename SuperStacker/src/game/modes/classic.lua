local g3d = require("g3d")
local resources = require("src.resources")

local classic = {}
classic.custombehavior = false
classic.__index = classic

function classic.new(world)
    local self = {}
    setmetatable(self, classic)

    self.timer = 0
    self.world = world
    self.height = self.world.placer.y

    self.world.placer:setcone(self.world:createcone())

    return self
end

function classic:increasespeed()
    -- increase speed a little bit
    if self.world.placer.speed < 1 then
        self.world.placer.speed = self.world.placer.speed + 0.025
    else
        self.world.placer.speed = self.world.placer.speed + 0.01
    end
end

function classic:dropcone()
    if self.world.placer.cone then
        local accuracy = self.world.placer:getaccuracy()

        if accuracy >= 50 then
            love.audio.stop(resources.sounds.conedrop)
            love.audio.play(resources.sounds.conedrop)
            -- place cone
            print(accuracy)
            self.world.score = self.world.score + 1
            self.world.stack:addcone(self.world.placer.cone)
            self.world.placer:setcone(self.world:createcone())
            self.world.placer.x = 0

            self:increasespeed()
        else
            self.world:lose()
        end
    end
end

function classic:update(dt)
    -- isometric spinning camera
    self.timer = self.timer + (dt * 0.5)
    self.height = lerp(self.height, self.world.placer.y, dt * 8)

    local x, y, z = (math.cos(self.timer) * 4), (math.sin(self.timer) * 4), self.height + 2
    local lookX, lookY, lookZ = 0.5, 0.5, self.height
    
    g3d.camera.lookAt(x, y, z, lookX, lookY, lookZ)
end

function classic:draw()
    -- draw score
    love.graphics.setFont(resources.fonts.regular40px)
    love.graphics.setColor(0, 0, 0)

    local sw = love.graphics.getWidth()
    if love.graphics.getCanvas() then
        sw = love.graphics.getCanvas():getWidth()
    end

    love.graphics.printf(self.world.score, 0, 20, sw, "center")
    love.graphics.setColor(1, 1, 1)
end

return classic