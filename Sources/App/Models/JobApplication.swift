//
//  JobApplication.swift
//  career-app-vapor
//
//  Created by Amaryllis Baldrez on 24/01/25.
//

import Fluent
import Vapor

final class JobApplication: Model, Content {
    static let schema = "job_applications"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "company")
    var company: String

    @Field(key: "level")
    var level: String

    @OptionalField(key: "last_interview")
    var lastInterview: Date?

    @OptionalField(key: "next_interview")
    var nextInterview: Date?

    @Field(key: "technical_skills")
    var technicalSkills: [String]

    init() { }

    init(id: UUID? = nil, company: String, level: String, lastInterview: Date? = nil, nextInterview: Date? = nil, technicalSkills: [String]) {
        self.id = id
        self.company = company
        self.level = level
        self.lastInterview = lastInterview
        self.nextInterview = nextInterview
        self.technicalSkills = technicalSkills
    }
}
