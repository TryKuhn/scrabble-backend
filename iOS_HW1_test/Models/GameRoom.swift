final class GameRoom: Model, Content {
    static let schema = "game_rooms"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "inviteCode")
    var inviteCode: String

    @Field(key: "isPrivate")
    var isPrivate: Bool

    @Parent(key: "owner_id")
    var owner: User

    @Siblings(through: GameRoomPlayer.self, from: \.$room, to: \.$player)
    var players: [User]

    init() {}
    
    init(id: UUID? = nil, name: String, inviteCode: String, isPrivate: Bool, ownerID: UUID) {
        self.id = id
        self.name = name
        self.inviteCode = inviteCode
        self.isPrivate = isPrivate
        self.$owner.id = ownerID
    }
}
