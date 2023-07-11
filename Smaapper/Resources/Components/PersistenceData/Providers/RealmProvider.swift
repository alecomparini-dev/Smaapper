//
//  RealmProvider.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/07/23.
//

import RealmSwift
import Realm


/*
 1 - tudo que for gravar usar o ID do usuário
 2 - Para pegar o arquivo do Realm (Realm.Configuration.defaultConfiguration.fileURL)
 */


//class RealmProvider<Entity: Object>: Repository<Entity>  {
//
//    private(set) var realm: Realm = try! Realm()
//    
//    override func delete(_ model: Entity) {   
//    }
//    
//    override func fetch() async throws -> [Entity] {
//        return try await withCheckedThrowingContinuation { continuation in
//            let results = realm.objects(Entity.self)
//            let entities = Array(results)
//            continuation.resume(returning: entities)
//        }
//    }
//
//}




