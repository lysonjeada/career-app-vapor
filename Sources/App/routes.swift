import Fluent
import Vapor

func routes(_ app: Application) throws {
    // app.get { req async throws in
    //     try await req.view.render("index", ["title": "Hello Vapor!"])
    // }

    // app.get("hello") { req async -> String in
    //     "Hello, world!"
    // }

    // try app.register(collection: TodoController())


    // let articlesController = ArticlesController()
    
    // app.get("api", "articles", use: articlesController.fetchSimplifiedArticles)

    let leafController = LeafInterviewController()
    let apiController = APIInterviewController()

    // Use the AppController enum to configure routes
    AppController.leaf(leafController).boot(routes: app.routes)
    AppController.api(apiController).boot(routes: app.routes)
}

