import Vapor

final class ArticlesController {
    func fetchSimplifiedArticles(req: Request) async throws -> [SimplifiedArticle] {
        // URL da API externa
        let url = URI(string: "https://dev.to/api/articles")
        
        // Realizar a requisição
        let clientResponse = try await req.client.get(url)
        
        // Validar a resposta
        guard clientResponse.status == .ok else {
            throw Abort(.badRequest, reason: "Erro ao buscar artigos da API externa.")
        }
        
        // Decodificar os artigos completos
        let articles = try clientResponse.content.decode([Article].self)
        
        // Mapear para o modelo simplificado
        return articles.map { article in
            SimplifiedArticle(
                id: article.id,
                title: article.title,
                description: article.description
            )
        }
    }
}

// Modelo completo da API externa
struct Article: Decodable {
    let id: Int
    let title: String
    let description: String
    let readable_publish_date: String
    let url: String
    let cover_image: String?
    let user: User
}

struct User: Decodable {
    let name: String
    let profile_image: String
}
