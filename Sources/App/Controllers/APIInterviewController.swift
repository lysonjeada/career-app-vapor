import Vapor
import Fluent

struct APIInterviewController {
    func index(req: Request) async throws -> [Interview] {
        try await Interview.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Interview {
        let product = try await req.content.decode(Interview.self)
        try await product.save(on: req.db)
        return product
    }

    func view(req: Request) async throws -> Interview {
        guard let product = try await Interview.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return product
    }

    func update(req: Request) async throws -> Interview {
        let productID = try req.parameters.require("productID", as: UUID.self)
        let updatedProduct = try await req.content.decode(Interview.self)
        guard var product = try await Interview.find(productID, on: req.db) else {
            throw Abort(.notFound)
        }
        product.name = updatedProduct.name
        product.date = updatedProduct.date
        try await product.save(on: req.db)
        return product
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let product = try await Interview.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return .ok
    }
}
