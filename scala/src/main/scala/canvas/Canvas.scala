package canvas

import scala.collection.mutable

sealed trait Colour
case object Black extends Colour
case object Red extends Colour
case object Yellow extends Colour
case object Green extends Colour

case class Canvas(cells: mutable.Map[(Int, Int), Colour], rowCount: Int, columnCount: Int) {
    def drawInCell(row: Int, column: Int, colour: Colour) =
        cells.put(row -> column, colour)

    def drawInRow(row: Int, fromColumn: Int, toColumn: Int, colour: Colour) =
        fromColumn.to(toColumn).foldLeft(cells) {
            case (cells, column) => {
                cells.put(row -> column, colour)
                cells
            }
        }

    def drawInColumn(column: Int, fromRow: Int, toRow: Int, colour: Colour) =
        fromRow.to(toRow).foldLeft(cells) {
            case (cells, row) => {
                cells.put(row -> column, colour)
                cells
            }
        }

    def flood(row: Int, column: Int, colour: Colour) = {
        val visited = Set.empty[(Int, Int)]
        val originalColour = cells.getOrElse(row -> column, Black)

        def doFlood(row: Int, column: Int, originalColour: Colour, newColour: Colour, visited: Set[(Int, Int)]): Set[(Int, Int)] = {
            if (visited.contains(row -> column) || !cells.get(row -> column).contains(originalColour)) {
                visited
            } else {
                val newVisited = visited + (row -> column)
                drawInCell(row, column, newColour)

                val adjacentCells = Seq(
                    (row - 1, column),
                    (row + 1, column),
                    (row, column - 1),
                    (row, column + 1)
                ).filter(inCanvas).filterNot(visited)

                adjacentCells.foldLeft(newVisited) { (memo, rowColumn) =>
                    doFlood(rowColumn._1, rowColumn._2, originalColour, colour, memo)
                }
            }
        }

        doFlood(row, column, originalColour, colour, visited)
    }

    def draw(): String =
        0.to(rowCount).map { row =>
            0.to(columnCount).map { column =>
                colourToAnsi(cells.getOrElse(row -> column, Black)) + " "
            }.mkString
        }.mkString(io.AnsiColor.RESET + "\n") + io.AnsiColor.RESET

    private def colourToAnsi(colour: Colour): String =
        colour match {
            case Black => io.AnsiColor.BLACK_B
            case Red => io.AnsiColor.RED_B
            case Green => io.AnsiColor.GREEN_B
            case Yellow => io.AnsiColor.YELLOW_B
        }

    private def inCanvas(rowColumn: (Int, Int)): Boolean = {
        val row = rowColumn._1
        val column = rowColumn._2
        row > 0 && row <= rowCount && column > 0 && column <= columnCount
    }
}

object Canvas {
    def apply(rowCount: Int, columnCount: Int): Canvas =
        Canvas(mutable.Map.empty, rowCount, columnCount)
}
