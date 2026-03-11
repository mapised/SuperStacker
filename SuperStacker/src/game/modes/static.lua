-- SPECIAL STATE: only used for the menu, cones dont drop, camera spins
local g3d = require("g3d")
local resources = require("src.resources")

local static = {}
static.custombehavior = false
static.__index = static

function static.new(world)
    local self = {}
    setmetatable(self, static)

    self.timer = 0
    self.height = 0
    self.world = world

    self.world.placer:setcone(self.world:createcone())

    return self
end

function static:update(dt)
    -- spin around the stack cooly
    self.timer = self.timer + dt

    self.height = lerp(self.height, math.sin(self.timer) * 1.5, dt * 6)
    local x, y, z = (math.cos(self.timer) * 5), (math.sin(self.timer) * 5), self.height + 1
    local lookX, lookY, lookZ = 1, 1, 2
    
    g3d.camera.lookAt(x, y, z, lookX, lookY, lookZ)
end

function static:draw()
    love.graphics.setFont(resources.fonts.regular60px)
    love.graphics.setColor(0, 0, 0)

    local sw, sh = love.graphics.getDimensions()

    love.graphics.printf("Super Stacker 3D", 0, sh / 2 - 30, sw, "center")

    love.graphics.setFont(resources.fonts.regular20px)
    love.graphics.print("A Cone Stacker fangame by Aiden", 5, sh - 70, 0, 1, 1)
    love.graphics.print("Cone Stacker is made by Gavin", 5, sh - 45, 0, 1, 1)
    
    love.graphics.setColor(1, 1, 1)
end

return static