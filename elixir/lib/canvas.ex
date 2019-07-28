defmodule Canvas do
  @colour_to_ansi_fn %{
    black: &IO.ANSI.black_background/0,
    blue: &IO.ANSI.blue_background/0,
    cyan: &IO.ANSI.cyan_background/0,
    green: &IO.ANSI.green_background/0,
    light_black: &IO.ANSI.light_black_background/0,
    light_blue: &IO.ANSI.light_blue_background/0,
    light_cyan: &IO.ANSI.light_cyan_background/0,
    light_green: &IO.ANSI.light_green_background/0,
    light_magenta: &IO.ANSI.light_magenta_background/0,
    light_red: &IO.ANSI.light_red_background/0,
    light_white: &IO.ANSI.light_white_background/0,
    light_yellow: &IO.ANSI.light_yellow_background/0,
    magenta: &IO.ANSI.magenta_background/0,
    red: &IO.ANSI.red_background/0,
    white: &IO.ANSI.white_background/0,
    yellow: &IO.ANSI.yellow_background/0
  }
  @allowed_colours Map.keys(@colour_to_ansi_fn)
  @default_colour :red

  @typep cells_t :: %{optional({pos_integer, pos_integer}) => atom}
  @type t :: %Canvas{cells: cells_t, row_count: pos_integer, column_count: pos_integer}
  defstruct cells: %{}, row_count: 0, column_count: 0

  defguardp in_canvas?(row_count, column_count, row, column)
            when row > 0 and row <= row_count and column > 0 and
                   column <= column_count

  defguardp allow_colour?(colour) when colour in @allowed_colours

  @spec new(pos_integer, atom) :: Canvas.t()
  def new(row_count, column_count) do
    %Canvas{row_count: row_count, column_count: column_count}
  end

  @spec draw_in_cell(Canvas.t(), pos_integer, pos_integer, atom) :: Canvas.t()
  def draw_in_cell(
        %Canvas{cells: cells, row_count: row_count, column_count: column_count} = canvas,
        row,
        column,
        colour
      )
      when in_canvas?(row_count, column_count, row, column) and
             allow_colour?(colour) do
    new_cells = Map.put(cells, {row, column}, colour)
    %{canvas | cells: new_cells}
  end

  @spec draw_in_row(Canvas.t(), pos_integer, pos_integer, pos_integer, atom) :: Canvas.t()
  def draw_in_row(
        %Canvas{row_count: row_count, column_count: column_count} = canvas,
        row,
        from_column,
        to_column,
        colour
      )
      when in_canvas?(row_count, column_count, row, from_column) and
             in_canvas?(row_count, column_count, row, to_column) and
             allow_colour?(colour) do
    from_column..to_column
    |> Enum.reduce(canvas, fn column, canvas -> draw_in_cell(canvas, row, column, colour) end)
  end

  @spec draw_in_column(Canvas.t(), pos_integer, pos_integer, pos_integer, atom) :: Canvas.t()
  def draw_in_column(
        %Canvas{row_count: row_count, column_count: column_count} = canvas,
        column,
        from_row,
        to_row,
        colour
      )
      when in_canvas?(row_count, column_count, from_row, column) and
             in_canvas?(row_count, column_count, to_row, column) and allow_colour?(colour) do
    from_row..to_row
    |> Enum.reduce(canvas, fn row, canvas -> draw_in_cell(canvas, row, column, colour) end)
  end

  @spec flood(Canvas.t(), pos_integer, pos_integer, atom) :: Canvas.t()
  def flood(
        %Canvas{row_count: row_count, column_count: column_count} = canvas,
        row,
        column,
        new_colour
      )
      when in_canvas?(row_count, column_count, row, column) and allow_colour?(new_colour) do
    visited = MapSet.new()
    original_colour = Map.get(canvas.cells, {row, column})
    {new_canvas, _} = flood(canvas, row, column, original_colour, new_colour, visited)
    new_canvas
  end

  defp flood(
         %Canvas{cells: cells, row_count: row_count, column_count: column_count} = canvas,
         row,
         column,
         original_colour,
         new_colour,
         visited
       )
       when in_canvas?(row_count, column_count, row, column) and allow_colour?(new_colour) do
    if Map.get(cells, {row, column}) !== original_colour do
      {canvas, visited}
    else
      new_visited = MapSet.put(visited, {row, column})
      new_canvas = draw_in_cell(canvas, row, column, new_colour)

      next_cells =
        [
          {row - 1, column},
          {row + 1, column},
          {row, column - 1},
          {row, column + 1}
        ]
        |> Enum.filter(&(!MapSet.member?(new_visited, &1)))
        |> Enum.filter(fn {row, column} -> in_canvas?(row_count, column_count, row, column) end)

      Enum.reduce(next_cells, {new_canvas, new_visited}, fn {next_row, next_column},
                                                            {new_canvas, new_visited} ->
        flood(new_canvas, next_row, next_column, original_colour, new_colour, new_visited)
      end)
    end
  end

  def draw(%Canvas{cells: cells, row_count: row_count, column_count: column_count}) do
    1..row_count
    |> Enum.map(&draw_columns(cells, column_count, &1))
    |> Enum.join(IO.ANSI.black_background() <> "\n")
    |> Kernel.<>(IO.ANSI.black_background())
  end

  defp draw_columns(cells, column_count, row) do
    Enum.map(1..column_count, &draw_cell(cells, row, &1))
    |> Enum.join()
  end

  defp draw_cell(cells, row, column) do
    colour = Map.get(cells, {row, column}, @default_colour)
    colour_fn = Map.get(@colour_to_ansi_fn, colour)
    colour_fn.() <> " "
  end
end
