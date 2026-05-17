local element = require("src.gui.element")
local resources = require("src.resources")

local styles = {
    default = {
        font = resources.fonts.regular20px,
        borderwidth = 2,
        normal = {
            background = {0.788, 0.788, 0.788};
            border = {0.513, 0.513, 0.513};
            text = {0.407, 0.407, 0.407};
        },
        hover = {
            background = {0.787, 0.937, 0.996};
            border = {0.356, 0.698, 0.851};
            text = {0.423, 0.607, 0.737};
        },
        pressed = {
            background = {0.592, 0.909, 1};
            border = {0.01, 0.572, 0.780};
            text = {0.21, 0.545, 0.686};
        },
        disabled = {
            background = {0.902, 0.913, 0.913};
            border = {0.709, 0.756, 0.760};
            text = {0.682, 0.717, 0.721};
        }
    }
}

local button = setmetatable({}, {__index = element})
button.__index = button

function button.new(gui, x, y, w, h)
    local self = setmetatable(element.new(gui, x, y, w, h), button)

    self.style = "default"
    self.state = "normal"
    self.onclick = nil

    return self
end

function button:update(mx, my)
    element.update(self, mx, my)

    if self.hovered then
        if self.pressed then
            self.state = "pressed"
        else
            self.state = "hover"
        end
    else
        self.state = "normal"
    end
end

function button:mousepressed()
    element.mousepressed(self)

    if self.hovered and self.onclick then
        self:onclick()
    end
end

function button:mousereleased()
    element.mousereleased(self)
end

function button:draw()
    local style = styles[self.style]
    local pallete = style[self.state]

    self.gui:drawrectangle("fill", self.x, self.y, self.w, self.h, "center", "center", pallete.background)
    love.graphics.setLineWidth(math.ceil(style.borderwidth * self.gui.scale))
    self.gui:drawrectangle("line", self.x, self.y, self.w, self.h, "center", "center", pallete.border)

    if self.text then
        self.gui:drawtextinsiderectangle(self.text, resources.fonts.regular20px, self.x, self.y, self.w, self.h, "center", "center", pallete.text)
    end
end


return button