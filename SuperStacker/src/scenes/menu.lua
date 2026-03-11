local world = require("src.game.world")
local menu = {}

function menu:enter(oldScene, score)
    self.background = world.new("static")
end

function menu:update(dt)
    self.background:update(dt)
end

function menu:draw()
    self.background:draw()
end

function menu:keypressed(key)
    if key == "return" then
        require("src.scenes"):switch("game", "classic", 12)
    end
end

function menu:exit()
    
end

return menu