import Foundation

final class InviteCodeService {
    static func generateInviteCode() -> String {
        // Генерирует уникальный 6-символьный код для приглашений
        return UUID().uuidString.prefix(6).uppercased()
    }
}
