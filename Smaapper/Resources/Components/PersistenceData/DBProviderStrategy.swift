//
//  DBProviderStrategy.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 11/07/23.
//

import Foundation


class DBProviderStrategy<T: Identifiable<UUID>>: PersistenceDataProtocol {
    typealias Entity = T
    
    init() throws { }
    
    func insert(_ entity: Entity) async throws -> UUID {
        fatalError("The method insert, needs to be implemented by the subclasses ")
    }
    
    func update(_ entity: Entity) async throws {
        fatalError("The method update, needs to be implemented by the subclasses ")
    }

    func delete(_ entity: Entity) async throws {
        fatalError("The method delete, needs to be implemented by the subclasses ")
    }

    func fetch() async throws -> [Entity] {
        fatalError("The method fetch, needs to be implemented by the subclasses ")
    }

    func findByID(_ id: UUID) async throws -> Entity? {
        fatalError("The method findByID, needs to be implemented by the subclasses ")
    }

    func findByColumn<DataType>(column: String, value: DataType) async throws -> [Entity] {
        fatalError("The method findByCustomColumn, needs to be implemented by the subclasses ")
    }
}
