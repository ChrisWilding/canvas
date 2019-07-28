# Canvas

This is an Elixir implementation of this technical exercise. Here is an example -

```elixir
start = Canvas.new(10, 10)
        |> Canvas.draw_in_cell(4, 8, :blue)
        |> Canvas.draw_in_row(1, 2, 9, :blue)
        |> Canvas.draw_in_column(2, 1, 9, :blue)
        |> Canvas.draw_in_row(3, 3, 7, :blue)
        |> Canvas.draw_in_row(4, 3, 6, :green)
        |> Canvas.draw()
        |> IO.puts()
```

Gives this image -

![Before](before-example.png)

And `flood`ing cell row=2, column=2 with yellow -
```elixir
start =
  |> Canvas.flood(2, 2, :yellow)
  |> Canvas.draw()
  |> IO.puts()
```

Gives this images -

![After](after-example.png)
