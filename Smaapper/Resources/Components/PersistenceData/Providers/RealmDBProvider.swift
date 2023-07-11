//
//  RealmDBProvider.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//

import RealmSwift


class RealmDBProvider<T: Identifiable<UUID>>: DBProviderStrategy<T>
where T: Object {
    typealias Entity = T
    
    private(set) var realm: Realm
    
    override init() throws {
        self.realm = try Realm()
    }

    
//  MARK: - GET AREA
    func getFileRealm() -> String {
        if let fileRealm = Realm.Configuration.defaultConfiguration.fileURL{
            return String(describing: fileRealm)
        }
        return ""
    }
    
    
//  MARK: - METHODS PROTOCOL PersistenceDataProtocol(Inheritance Provider)
    
    override func insert(_ entity: Entity) async throws -> UUID {
        try self.realm.write {
            self.realm.add(entity)
        }
        return entity.id
    }
    
    override func update(_ entity: Entity) async throws {
        try realm.write {
            realm.add(entity, update: .modified)
        }
    }

    override func delete(_ entity: Entity) async throws {
        try realm.write {
            realm.delete(entity)
        }
    }

    override func fetch() async throws -> [Entity] {
        let results = realm.objects(Entity.self)
        return Array(results)
    }

    override func findByID(_ id: UUID) async throws -> Entity? {
        let result = realm.object(ofType: Entity.self, forPrimaryKey: id)
        return result
    }

    override func findByColumn<DataType>(column: String, value: DataType) async throws -> [Entity] {
        let results = realm.objects(Entity.self).filter("\(column) == %@", value)
        return Array(results)
    }
    
}


