local world = require("src.game.world")
local gui = require("src.gui")
local menu = {}

function menu:enter(oldScene, score)
    self.background = world.new("static")

    local playbutton = gui:createbutton(0, -45, 220, 70, "center", "center")
    playbutton.text = "Play!"
    playbutton.onclick = function()
        require("src.scenes"):switch("game", "arcade", 3)
    end

    local leaderboardbutton = gui:createbutton(0, 45, 220, 70, "center", "center")
    leaderboardbutton.text = "Leaderboard"

    local optionsbutton = gui:createbutton(0, 135, 220, 70, "center", "center")
    optionsbutton.text = "Options"
end

function menu:update(dt)
    self.background:update(dt)
end

function menu:draw()
    self.background:draw()
end

function menu:keypressed(key)
end

function menu:exit()
    
end

return menu