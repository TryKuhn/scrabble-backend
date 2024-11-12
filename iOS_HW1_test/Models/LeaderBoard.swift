import Foundation

final class Leaderboard {
    private var players: [Player] = []

    func addPlayer(_ player: Player) {
        // Добавляет игрока, если его еще нет в таблице лидеров
        if players.contains(where: { $0.nickname == player.nickname }) {
            print("⚠️ Игрок с ником \(player.nickname) уже существует.")
        } else {
            players.append(player)
            print("✅ Игрок \(player.nickname) добавлен.")
        }
    }

    func updatePoints(for nickname: String, points: Int) {
        // Обновляет очки для игрока с указанным ником
        if let index = players.firstIndex(where: { $0.nickname == nickname }) {
            players[index].points += points
            print("✅ Игроку \(nickname) добавлено \(points) очков. Всего очков: \(players[index].points)")
        } else {
            print("⚠️ Игрок \(nickname) не найден.")
        }
    }

    func getLeaderboard() -> [Player] {
        // Возвращает список игроков, отсортированный по очкам
        return players.sorted(by: { $0.points > $1.points })
    }
}

