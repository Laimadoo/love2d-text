Создаёт [текстовый](README.md) объект.

## Function
---
## **Synopsis**
```lua
text = Text:new(textstring, font, x, y, wraplimit, align)
```
## **Arguments**
`string textstring`
    Начальная текстовая строка, которую будет содержать новый объект. Может быть равно nil.
`Font font`
    Love2D шрифт, который будет использоваться для текста.
`number x`
    Положение по оси x.
`number y`
    Положение по оси y.
`number wraplimit`
    Максимальная ширина каждой строки в пикселях, после которой она автоматически переносится на новую строку.
`AlignMode align ("center")`
    Выравнивание
## **Returns**
`Text text`

## Function
---
## **Synopsis**
```lua
text = Text:new(coloredtext, font, x, y, wraplimit, align)
```
## **Arguments**

`table coloredtext`
    Таблица, содержащая цвета и строки для добавления к объекту, в виде {color1, string1, color2, string2, ...}.
    `table color1`
        Таблица, содержащая красный, зеленый, синий и необязательный альфа-канал, которые будут использоваться в качестве цветов для следующей строки в таблице в виде {красный, зеленый, синий, альфа}.
    `string string1`
        Строка текста, цвет которой определяется предыдущим цветом.
    `таблицы и строки ...`
        Дополнительные цвета и строки.
`Font font`
    Love2D шрифт, который будет использоваться для текста.
`number x`
    Положение по оси x.
`number y`
    Положение по оси y.
`number wraplimit`
    Максимальная ширина каждой строки в пикселях, после которой она автоматически переносится на новую строку.
`AlignMode align ("center")`
    Выравнивание
## **Returns**
`Text text`

## **Example**
```lua
local Text = require("text")
local font = love.graphics.getFont()

local text = Text:new("popabobra", font, 20, 20, nil, "right") -- текст без макс. ширины строки, выравнивается по правому краю

local coloredText = love.graphics.newTextBatch({{0, 1, 0}, "Laima", {1, 0, 0}, "doo"}, font, 20, 20, 500) -- текст с выравниванием по центру и макс. шириной 500
```
## **Notes**
Обратите внимание, что wraplimit влияет на ширину текста, от чего влияет на позицию текста с align. Что бы этого избежать используйте `shrinkWrap`

Так же важно знать, что scale внутри объекта не влияет на wraplimit.