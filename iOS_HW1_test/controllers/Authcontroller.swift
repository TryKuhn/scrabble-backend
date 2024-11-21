import Vapor
import JWT
import Fluent

struct Authcontroller: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let authGroup = routes
            .grouped("auth")
            .protectedWithApiKey()

        authGroup.post("login", use: login)
        authGroup.post("register", use: register)
        authGroup.get("getUserById", ":userId", use: getUserById)
    }
    
    func login(_ req: Request) async throws -> String {
        let credentials = try req.content.decode(UserCredentials.self)
        let user = try await authenticate(credentials: credentials, on: req)
        
        let token = try TokensHelper.createAccessToken(from: user, signers: req.application.jwt.signers)
        return token
    }

    private func authenticate(credentials: UserCredentials, on req: Request) async throws -> User {
        guard let user = try await User.query(on: req.db)
            .filter(\.$nickName == credentials.nickName)
            .first()
            .get() else {
            throw Abort(.unauthorized, reason: "User not found.")
        }
     
        guard user.password == credentials.password else {
            throw Abort(.unauthorized, reason: "Incorrect password.")
        }

        return user
    }

    func register(_ req: Request) async throws -> UserRegistrationResponse {
        let credentials = try req.content.decode(UserCredentials.self)
        if try await User.query(on: req.db)
            .filter(\.$nickName == credentials.nickName)
            .first()
            .get() != nil {
            throw Abort(.badRequest, reason: "User already exists.")
        }
        let newUser = User(nickName: credentials.nickName, password: credentials.password)
        try await newUser.save(on: req.db).get()

        return UserRegistrationResponse(id: newUser.id?.uuidString ?? "")
    }
    
    func getUserById(_ req: Request) async throws -> User {
        guard let userIdString = req.parameters.get("userId"),
              let userId = UUID(uuidString: userIdString) else {
            throw Abort(.badRequest, reason: "Invalid user ID.")
        }
        
        guard let user = try await User.query(on: req.db)
            .filter(\.$id == userId)
            .first()
            .get() else {
            throw Abort(.notFound, reason: "User not found.")
        }
        
        return user
    }
}

struct UserCredentials: Content {
    let nickName: String
    let password: String
}


struct UserRegistrationResponse: Content {
    let id: String
}
