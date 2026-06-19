Устанавливает посимвольную анимацию [тексту](../README.md).

## Function
---
## **Synopsis**
```lua
text:setAnimation(animation)
```
## **Arguments**
`function animation`
- Функция которая будет вызываться для каждого символа. Вид animation(char, index, total). Подробнее в [animation](animation.md)

    `string char`
    - Utf8 символ

    `number index`
    - Номер символа

    `number total`
    - Общее количество символов

## **Returns**
Ничего

## Function
---
## **Synopsis**
```lua
text:setAnimation(name, params)
```
## **Arguments**
`string name`
- Имя встроенной анимации.

`table params`
- Таблица вида ключ-значение.

## **Returns**
Ничего

## **Example**
```lua
local Text = require("text")
local font = love.graphics.getFont()

local dotDiviter = Text:new(". . . . . . . . . . .", font, 20, 20)
dotDiviter:setAnimation("sine", {
    amplitude = 5,
    speed = 2,
    phaseOffset = 1
})

local win = Text:new("You win!", font, 20, 120)
win.color = {1,1,0.2,1}
win:setAnimation(function(char, index, total)
    local t = love.timer.getTime()
    local x = 8 * math.sin(t * 2 - index * 0.9)
    local y = 8 * math.cos(t * 2.5 - index * 0.6)
    local d = 1 - ((y + 8) / 32)
    
    return {{d, d, d}, char}, x, y
end)
```
## **Notes**
Подробнее о своих анимациях в [animation](animation.md)
Подробнее о встроенных анимациях в [builtinAnimations](builtinAnimations.md)
