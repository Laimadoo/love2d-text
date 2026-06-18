Функция для анимирования символов в тексте. Устанавливается в [text:setAnimation()](Text.setAnimation.md)

## Function
---
## **Synopsis**
```lua
animation(char, index, total) return x, y, angle, sx, sy, ox, oy, kx, ky
```
## **Arguments**
`string char`
- Utf8 символ

`number index`
- Номер символа

`number total`
- Общее количество символов

## **Returns**
`number x (0)`
- Позиция символа по оси x.

`number y (0)`
- Позиция символа по оси y.

`number angle (0)`
- Ориентация символа (в радианах).

`number sx (1)`
- Коэффициент масштаба символа (ось X).

`number sy (sx)`
- Коэффициент масштаба символа (ось Y).

`number ox (0)`
- Смещение начала координат (ось X).

`number oy (0)`
- Смещение начала координат (ось Y)

`number kx (0)`
- Коэффициент сдвига/перекоса символа (ось X).

`number ky (0)`
- Коэффициент сдвига/перекоса символа (ось Y).


## **Example**
```lua
local Text = require("text")
local font = love.graphics.getFont()

local text = Text:new("popabobra", font, 20, 20)
text:setAnimation(function(char, index, total)
    local t = love.timer.getTime()
    
    local scale = (math.sin(t*2 + (index % 2)*math.pi) + 1)/4 + 0.5
    
    -- anchorX, anchorY = 50%
    local anchor = 0.5
    
    local w = font:getWidth(char)
    local h = font:getHeight(char)
    
    local x = -(w*scale - w)*anchor
    local y = -(h*scale - h)*anchor
    
    return x, y, 0, scale, scale
end)
```
## **Notes**
Обратите внимание при работе с масштабом, что anchor символов по умолчанию всегда 0 не зависимо от значений anchorX, anchorY объекта.

## **Synopsis**
```lua
animation(char, index, total) return newchar, x, y, angle, sx, sy, ox, oy, kx, ky
```
## **Arguments**
`string char`
- Utf8 символ

`number index`
- Номер символа

`number total`
- Общее количество символов

## **Returns**
`string newchar`
- Новый символ который заменит текущий.

`number x (0)`
- Позиция символа по оси x.

`number y (0)`
- Позиция символа по оси y.

`number angle (0)`
- Ориентация символа (в радианах).

`number sx (1)`
- Коэффициент масштаба символа (ось X).

`number sy (sx)`
- Коэффициент масштаба символа (ось Y).

`number ox (0)`
- Смещение начала координат (ось X).

`number oy (0)`
- Смещение начала координат (ось Y)

`number kx (0)`
- Коэффициент сдвига/перекоса символа (ось X).

`number ky (0)`
- Коэффициент сдвига/перекоса символа (ось Y).


## **Example**
```lua
local Text = require("text")
local font = love.graphics.getFont()

local text = Text:new("secret", font, 20, 20)

local randomChars = "QWERTYUIOPASDFGHJKLZXCVBNM;%#!?/"

text:setAnimation(function(char, index, total)
    local t = love.timer.getTime()
    local i = math.floor(t * 30 + index*3) % #randomChars + 1
    return randomChars:sub(i, i)
end)
```
## **Notes**
Обратите внимание, что позиция следующих симаолоа не меняется, по этому могут накладываться друг на друга.
Цвет установленный через coloredtext {rgba1, string1, ...} остаётся после изменения символа.

## **Synopsis**
```lua
animation(char, index, total) return coloredchar, x, y, angle, sx, sy, ox, oy, kx, ky
```
## **Arguments**
`string coloredchar`
- Таблица, содержащая цвета и строки для добавления к объекту, в виде {color1, string1, color2, string2, ...}.

    `table color1`
    - Таблица, содержащая красный, зеленый, синий и необязательный альфа-канал, которые будут использоваться в качестве цветов для следующей строки в таблице в виде {красный, зеленый, синий, альфа}.

    `string string1`
    - Строка текста, цвет которой определяется предыдущим цветом.

    `таблицы и строки ...`
    - Дополнительные цвета и строки.

`number index`
- Номер символа

`number total`
- Общее количество символов

## **Returns**
`string newchar`
- Новый символ который заменит текущий.

`number x (0)`
- Позиция символа по оси x.

`number y (0)`
- Позиция символа по оси y.

`number angle (0)`
- Ориентация символа (в радианах).

`number sx (1)`
- Коэффициент масштаба символа (ось X).

`number sy (sx)`
- Коэффициент масштаба символа (ось Y).

`number ox (0)`
- Смещение начала координат (ось X).

`number oy (0)`
- Смещение начала координат (ось Y)

`number kx (0)`
- Коэффициент сдвига/перекоса символа (ось X).

`number ky (0)`
- Коэффициент сдвига/перекоса символа (ось Y).


## **Example**
```lua
local Text = require("text")
local font = love.graphics.getFont()

local text = Text:new("rgb backlight", font, 20, 20)
text:setAnimation(function(char, index, total)
    local t = love.timer.getTime()
    local r = 0.5 + 0.5 * math.sin(t * 2 + index * 0.5)
    local g = 0.5 + 0.5 * math.sin(t * 2 + index * 0.5 + 2.1)
    local b = 0.5 + 0.5 * math.sin(t * 2 + index * 0.5 + 4.2)
    return {{r, g, b}, char}
end)
```