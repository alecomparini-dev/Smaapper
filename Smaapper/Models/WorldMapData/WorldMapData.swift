//
//  WorldMapData.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 11/07/23.
//

import RealmSwift

class WorldMapData: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var userID: UUID
    @Persisted var environmentName: String
    @Persisted var worldMapData: Data
    
    convenience init(id: UUID = UUID(), userID: UUID, environmentName: String, worldMapData: Data) {
        self.init()
        self.id = id
        self.userID = userID
        self.environmentName = environmentName
        self.worldMapData = worldMapData
    }
    
}

