local gui = {
    textSize = 1;
    uiSize = 1;
    buttons = {};
}

function gui:setscale(scale)
    self.textSize = scale
    self.uiSize = scale
end

local function getdimensions()
    local sw, sh = love.graphics.getDimensions()
    if love.graphics.getCanvas() then
        sw, sh = love.graphics.getCanvas():getDimensions()
    end
    
    return sw, sh
end

function gui:drawtext(text, x, y, font, xallignment, yallignment, color)
    love.graphics.setFont(font)
    love.graphics.setColor(color and unpack(color) or 0, 0, 0)

    local sw, sh = getdimensions()
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

    love.graphics.printf(text, x, y, sw / self.textSize, xallignment, 0, self.textSize, self.textSize, 0, oy)
    love.graphics.setColor(1, 1, 1)
end

function gui:drawsprite(drawable, x, y, sx, sy, xallignment, yallignment, color)
    love.graphics.setColor(color and unpack(color) or 0, 0, 0)

    local sw, sh = getdimensions()
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

    love.graphics.draw(drawable, x, y, 0, sx * self.uiSize, sy * self.uiSize, ox, oy)
    love.graphics.setColor(1, 1, 1)
end

function gui:createbutton()
    
end

function gui:clear()
    
end

return gui