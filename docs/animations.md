# Animations

Per-character animation lets you move, rotate, scale, or replace individual characters over time.

## Setting an Animation

```lua
t:setAnimation(func)
t:setAnimation("sine", amplitude, speed, phaseOffset)
t:setAnimation(nil) -- clear
```

## Animation Function Signature

```lua
function(char, index, total) -> ... end
```

| Return | Type | Description |
|---|---|---|
| `char` (variant 1) | string | Replacement character (nil to keep original) |
| `xOffset` | number | Horizontal offset in pixels |
| `yOffset` | number | Vertical offset in pixels |
| `rotation` | number | Rotation offset in radians |
| `scaleX` | number | X scale |
| `scaleY` | number | Y scale |
| `originX` | number | Origin X offset |
| `originY` | number | Origin Y offset |
| `shearX` | number | Shear X |
| `shearY` | number | Shear Y |

**Variant 1 — numeric first return** (simplified offset only):

```lua
function(char, index, total)
    return xOffset, yOffset
end
```

**Variant 2 — string first return** (character replacement + full transform):

```lua
function(char, index, total)
    return replacementChar, xOffset, yOffset, rotation, scaleX, scaleY, originX, originY, shearX, shearY
end
```

## Built-in: "sine"

Sine wave vertical bounce:

```lua
t:setAnimation("sine", amplitude, speed, phaseOffset)
```

Defaults: `amplitude = 5`, `speed = 3`, `phaseOffset = 0.5`.

## With Colored Text

Animations preserve colored text colors automatically. Each character retains its original color when the animation rebuilds the text.

## Performance

Animations rebuild the internal LÖVE Text object every frame. Avoid animating large amounts of text at once.

## Example — Typewriter

```lua
t:setAnimation(function(char, index, total)
    local revealed = math.floor(love.timer.getTime() * 10)
    if index > revealed then
        return "" -- hide this character
    end
end)
```
