-- SPECIAL STATE: only used for the menu, cones dont drop, camera spins
local g3d = require("lib.g3d")
local gui = require("src.gui")
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
    gui:drawtext("Super Stacker 3D", 0, -200, resources.fonts.regular60px, "center", "center")
    gui:drawtext("A Cone Stacker fangame by Aiden", 10, 45, resources.fonts.regular20px, "left", "bottom")
    gui:drawtext("Cone Stacker is made by Gavin", 10, 0, resources.fonts.regular20px, "left", "bottom")
end

return static