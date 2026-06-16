--[[
    text.lua — Flexible text rendering for LÖVE
    https://github.com/Laimadoo/love2d-text

    MIT License

    Copyright (c) 2026 Laimadoo

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
]]

local newText = love.graphics.newTextBatch or love.graphics.newText
local utf8 = require("utf8")


local builtinAnimations = {}

builtinAnimations.sine = function(amplitude, speed, phaseOffset)
    amplitude = amplitude or 5
    speed = speed or 3
    phaseOffset = phaseOffset or 0.5
    return function(char, index, total)
        local t = love.timer.getTime()
        local y = amplitude * math.sin(t * speed + (index - 1) * phaseOffset)
        return 0, y
    end
end

local setAnimation = function(self, anim, ...)
    if type(anim) == "function" then
        self.animFunc = anim
    elseif builtinAnimations[anim] then
        self.animFunc = builtinAnimations[anim](...)
    else
        self.animFunc = nil
    end
end

local reloadtext = function(textObj)
    local traw = textObj.raw
    local wraplimit = traw.wraplimit
    local text = traw.text

    if not wraplimit and traw.align ~= "left" and text and type(text) ~= "table" then
        local maxWidth = 0
        for line in tostring(text):gmatch("[^\n]+") do
            local w = traw.font:getWidth(line)
            if w > maxWidth then maxWidth = w end
        end
        wraplimit = maxWidth
    end

    if not wraplimit and text then
        traw.textobj:set(text)
    elseif text then
        traw.textobj:setf(text, wraplimit, traw.align)
    end

    local w, h = traw.textobj:getDimensions()
    if not (textObj.shrinkWrap and traw.wraplimit and w < traw.wraplimit) then
        w = traw.wraplimit or w
    end
    textObj.width, textObj.height = w, h
end

local refont = function(textObj)
    textObj.raw.textobj:setFont(textObj.raw.font)
end

local newtext = function(textObj)
    textObj.raw.textobj = newText(textObj.raw.font, " ")

    reloadtext(textObj)
end

local isreload = {
    text = reloadtext,
    wraplimit = reloadtext,
    align = reloadtext,
    font = refont,
    textobj = newtext
}

local textmt = {
    __newindex = function(t, k, v)
        if isreload[k] then
            t.raw[k] = v
            isreload[k](t)
            return
        end
        rawset(t, k, v)
    end,
    __index = function(t, k)
        return t.raw and t.raw[k]
    end
}

local draw = function(textObj)
    if not textObj.isVisible then return end

    if textObj.animFunc then reloadtext(textObj) end
    
    local w, h, text
    if type(textObj.text) == "table" then
        local t = {}
        for i = 2, #textObj.text, 2 do
            t[i*0.5] = textObj.text[i]
        end
        text = table.concat(t)
        w = textObj.raw.font:getWidth(text)
        h = textObj.raw.font:getHeight()
    else
        text = textObj.raw.text
        w, h = textObj.textobj:getDimensions()
    end
    if not (textObj.shrinkWrap and textObj.wraplimit and w < textObj.wraplimit) then
        w = textObj.wraplimit or w
    end

    if textObj.animFunc then
        if not text then return end
        local font = textObj.raw.font
        local rawWraplimit = textObj.wraplimit
        local wraplimit = rawWraplimit and math.abs(rawWraplimit) or false
        local shrink = rawWraplimit and textObj.shrinkWrap
        local align = textObj.align

        local charColor
        if type(textObj.text) == "table" then
            charColor = {}
            local ci = 0
            local c = textObj.color
            for i = 1, #textObj.text do
                local v = textObj.text[i]
                if type(v) == "table" then
                    c = v
                else
                    for _ in utf8.codes(v) do
                        ci = ci + 1
                        charColor[ci] = c
                    end
                end
            end
        end

        local lineHeight = font:getHeight()
        local lines = {}
        local curLine = {chars = {}, width = 0}
        local cursorX = 0
        local maxLineWidth = 0
        local total = 0

        for _, code in utf8.codes(text) do
            total = total + 1
            local char = utf8.char(code)
            if char == "\n" then
                if #curLine.chars > 0 then
                    if curLine.width > maxLineWidth then maxLineWidth = curLine.width end
                    lines[#lines + 1] = curLine
                    curLine = {chars = {}, width = 0}
                end
                cursorX = 0
            else
                local cw = font:getWidth(char)
                if wraplimit and cursorX + cw > wraplimit and #curLine.chars > 0 then
                    if curLine.width > maxLineWidth then maxLineWidth = curLine.width end
                    lines[#lines + 1] = curLine
                    curLine = {chars = {}, width = 0}
                    cursorX = 0
                end
                curLine.chars[#curLine.chars + 1] = {char, cursorX, total}
                curLine.width = curLine.width + cw
                cursorX = cursorX + cw
            end
        end
        if #curLine.chars > 0 then
            if curLine.width > maxLineWidth then maxLineWidth = curLine.width end
            lines[#lines + 1] = curLine
        end

        local origW
        if shrink and maxLineWidth < wraplimit then
            origW = maxLineWidth
        else
            origW = wraplimit or maxLineWidth
        end
        local origH = lineHeight * #lines

        textObj.textobj:clear()
        love.graphics.setColor(textObj.color)

        local curY = 0
        for _, line in ipairs(lines) do
            local lineX = 0
            if align == "center" then
                lineX = (origW - line.width) / 2
            elseif align == "right" then
                lineX = origW - line.width
            end

            for _, entry in ipairs(line.chars) do
                local char, baseX, idx = entry[1], entry[2], entry[3]
                local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10 = textObj.animFunc(char, idx, total)

                local printArg = char
                local xOff, yOff, rot, sx, sy, ox, oy, kx, ky

                if type(r1) == "number" then
                    xOff, yOff = r1, r2 or 0
                    rot, sx, sy = r3, r4, r5
                    ox, oy, kx, ky = r6, r7, r8, r9
                else
                    if r1 then printArg = r1 end
                    xOff, yOff = r2 or 0, r3 or 0
                    rot, sx, sy = r4, r5, r6
                    ox, oy, kx, ky = r7, r8, r9, r10
                end

                if charColor and type(printArg) == "string" then
                    local c = charColor[idx]
                    printArg = {{c[1], c[2], c[3], c[4]}, printArg}
                end

                textObj.textobj:add(printArg,
                    baseX + lineX + xOff, curY + yOff,
                    rot or 0, sx or 1, sy or 1,
                    ox or 0, oy or 0, kx or 0, ky or 0)
            end
            curY = curY + lineHeight
        end

        w, h = origW, origH
    end

    love.graphics.setColor(textObj.color)
    
    love.graphics.draw(
        textObj.textobj,
        textObj.x,
        textObj.y,
        textObj.rotation,
        textObj.xScale, textObj.yScale,
        w*textObj.anchorX,
        h*textObj.anchorY
    )
end


local M = {}
M.new = function(self, text, font, x, y, wraplimit, align)
    x, y = x or 0, y or x or 0
    wraplimit = wraplimit or false
    align = align or "center"
    
    local textObj = setmetatable({
        raw = {
            text = text,
            wraplimit = wraplimit,
            align = align,
            font = font
        },
        x = x,
        y = y,
        anchorX = 0,
        anchorY = 0,
        xScale = 1,
        yScale = 1,
        rotation = 0,
        color = {1, 1, 1, 1},
        isVisible = true,
        animFunc = nil,
        shrinkWrap = false,

        draw = draw,
        setAnimation = setAnimation
    }, textmt)
    newtext(textObj)

    return textObj
end

return M