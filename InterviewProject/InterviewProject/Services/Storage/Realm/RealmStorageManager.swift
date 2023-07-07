//
//  RealmStorageManager.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation
import RealmSwift

final class RealmStorageManager: StorageManagerProtocol {
    var type: StorageType = .local
    
    func start() {
        
    }
    
    func loadData() async throws -> [Storable] {
        return try await withCheckedThrowingContinuation { continuation in
            let realm = try! Realm()
            let data = Array(realm.objects(SportEventObject.self)).map(\.structure)
            continuation.resume(returning: data)
        }
    }
    
    func saveEvent(_ event: Storable) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(event.realmObject)
        }
    }
}
