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
        self.state = "hover"
    else
        if self.pressed then
            self.state = "pressed"
        else
            self.state = "normal"
        end
    end
end

function button:mousepressed()
    if self.hovered and self.onclick then
        self:onclick()
    end
end

function button:draw()
    local style = styles[self.style]
    local pallete = style[self.state]

    self.gui:drawrectangle("fill", self.x, self.y, self.w, self.h, "center", "center", pallete.background)
    love.graphics.setLineWidth(math.ceil(style.borderwidth * self.gui.uiSize))
    self.gui:drawrectangle("line", self.x, self.y, self.w, self.h, "center", "center", pallete.border)

    if self.text then
        local font = style.font
        love.graphics.setFont(font)

        local bx, by = self.x * self.gui.uiSize, self.y * self.gui.uiSize
        local bw, bh = self.w * self.gui.uiSize, self.h * self.gui.uiSize
        local allignedx, allignedy, ox, oy = self.gui:alligncoords(bx, by, bw, bh, "center", "center")

        local fw, fh = font:getWidth(self.text), font:getHeight(self.text)
        local fx, fy = allignedx - ox + (bw / 2), allignedy - oy + (bh / 2)
        local ox, oy = fw / 2, fh / 2

        love.graphics.setColor(pallete.text)
        love.graphics.print(self.text, fx, fy, 0, self.gui.uiSize, self.gui.uiSize, ox, oy)
        love.graphics.setColor(1, 1, 1)
    end
end


return button