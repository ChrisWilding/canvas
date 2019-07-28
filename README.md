This is a technical exercise to implement the API detailed below. This repository contains both an Elixir and Scala implementation. See their respective READMEs for examples.

* [Elixir](./elixir/README.md)
* [Scala](./scala/README.md)

1. Implement a `new` function that creates a new canvas with a given number of rows and columns

```
new(rowCount, columnCount)
```

2. Implement a `drawInCell` function that fills in a row and column with a colour

```
drawInCell(row, column, colour)
```

3. Implement a `drawInRow` function that fills in a row from one column to another with a colour

```
drawInRow(row, fromColumn, toColumn, colour)
```

3. Implement a `drawInColumn` function that fills in a column from one row to another with a colour

```
drawInColumn(column, fromRow, toRow, colour)
```

4. Implement a `flood` function that fills a cell with a colour, and recursively fills all cells above, below, to the left and to the right that are the same colour as the original cell. If the colour is different to the original cell then do not change it. If the cell is diagonally adjacent then do not change it.

```
flood(column, row, colour)
```