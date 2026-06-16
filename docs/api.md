# API Reference

## Text:new

`Text:new(text, font, x, y, wraplimit, align)` → Text

Creates a new Text object.

### Arguments

| Name | Type | Default | Description |
|---|---|---|---|
| text | string / table | — | Text content. Plain string or colored text table. |
| font | Font | — | LÖVE Font object. |
| x | number | 0 | X position. |
| y | number | x | Y position. Defaults to x if omitted. |
| wraplimit | number / false | false | Maximum width in pixels before wrapping. |
| align | string | "center" | Text alignment: "left", "center", or "right". |

### Returns

| Type | Description |
|---|---|
| Text | The new Text object. |

### Examples

```lua
local Text = require("text")

local t = Text:new("Hello", font, 100, 200)
local t2 = Text:new("Wrapped text", font, 100, 300, 250, "left")
```

## Text:draw

`:draw() → nil`

Renders the text at the current position with its current properties.

### Arguments

None.

### Examples

```lua
t:draw()
```

## Text:setAnimation

`:setAnimation(anim, ...) → nil`

Sets a per-character animation function.

### Arguments

| Name | Type | Description |
|---|---|---|
| anim | function / string / nil | Animation function, built-in name, or nil to clear. |
| ... | vararg | Arguments passed to the built-in animation constructor. |

### Built-in Animations

"sine" — Sine wave vertical bounce.

Extra arguments: `amplitude`, `speed`, `phaseOffset`. Defaults: `5`, `3`, `0.5`.

### Examples

```lua
-- Built-in sine animation
t:setAnimation("sine", 5, 3, 0.5)

-- Custom animation function
t:setAnimation(function(char, index, total)
    local y = 5 * math.sin(love.timer.getTime() * 3 + index * 0.5)
    return 0, y
end)

-- Clear animation
t:setAnimation(nil)
```

## Properties

### text

`string` or `table` — The text content.

- **string**: Plain text rendered in a single color.
- **table**: Colored text using LÖVE's native `{{r,g,b,a}, text}` format.

Changing this property reloads the internal text object.

### font

`Font` — The LÖVE Font object.

Changing this updates the internal text object's font.

### x, y

`number` — Position of the text on screen. Default: `0, 0`.

### wraplimit

`number` or `false` — Maximum width in pixels before wrapping.

If `false`, text flows in a single line. Setting this reloads the internal text object.

### align

`string` — Text alignment. Default: `"center"`.

- `"left"` — Left-aligned.
- `"center"` — Centered within the wraplimit.
- `"right"` — Right-aligned within the wraplimit.

### anchorX, anchorY

`number` — Origin point for positioning and rotation. Default: `0, 0`.

The anchor is relative to the text's width and height:
- `0, 0` — Top-left.
- `0.5, 0.5` — Center.
- `1, 1` — Bottom-right.

### xScale, yScale

`number` — Scale factors. Default: `1, 1`.

Negative values flip the text.

### rotation

`number` — Rotation in radians. Default: `0`.

### color

`table` — Tint color `{r, g, b, a}`. Default: `{1, 1, 1, 1}`.

For colored text (table format), this color is multiplied per-character.

### isVisible

`boolean` — Whether to draw the text. Default: `true`.

### shrinkWrap

`boolean` — If `true` and the actual text width is narrower than `wraplimit`, the text box shrinks to fit the content. Default: `false`.

### width, height

`number` — Read-only cached dimensions, updated after each reload.

### animFunc

`function` or `nil` — The current animation function. Set via `:setAnimation()`.
