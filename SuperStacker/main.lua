local g3d = require("g3d")
local earth = g3d.newModel("assets/models/cone.obj", "assets/textures/trafficcone.png", {0, 0, 0}, {math.pi / 2, 0, 0})
local base = g3d.newModel("assets/models/base.obj", "assets/textures/base.png", {0, 0, -2}, {math.pi / 2, 0, 0})

function love.load()
    love.window.setTitle("Super Stacker 3D")
    love.window.setIcon(love.image.newImageData("assets/icon.png"))
end

function love.mousemoved(x,y, dx,dy)
    g3d.camera.firstPersonLook(dx,dy)
end

function love.update(dt)
    g3d.camera.firstPersonMovement(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
    earth:draw()
    base:draw()
end