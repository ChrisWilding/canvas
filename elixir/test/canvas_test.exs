defmodule CanvasTest do
  use ExUnit.Case
  doctest Canvas

  test "floods a canvas" do
    c1 = Canvas.new(10, 10)
    c2 = Canvas.draw_in_cell(c1, 4, 8, :blue)
    c3 = Canvas.draw_in_row(c2, 1, 2, 9, :blue)
    c4 = Canvas.draw_in_column(c3, 2, 1, 9, :blue)
    c5 = Canvas.draw_in_row(c4, 3, 3, 7, :blue)
    c6 = Canvas.draw_in_row(c5, 4, 3, 6, :green)
    c7 = Canvas.flood(c6, 2, 2, :yellow)

    assert Canvas.draw(c7) ==
             "\e[0m \e[43m \e[43m \e[43m \e[43m \e[43m \e[43m \e[43m \e[43m \e[0m \e[40m\n\e[0m \e[43m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[40m\n\e[0m \e[43m \e[43m \e[43m \e[43m \e[43m \e[43m \e[0m \e[0m \e[0m \e[40m\n\e[0m \e[43m \e[42m \e[42m \e[42m \e[42m \e[0m \e[44m \e[0m \e[0m \e[40m\n\e[0m \e[43m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[40m\n\e[0m \e[43m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[40m\n\e[0m \e[43m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[40m\n\e[0m \e[43m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[40m\n\e[0m \e[43m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[40m\n\e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[0m \e[40m"
  end
end
