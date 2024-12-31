import Fluent

struct CreateInterview: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("interviews")
            .id()
            .field("name", .string, .required)
            .field("date", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("interviews").delete()
    }
}