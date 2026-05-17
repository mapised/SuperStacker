local mainmenu = require("src.menus.mainmenu")
local resources = require("src.resources")
local constants = require("src.constants")
local gui = require("src.gui")

local options = {}

function options.enter()

end

function options.draw()
    gui:drawrectangle("line", 0, -50, 900, 650, "center", "center", {0.631, 0.705, 0.729})
    gui:drawrectangle("fill", -35, -375, 125, 100, "center", "center", constants.backgroundcolor)

    gui:drawtext("Options", -35, -375, resources.fonts.regular20px, "center", "center", {0.631, 0.705, 0.729})
end

return options