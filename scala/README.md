# Canvas

This is an Elixir implementation of this technical exercise. Here is an example -

```elixir
val c = canvas.Canvas(10, 10)
c.drawInCell(4, 8, canvas.Red)
c.drawInRow(1, 2, 9, canvas.Red)
c.drawInColumn(2, 1, 9, canvas.Red)
c.drawInRow(3, 3, 7, canvas.Red)
c.drawInRow(4, 3, 6, canvas.Green)
println(c.draw())
```

Gives this image -

![Before](before-example.png)

And `flood`ing cell row=2, column=2 with yellow -
```elixir
c.flood(2, 2, canvas.Yellow)
println(c.draw())
```

Gives this images -

![After](after-example.png)

Alternatively, run the following to output both the before and after example -

```sh
sbt run
```