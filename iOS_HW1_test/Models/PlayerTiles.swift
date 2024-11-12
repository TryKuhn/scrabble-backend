import Foundation

final class PlayerTiles {
    var tiles: [String] = []
    var tileBag: TileBag
    
    
    init(tiles: [String], tileBag: TileBag) {
        // Инициализация плиток игрока и мешка с плитками
        self.tiles = tiles
        self.tileBag = tileBag
    }
    
    
    func addTile(_ tile: String) {
        // Добавляет плитку к личным плиткам игрока
        tiles.append(tile)
    }
}
