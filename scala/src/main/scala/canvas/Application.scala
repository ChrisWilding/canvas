package canvas

object Application {
    def main(args: Array[String]): Unit = {
        val c = Canvas(10, 10)
        c.drawInCell(4, 8, Red)
        c.drawInRow(1, 2, 9, Red)
        c.drawInColumn(2, 1, 9, Red)
        c.drawInRow(3, 3, 7, Red)
        c.drawInRow(4, 3, 6, Green)
        println(c.draw())

        println()

        c.flood(2, 2, Yellow)
        println(c.draw())

    }
}
