//
//  CreateJobApplication.swift
//  career-app-vapor
//
//  Created by Amaryllis Baldrez on 24/01/25.
//

import Fluent
import Vapor

struct CreateJobApplication: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("job_applications")
            .id()
            .field("company", .string, .required)
            .field("level", .string, .required)
            .field("last_interview", .date)
            .field("next_interview", .date)
            .field("technical_skills", .array(of: .string), .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("job_applications").delete()
    }
}

