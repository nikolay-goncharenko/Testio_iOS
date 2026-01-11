//
//  ServerListStorage.swift
//  Testio
//
//  Created by Nick Goncharenko on 29.11.2025.
//

import RealmSwift

protocol ServerListStorageProtocol {
    func saveServerList(_ serverList: [ServerListResponseDTO])
    func fetchServerList() -> [ServerListObject]
    func clearServerList()
}

final class ServerListStorage: ServerListStorageProtocol {
    
    private let realm = try! Realm()
    
    internal func saveServerList(_ serverList: [ServerListResponseDTO]) {
        let objects = serverList.enumerated().map { index, dto -> ServerListObject in
            let object = ServerListObject()
            object.name = dto.name
            object.distance = dto.distance
            object.originalOrder = index
            return object
        }
        
        try? realm.write {
            let old = realm.objects(ServerListObject.self)
            realm.delete(old)
            realm.add(objects)
        }
    }
    
    internal func fetchServerList() -> [ServerListObject] {
        Array(realm.objects(ServerListObject.self))
    }
    
    internal func clearServerList() {
        try? realm.write {
            let all = realm.objects(ServerListObject.self)
            realm.delete(all)
        }
    }
}
