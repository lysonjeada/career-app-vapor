import Vapor

enum AppController {
    case leaf(LeafInterviewController)
    case api(APIInterviewController)

    func boot(routes: RoutesBuilder) {
        switch self {
        case .leaf(let leafController):
            routes.get("/", use: leafController.index)
            routes.post("products", use: leafController.create)
            routes.get("products", ":productID", "edit", use: leafController.edit)
            routes.post("products", ":productID", "edit", use: leafController.update)
            routes.post("products", ":productID", "delete", use: leafController.delete)
        
        case .api(let apiController):
            routes.get("api", "products", use: apiController.index)
            routes.post("api", "products", use: apiController.create)
            routes.get("api", "products", ":productID", use: apiController.view)
            routes.put("api", "products", ":productID", use: apiController.update)
            routes.delete("api", "products", ":productID", use: apiController.delete)
        }
    }
}
