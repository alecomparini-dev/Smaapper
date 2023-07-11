//
//  PersistenceDataBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//

import Foundation
import RealmSwift


class PersistenceDataBuilder<Entity>: PersistenceDataProtocol  {
    typealias Entity = Entity
    
    private var provider: Provider<Entity>
    
    init(provider: Provider<Entity>) {
        self.provider = provider
    }
    
    func insert(_ entity: Entity) async throws -> UUID {
        return try await provider.insert(entity)
    }
    
    func update(_ entity: Entity) async throws {
        try await provider.update(entity)
    }
    
    func delete(_ entity: Entity) async throws {
        try await provider.delete(entity)
    }
    
    func fetch() async throws -> [Entity] {
        return try await provider.fetch()
    }

    func findBy(id: Any) async throws -> Entity {
        return try await provider.findBy(id: id)
    }

    
}


class WorldMapData: Object {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var environmentName: String
    @Persisted var worldMapData: Data
    
    convenience init(environmentName: String, worldMapData: Data) {
        self.init()
        self.environmentName = environmentName
        self.worldMapData = worldMapData
    }
}







