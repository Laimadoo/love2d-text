# Text

A flexible text rendering object for LÖVE with support for colored text, per-character animation, text wrapping, anchoring, and shrink-to-fit behavior.

```lua
local Text = require("text")

local t = Text:new("Hello, world!", font, 400, 300)
t.anchorX = 0.5
t:draw()
```

## Constructor

| Constructor | Description |
|---|---|
| [Text:new](docs/api.md#textnew) | Creates a new Text object. |

## Functions

| Function | Description |
|---|---|
| [Text:draw](docs/api.md#textdraw) | Draws the text object. |
| [Text:setAnimation](docs/api.md#textsetanimation) | Sets a per-character animation function. |

## Properties

| Property | Type | Default | Description |
|---|---|---|---|
| text | string / table | — | Text content or colored text table. |
| font | Font | — | LÖVE Font object. |
| x, y | number | 0, 0 | Position. |
| wraplimit | number / false | false | Max width before wrapping. |
| align | string | "center" | "left", "center", or "right". |
| anchorX, anchorY | number | 0, 0 | Origin point (0-1). |
| xScale, yScale | number | 1, 1 | Scale. |
| rotation | number | 0 | Rotation in radians. |
| color | table | {1,1,1,1} | Tint color. |
| isVisible | boolean | true | Visibility toggle. |
| shrinkWrap | boolean | false | Fit width to content if narrower than wraplimit. |
| width, height | number | — | Read-only cached dimensions. |

## Documentation

- [API Reference](docs/api.md)
- [Colored Text](docs/colored-text.md)
- [Animations](docs/animations.md)

## License

MIT
