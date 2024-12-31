import Fluent
import Vapor

struct LeafInterviewController {
    func index(req: Request) async throws -> View {
        // Obter todos os produtos do banco de dados
        let interviews = try await Interview.query(on: req.db).all()
        let context = ["interviews": interviews]
        // Renderizar a view "index" com o contexto
        return try await req.view.render("index", context)
    }

    func create(req: Request) async throws -> Response {
        // Decodificar o objeto enviado no corpo da requisição
        let interview = try req.content.decode(Interview.self)
        // Salvar no banco de dados
        try await interview.save(on: req.db)
        // Redirecionar para a página inicial
        return req.redirect(to: "/")
    }

    func edit(req: Request) async throws -> View {
        // Obter o ID do parâmetro da rota
        let interviewID = try req.parameters.require("interviewID", as: UUID.self)
        // Procurar o produto no banco de dados
        guard let interview = try await Interview.find(interviewID, on: req.db) else {
            throw Abort(.notFound)
        }
        // Renderizar a view "edit" com os dados do produto
        return try await req.view.render("edit", ["interview": interview])
    }

    func update(req: Request) async throws -> Response {
        // Obter o ID do parâmetro da rota
        let interviewID = try req.parameters.require("interviewID", as: UUID.self)
        // Decodificar o objeto enviado no corpo da requisição
        let updatedInterview = try req.content.decode(Interview.self)
        // Procurar o produto no banco de dados
        guard let interview = try await Interview.find(interviewID, on: req.db) else {
            throw Abort(.notFound)
        }
        // Atualizar os valores do produto
        interview.name = updatedInterview.name
        interview.date = updatedInterview.date
        // Salvar as mudanças no banco de dados
        try await interview.save(on: req.db)
        // Redirecionar para a página inicial
        return req.redirect(to: "/")
    }

    func delete(req: Request) async throws -> Response {
        // Obter o ID do parâmetro da rota
        let interviewID = try req.parameters.require("interviewID", as: UUID.self)
        // Procurar o produto no banco de dados
        guard let interview = try await Interview.find(interviewID, on: req.db) else {
            throw Abort(.notFound)
        }
        // Deletar o produto do banco de dados
        try await interview.delete(on: req.db)
        // Redirecionar para a página inicial
        return req.redirect(to: "/")
    }
}
