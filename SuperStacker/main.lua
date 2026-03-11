local g3d = require("g3d")
local gui = require("src.gui")
local scenes = require("src.scenes")
require("debugger")

function lerp(a, b, c)
    return a + (b - a) * c
end

-- love callbacks
function love.load()
    love.graphics.setBackgroundColor(0.78, 0.78, 0.78)
    love.math.setRandomSeed(os.time())
    love.resize(love.graphics.getDimensions())

    scenes:load()
end

function love.resize(w, h)
    g3d.camera.aspectRatio = w / h
    g3d.camera.updateProjectionMatrix()

    gui:setscale(math.max((math.floor((math.min(w, h) / 700) * 4) / 4), 0.25))
end

function love.keypressed(key)
    if key == "escape" then
        scenes:switch("menu")
    end

    scenes:call("keypressed", key)
end

function love.update(dt)
    print(gui.textSize)
    scenes:call("update", dt)
end

function love.draw()
    scenes:call("draw")
end