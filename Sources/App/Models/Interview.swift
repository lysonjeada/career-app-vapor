import Fluent
import Vapor

final class Interview: Model, Content, @unchecked Sendable {
    static let schema = "interviews"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "date")
    var date: String

    init() { }

    init(id: UUID? = nil, name: String, date: String) {
        self.id = id
        self.name = name
        self.date = date
    }
}

