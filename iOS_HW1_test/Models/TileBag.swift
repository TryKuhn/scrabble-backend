import Foundation

struct Tile {
    let letter: String
    let value: Int
}

final class TileBag {
    // Словарь, где ключ - буква, а значение - количество и очки
    // Пример: "A": (9, 1) означает 9 букв "A" с ценой 1 очко
    let tileDistribution: [String: (count: Int, value: Int)] = [
        "A": (9, 1), "B": (2, 3), "C": (2, 3), "D": (4, 2), "E": (12, 1),
        "F": (2, 4), "G": (3, 2), "H": (2, 4), "I": (9, 1), "J": (1, 8),
        "K": (1, 5), "L": (4, 1), "M": (2, 3), "N": (6, 1), "O": (8, 1),
        "P": (2, 3), "Q": (1, 10), "R": (6, 1), "S": (4, 1), "T": (6, 1),
        "U": (4, 1), "V": (2, 4), "W": (2, 4), "X": (1, 8), "Y": (2, 4),
        "Z": (1, 10), " ": (2, 0) // Пустые плитки (2 плитки, 0 очков)
    ]
    
    private var tiles: [Tile] = []
    
    init() {
        // Инициализирую мешок и добавляю плитки
        for (letter, details) in tileDistribution {
            for _ in 0..<details.count {
                tiles.append(Tile(letter: letter, value: details.value))
            }
        }
        
        // Перемешиваю плитки
        tiles.shuffle()
    }
    
    var tilesQuantity: Int {
        return tiles.count
    }
    
    // Вытянуть случайную плитку из мешка
    func pullOutTile() -> Tile? {
        guard !tiles.isEmpty else {
            print("Мешок пуст!")
            return nil
        }
        
        return tiles.removeLast()
    }
    
    func displayAllTiles() {
        print("Оставшиеся плитки:")
        for tile in tiles {
            print("\(tile.letter): \(tile.value) points")
        }
    }
}
