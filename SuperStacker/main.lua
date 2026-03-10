local g3d = require("g3d")
local scenes = require("src.scenes")
require("debugger")

function lerp(a, b, c)
    return a + (b - a) * c
end

function love.load()
    love.math.setRandomSeed(os.time())
    scenes:load()
end

function love.resize(w, h)
    g3d.camera.aspectRatio = w / h
    g3d.camera.updateProjectionMatrix()
end

function love.keypressed(key)
    scenes:call("keypressed", key)
end

function love.update(dt)
    scenes:call("update", dt)
end

function love.draw()
    scenes:call("draw")
    love.graphics.setBackgroundColor(0.8, 0.8, 0.8)
end