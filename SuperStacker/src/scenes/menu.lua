local world = require("src.game.world")
local gui = require("src.gui")
local menu = {}

function menu:enter(oldScene, score)
    self.background = world.new("static")

    local playbutton = gui:createbutton(0, -90, 220, 70, "center", "center")
    playbutton.text = "Play!"

    local leaderboardbutton = gui:createbutton(0, 0, 220, 70, "center", "center")
    leaderboardbutton.text = "Leaderboard"

    local optionsbutton = gui:createbutton(0, 90, 220, 70, "center", "center")
    optionsbutton.text = "Options"
end

function menu:update(dt)
    self.background:update(dt)
end

function menu:draw()
    self.background:draw()
end

function menu:keypressed(key)
    if key == "return" then
        require("src.scenes"):switch("game", "arcade", 3)
    end
end

function menu:exit()
    
end

return menu