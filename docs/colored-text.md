# Colored Text

Colored text allows rendering individual characters or words in different colors within a single text object.

## Format

Assign a table to `text`:

```lua
t.text = {
    {r, g, b, a}, "string",
    {r, g, b, a}, "string",
    ...
}
```

Each pair is a color table followed by the text to render in that color.

## Examples

```lua
t.text = {
    {1, 0, 0, 1}, "Red ",
    {0, 1, 0, 1}, "Green ",
    {0, 0, 1, 1}, "Blue"
}
```

With multi-line:

```lua
t.text = {
    {0, 1, 1, 1}, "Cyan title\n",
    {1, 1, 1, 1}, "White body text"
}
```

## Color Override

The `color` property (tint) is multiplied with per-character colors. Set it to `{1, 1, 1, 1}` to show colors as-is.

```lua
t.color = {1, 1, 1, 1} -- passthrough
t.color = {0.5, 0.5, 0.5} -- dim all colors
```

## Animations

Colored text works with animations. When the animation rebuilds each character, the original colors from the colored table are preserved.

## Implementation Notes

- Color values are `{r, g, b, a}` with components in 0–1 range.
- The format uses LÖVE's native colored text syntax: `{{r,g,b,a}, text}`.
- Colored text disables auto-wraplimit calculation (which relies on plain string width).
