//
//  PersistenceDataBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//

import Foundation
import RealmSwift



class PersistenceDataBuilder<T>: PersistenceDataProtocol  {
    typealias Entity = T
    
    private var provider: Provider<T>
    
    init(provider: Provider<T>) {
        self.provider = provider
    }
    
    func insert(_ entity: Entity) async throws -> String {
        try await provider.insert(entity)
    }
    
    func update(_ entity: Entity) async throws {
        try await provider.update(entity)
    }
    
    func delete(_ entity: T) async throws {
        try await provider.delete(entity)
    }
    
    func fetch() async throws -> [T] {
        return try await provider.fetch()
    }

    func findBy(id: Any) async throws -> T {
        return try await provider.findBy(id: id)
    }

    
}


class WorldMap: Object {
    @Persisted var worldData: Data
}

class teste {
    
    init() {
        start()
    }
    
    func start() {
        
    }
    
    
}






