//
//  PersistenceDataProtocol.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//

import RealmSwift
import Realm


protocol PersistenceDataProtocol {
    associatedtype Entity

    func insert(_ entity: Entity) async throws -> UUID
    func update(_ entity: Entity) async throws
    func delete(_ entity: Entity) async throws
    func fetch() async throws -> [Entity]
    func findBy(id: Any) async throws -> Entity
}



class Provider<T>: PersistenceDataProtocol {
    typealias Entity = T

    init() throws { }
    
    func insert(_ entity: T) async throws -> UUID {
        fatalError("The method insert, needs to be implemented by the subclasses ")
    }
    
    func update(_ entity: T) async throws {
        fatalError("The method update, needs to be implemented by the subclasses ")
    }
    
    func delete(_ entity: T) async throws {
        fatalError("The method delete, needs to be implemented by the subclasses ")
    }
    
    func fetch() async throws -> [T] {
        fatalError("The method fetch, needs to be implemented by the subclasses ")
    }
    
    func findBy(id: Any) async throws -> T {
        fatalError("The method findBy, needs to be implemented by the subclasses ")
    }
}



