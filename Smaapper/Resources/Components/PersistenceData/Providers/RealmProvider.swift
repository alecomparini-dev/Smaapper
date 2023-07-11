//
//  RealmProvider.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//

import RealmSwift
import Realm
import Foundation


/*
 1 - tudo que for gravar usar o ID do usuário
 2 - Para pegar o arquivo do Realm (Realm.Configuration.defaultConfiguration.fileURL)
 */

class RealmProvider<Entity: Object>: Provider<Entity>
        where Entity: Identifiable<UUID> {
    
    private(set) var realm: Realm
    
    override init() throws {
        self.realm = try Realm()
    }
    
    
//  MARK: - METHODS PROTOCOL PersistenceDataProtocol(Inheritance Provider)
    
    override func insert(_ entity: Entity) async throws -> UUID {
        do {
            try self.realm.write {
                self.realm.add(entity)
            }
        } catch let error {
            throw RealmError.write(error: error.localizedDescription)
        }
        return entity.id
    }
    
    override func update(_ entity: Entity) async throws {
        fatalError("The method update, needs to be implemented by the subclasses ")
    }
    
    override func delete(_ entity: Entity) async throws {
        fatalError("The method delete, needs to be implemented by the subclasses ")
    }
        
    override func fetch() async throws -> [Entity] {
        return try await withCheckedThrowingContinuation { continuation in
            let results = realm.objects(Entity.self)
            let entities = Array(results)
            continuation.resume(returning: entities)
        }
    }

    override func findBy(id: Any) async throws -> Entity {
        fatalError("The method findBy, needs to be implemented by the subclasses ")
    }
    
    
}


