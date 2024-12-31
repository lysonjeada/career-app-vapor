import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) throws {
    app.databases.use(.postgres(
        hostname: "localhost",
        username: "vapor_user",
        password: "s3nh41404",
        database: "vapor_database"
    ), as: .psql)
    
    app.migrations.add(CreateInterview())

    app.views.use(.leaf)

    try routes(app)

    try app.autoMigrate().wait()
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
