//
//  PersistenceDataProtocol.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//


import Foundation


protocol PersistenceDataProtocol {
    associatedtype Entity: Identifiable<UUID>
    
    func insert(_ entity: Entity) async throws -> UUID
    func update(_ entity: Entity) async throws
    func delete(_ entity: Entity) async throws
    func fetch() async throws -> [Entity]
    func findByID(_ id: UUID) async throws -> Entity?
    func findByColumn<DataType>(column: String, value: DataType) async throws -> [Entity]
}





