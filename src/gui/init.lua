local button = require("src.gui.button")

local gui = {
    scale = 1;
    elements = {};
}

function gui:setscale(scale)
    self.scale = scale
end

function gui:getdimensions()
    local sw, sh = love.graphics.getDimensions()
    if love.graphics.getCanvas() then
        sw, sh = love.graphics.getCanvas():getDimensions()
    end
    
    return sw, sh
end

function gui:alligncoords(x, y, w, h, xallignment, yallignment)
    local sw, sh = self:getdimensions() 
    local ox, oy = 0, 0

    x = x * self.scale
    y = y * self.scale

    -- ALLIGN POSITIONS
    if yallignment == "center" then
        oy = h / 2
        y = sh / 2 + y
    elseif yallignment == "bottom" then
        oy = h
        y = sh - y
    end

    if xallignment == "center" then
        ox = w / 2
        x = sw / 2 + x
    elseif xallignment == "right" then
        ox = w
        x = sw - x
    end

    return x, y, ox, oy
end

function gui:drawtext(text, x, y, font, xallignment, yallignment, color)
    love.graphics.setFont(font)

    local fw, fh = font:getWidth(text), font:getHeight(text)
    local allignedx, allignedy, ox, oy = self:alligncoords(x, y, fw, fh, xallignment, yallignment)

    if color then
        love.graphics.setColor(unpack(color))
    else
        love.graphics.setColor(0, 0, 0, 1)
    end

    love.graphics.print(text, allignedx, allignedy, 0, self.scale, self.scale, ox, oy)
    love.graphics.setColor(1, 1, 1)
end

function gui:drawtextinsiderectangle(text, font, x, y, w, h, xallignment, yallignment, color)
    love.graphics.setFont(font)

    local bw, bh = w * self.scale, h * self.scale
    local allignedx, allignedy, ox, oy = self:alligncoords(x, y, bw, bh, xallignment, yallignment)

    local fw, fh = font:getWidth(text), font:getHeight(text)
    local fx, fy = allignedx - ox + (bw / 2), allignedy - oy + (bh / 2)
    ox, oy = fw / 2, fh / 2

    if color then
        love.graphics.setColor(unpack(color))
    else
        love.graphics.setColor(0, 0, 0, 1)
    end

    love.graphics.print(text, fx, fy, 0, self.scale, self.scale, ox, oy)
    love.graphics.setColor(1, 1, 1)
end

function gui:drawsprite(drawable, x, y, sx, sy, xallignment, yallignment, color)
    local w, h = drawable:getWidth(), drawable:getHeight()
    local allignedx, allignedy, ox, oy = self:alligncoords(x,y, w, h, xallignment, yallignment)

    if color then
        love.graphics.setColor(unpack(color))
    else
        love.graphics.setColor(0, 0, 0, 1)
    end

    love.graphics.draw(drawable, allignedx, allignedy, 0, sx * self.scale, sy * self.scale, ox, oy)
    love.graphics.setColor(1, 1, 1)
end

function gui:drawrectangle(mode, x, y, w, h, xallignment, yallignment, color) 
    w, h = w * self.scale, h * self.scale
    local allignedx, allignedy, ox, oy = self:alligncoords(x, y, w, h, xallignment, yallignment)

    if color then
        love.graphics.setColor(unpack(color))
    else
        love.graphics.setColor(0, 0, 0, 1)
    end

    love.graphics.rectangle(mode, allignedx - ox, allignedy - oy, w, h)
    love.graphics.setColor(1, 1, 1, 1)
end

function gui:createbutton(x, y, w, h, xallignment, yallignment)
    local element = button.new(self, x, y, w, h)
    table.insert(self.elements, element)

    return element
end

function gui:mousepressed()
    for _, element in pairs(self.elements) do
        element:mousepressed()
    end
end

function gui:mousereleased()
    for _, element in pairs(self.elements) do
        element:mousereleased()
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
    self.elements = {}
end

return gui