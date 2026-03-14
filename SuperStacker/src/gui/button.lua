local element = require("src.gui.element")

local button = setmetatable({}, {__index = element})
button.__index = button

function button.new(gui, x, y, w, h)
    local self = setmetatable(button.new(gui, x, y, w, h), button)

    self.color = {0, 0, 0}
    self.normalcolor = {0, 0, 0}
    self.hovercolor = {0.5, 0.5, 0.5}
    self.pressedcolor = {1, 1, 1}

    return self
end

function button:update(mx, my)
    element.update(self, mx, my)
end

function button:draw()
    self.gui:drawrectangle(x, y,)
end


return button