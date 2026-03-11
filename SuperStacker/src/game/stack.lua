local g3d = require("g3d")
local resources = require("src.resources")
local constants = require("src.constants")

local stack = {}
stack.__index = stack

function stack.new(world)
    local self = {}
    setmetatable(self, stack)

    self.base = g3d.newModel(resources.models.base, resources.textures.base, {0, 0, -2}, {math.pi/2, 0, 0}, {1, 1, 1})

    self.world = world
    self.length = 0
    self.cones = {}

    return self
end

function stack:addcone(cone)
    if not cone then
        cone = self.world:createcone()
    end 

    -- move it to the top of the stack
    cone:setTranslation(0, 0, self.length * constants.coneoffset)
    self.length = self.length + 1
    self.cones[self.length] = cone
end

function stack:draw()
    -- draw the bottom
    self.base:draw()

    -- draw the cones
    for _, cone in pairs(self.cones) do
        cone:draw() 
    end
end

return stack