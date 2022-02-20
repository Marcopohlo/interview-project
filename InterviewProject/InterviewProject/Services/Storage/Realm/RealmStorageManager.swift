//
//  RealmStorageManager.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import RealmSwift

final class RealmStorageManager: StorageManagerProtocol {
    var type: StorageType = .local
    
    func start() {
        
    }
    
    func loadData() async throws -> [Storable] {
        let realm = try await Realm()
        let data = Array(realm.objects(SportEventObject.self))
        return data.map(\.structure)
    }
    
    func saveEvent(_ event: Storable) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(event.realmObject)
        }
    }
}
