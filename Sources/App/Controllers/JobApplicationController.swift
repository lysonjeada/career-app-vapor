//
//  JobApplicationController.swift
//  career-app-vapor
//
//  Created by Amaryllis Baldrez on 24/01/25.
//

import Vapor

struct JobApplicationController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let jobApplications = routes.grouped("job-applications")
        jobApplications.get(use: getAll)
        jobApplications.post(use: create)
        jobApplications.delete(":id", use: delete)
    }

    func getAll(req: Request) throws -> EventLoopFuture<[JobApplication]> {
        JobApplication.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let jobApplication = try req.content.decode(JobApplication.self)
        return jobApplication.save(on: req.db).map { .created }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        JobApplication.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
