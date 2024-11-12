import Foundation

final class GameBoard {
    private var board: [[String]] = Array(repeating: Array(repeating: "", count: 15), count: 15)

    func isValidPosition(x: Int, y: Int, length: Int) -> Bool {
        // Проверяет, что слово помещается в указанные координаты на доске
        return x >= 0 && y >= 0 && x + length <= 15 && y < 15
    }

    func placeWord(word: String, at position: (x: Int, y: Int)) -> Bool {
        // Размещает слово на доске, если оно в пределах границ
        guard isValidPosition(x: position.x, y: position.y, length: word.count) else {
            print("Ошибка: Слово выходит за границы доски.")
            return false
        }

        for (index, letter) in word.enumerated() {
            board[position.y][position.x + index] = String(letter)
        }
        print("Слово '\(word)' добавлено на доску.")
        return true
    }

    func displayBoard() -> [[String]] {
        // Возвращает текущее состояние доски
        return board
    }
}

