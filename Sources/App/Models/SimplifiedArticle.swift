import Vapor

struct SimplifiedArticle: Content {
    let id: Int
    let title: String
    let description: String
}
