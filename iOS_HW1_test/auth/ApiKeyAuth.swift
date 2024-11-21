import Vapor

struct APIKeyAuthenticator: Middleware {
    private let apiKeyHeaderName = "ApiKey"

    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        guard let apiKeyValue = request.headers.first(name: apiKeyHeaderName) else {
            //if header is missing then return unauthorized 401
            return request.eventLoop.makeFailedFuture(
                Abort(.unauthorized, reason: "\(apiKeyHeaderName) header not found")
            )
        }
        
        // Пытаемся найти ApiKey в базе данных
        return ApiKey.find(UUID(apiKeyValue), on: request.db)
            .unwrap(or: Abort(.notFound, reason: "Invalid \(apiKeyHeaderName)."))
            .flatMapThrowing { apiKey in
                if let expiresAt = apiKey.expiresAt, expiresAt < Date() {
                    throw Abort(.forbidden, reason: "\(apiKeyHeaderName) has expired, please renew apiKey")
                }
            }
            .flatMap { _ in
                next.respond(to: request)
            }
    }
}
