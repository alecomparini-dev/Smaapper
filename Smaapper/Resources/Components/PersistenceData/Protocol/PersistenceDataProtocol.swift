//
//  PersistenceDataProtocol.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//

import Foundation

protocol PersistenceData {
    associatedtype Entity

    func insert(_ model: Entity) async throws -> String
    func update(_ model: Entity) async throws
    func delete(_ model: Entity) async throws
    func fetch() async throws -> [Entity]
    func findBy(id: Any) async throws -> Entity
    
//    func findBy(customColumn: [T]) async throws -> [T]
}
