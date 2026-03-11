local g3d = require("g3d")
local gui = require("src.gui")
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
    if self.world.placer.speed < 3 then
        self.world.placer.speed = self.world.placer.speed + 0.2
    else
        self.world.placer.speed = math.min(self.world.placer.speed + 0.1, 5)
    end
end

function classic:playconesound()
    resources.sounds.conedrop:setPitch(1 + ((math.random() - 0.5) * 0.2))

    love.audio.stop(resources.sounds.conedrop)
    love.audio.play(resources.sounds.conedrop)
end

function classic:addcone()
    self.world.score = self.world.score + 1
    self.world.stack:addcone(self.world.placer.cone)
    self.world.placer:setcone(self.world:createcone())
    self.world.placer.x = 0
end

function classic:dropcone()
    if self.world.placer.cone then
        local accuracy = self.world.placer:getaccuracy()

        if accuracy >= 50 then
            -- place cone
            self:addcone()
            self:playconesound()
            self:increasespeed()
        else
            self.world:lose()
        end
    end
end

function classic:lose()
    -- cone drop!
    love.audio.play(resources.sounds.conefall)

    self.world.placer.falling = true
    self.x, self.y, self.z = unpack(g3d.camera.position)
end

function classic:update(dt)
    if self.world.gameover then
        self.z = self.z - (dt * 2)

        g3d.camera.lookAt(self.x, self.y, self.z, self.world.placer.x, 0, self.world.placer.y)
    else
        -- isometric spinning camera
        self.timer = self.timer + (dt * 0.5)
        self.height = lerp(self.height, self.world.placer.y, dt * 8)

        local x, y, z = (math.cos(self.timer) * 4), (math.sin(self.timer) * 4), self.height + 2.5
        local lookX, lookY, lookZ = 0.5, 0.5, self.height + 1

        g3d.camera.lookAt(x, y, z, lookX, lookY, lookZ)
    end
end

function classic:draw()
    -- draw score
    gui:drawtext(self.world.score, 0, 20, resources.fonts.regular60px, "center", "topLeftX")
end

return classic