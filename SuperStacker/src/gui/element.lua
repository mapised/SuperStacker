local element = {}
element.__index = element

function element.new(gui, x, y, w, h)
    local self = {}

    self.gui = gui
    self.hovered = false
    self.pressed = false
    self.x = x
    self.y = y
    self.w = w 
    self.h = h

    return self
end

function element:contains(mx, my)
    local w, h = self.w * self.gui.scale, self.h * self.gui.scale
    local allignedx, allignedy, ox, oy = self.gui:alligncoords(self.x, self.y, w, h, "center", "center")

    if mx > allignedx - ox and mx < allignedx - ox + w then
        if my > allignedy - oy and my < allignedy - oy + h then
            return true
        end
    end

    return false
end

function element:update(mx, my)
    self.hovered = self:contains(mx, my)
end

function element:mousepressed()
    if self.hovered then
        print("WAHH!")
        self.pressed = true
    end
end

function element:mousereleased()
    print("EY")
    self.pressed = false
end

return element