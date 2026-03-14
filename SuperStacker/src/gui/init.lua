local button = require("src.gui.button")

local gui = {
    textSize = 1;
    uiSize = 1;
    element = {};
}

function gui:setscale(scale)
    self.textSize = scale
    self.uiSize = scale
end

function gui:getdimensions()
    local sw, sh = love.graphics.getDimensions()
    if love.graphics.getCanvas() then
        sw, sh = love.graphics.getCanvas():getDimensions()
    end
    
    return sw, sh
end

function gui:drawtext(text, x, y, font, xallignment, yallignment, color)
    love.graphics.setFont(font)

    local sw, sh = self:getdimensions()
    local fh = font:getHeight(text)
    local oy = 0

    -- ALLIGN POSITIONS
    if yallignment == "center" then
        oy = fh / 2
        y = sh / 2 + y
    elseif yallignment == "bottom" then
        oy = fh
        y = sh - y
    end

    if xallignment == "right" then
        x = -x
    end

    if color then
        love.graphics.setColor(unpack(color))
    else
        love.graphics.setColor(0, 0, 0, 1)
    end

    love.graphics.printf(text, x, y, sw / self.textSize, xallignment, 0, self.textSize, self.textSize, 0, oy)
    love.graphics.setColor(1, 1, 1)
end

function gui:drawsprite(drawable, x, y, sx, sy, xallignment, yallignment, color)
    local sw, sh = self:getdimensions()
    local ox, oy = 0, 0

    -- ALLIGN POSITIONS
    if yallignment == "center" then
        oy = drawable:getHeight() / 2
        y = sh / 2 + y
    elseif yallignment == "bottom" then
        oy = drawable:getHeight()
        y = sh - y
    end

    if xallignment == "center" then
        ox = drawable:getWidth() / 2
        x = sw / 2 + x
    elseif xallignment == "right" then
        ox = drawable:getWidth()
        x = sw - x
    end

    love.graphics.setColor(color and unpack(color) or 0, 0, 0)
    love.graphics.draw(drawable, x, y, 0, sx * self.uiSize, sy * self.uiSize, ox, oy)
    love.graphics.setColor(1, 1, 1)
end

function gui:drawrectangle(mode, x, y, w, h, xallignment, yallignment, color)
    local sw, sh = self:getdimensions()
    x, y = x * self.uiSize, y * self.uiSize
    w, h = w * self.uiSize, h * self.uiSize

        -- ALLIGN POSITIONS
    if yallignment == "center" then
        y = sh / 2 + y + (h / 2)
    elseif yallignment == "bottom" then
        y = sh - y + h
    end

    if xallignment == "center" then
        x = sw / 2 + x + (w / 2)
    elseif xallignment == "right" then
        x = sw - x + w
    end

    love.graphics.setColor(color and unpack(color) or 0, 0, 0)
    love.graphics.rectangle(mode, x, y, w, h)
end

function gui:createbutton(x, y, w, h, xallignment, yallignment)
    local element = button.new(x, y, w, h, xallignment, yallignment)
    table.insert(self.element, element)

    return element
end

function gui:mousepressed()
    for _, element in pairs(self.elements) do
        if element.pressed then
            element:pressed()
        end
    end
end

function gui:update()
    local mx, my = love.mouse.getPosition()

    for _, element in pairs(self.elements) do 
        element:update(mx, my)
    end
end

function gui:draw()
    for _, element in pairs(self.elements) do 
        element:draw()
    end
end

function gui:clear()
    
end

return gui