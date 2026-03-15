local gui = require("src.gui")
local resources = require("src.resources")

local mainmenu = {}

function mainmenu.enter(menu)
    local play = gui:createbutton(0, -45, 220, 65, "center", "center")
    play.text = "Play!"
    play.onclick = function()
        menu:setmenu("playmenu")
    end

    local leaderboard = gui:createbutton(0, 45, 220, 65, "center", "center")
    leaderboard.text = "Leaderboard"

    local options = gui:createbutton(0, 135, 220, 65, "center", "center")
    options.text = "Options"
end

function mainmenu.draw()
    gui:drawtext("Super Stacker 3D", 0, -200, resources.fonts.regular60px, "center", "center")
end

return mainmenu
