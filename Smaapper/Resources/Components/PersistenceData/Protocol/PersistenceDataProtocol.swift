//
//  PersistenceDataProtocol.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//


import Foundation


protocol PersistenceDataProtocol {
    associatedtype Entity: Identifiable<UUID>
    
    func insert(_ entity: Entity) throws -> UUID
    func update(_ entity: Entity) throws
    func delete(_ entity: Entity) throws
    func fetch() throws -> [Entity]
    func findByID(_ id: UUID) throws -> Entity?
    func findByColumn<DataType>(column: String, value: DataType) throws -> [Entity]
}





