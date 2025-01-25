import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import Leaf

// configures your application

public func configure(_ app: Application) throws {
    // Recupera a senha do banco de dados das variáveis de ambiente
    guard let password = Environment.get("DATABASE_PASSWORD") else {
        fatalError("DATABASE_PASSWORD não configurado")
    }
    
    // Configuração da string de conexão com o banco de dados Postgres
    let databaseURL = "postgres://postgres:\(password)@localhost:5433/career_app_rails"
    
    // Configura o driver Postgres para Fluent
    app.databases.use(try .postgres(url: databaseURL), as: .psql)

    // Rota padrão
    app.get { req in
        return "Hello, Vapor!"
    }

    // Configurações adicionais, como migrações, middlewares, etc.
    try routes(app)
}


// public func configure(_ app: Application) async throws {
//     // uncomment to serve files from /Public folder
//     // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

//     app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
//         hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//         port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
//         username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//         password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//         database: Environment.get("DATABASE_NAME") ?? "vapor_database",
//         tls: .prefer(try .init(configuration: .clientDefault)))
//     ), as: .psql)

//     app.migrations.add(CreateTodo())

//     app.views.use(.leaf)


//     // register routes
//     try routes(app)
// }
