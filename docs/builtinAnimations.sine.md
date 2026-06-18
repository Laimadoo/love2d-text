Движение синусоидой по оси Y

## **Parameters**
`number amplitude`
- Максимальное расстояние от центра до которого колеблется символ в пикселях.

`number speed`
- Скорость колебаний

`number phaseOffset`
- На сколько смещается фаза колебания символа


## **Notes**
Вся формула: `amplitude * math.sin(time * speed + index * phaseOffset)`

Все встроенные анимации: [builtinAnimations](builtinAnimations.md)