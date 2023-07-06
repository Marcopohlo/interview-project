//
//  FirebaseStorageManager.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Foundation
import Firebase

final class FirebaseStorageManager: StorageManagerProtocol {
    var type: StorageType = .server
    
    private lazy var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.cacheSettings = MemoryCacheSettings()
        let db = Firestore.firestore()
        db.settings = settings
        return db
    }()
    
    func start() {
        FirebaseApp.configure()
    }
    
    func loadData() async throws -> [Storable] {
        try await firestore.collection("events").getDocuments(source: .server).documents.map { snapshot in
            let data = snapshot.data()
            let id = data["id"] as? String ?? ""
            let timestamp = data["timestamp"] as? TimeInterval ?? 0
            let name = data["name"] as? String ?? ""
            let place = data["place"] as? String ?? ""
            let duration = data["duration"] as? TimeInterval ?? 0
            let isRemote = data["isRemote"] as? Bool ?? true

            return SportEvent(id: id, timestamp: timestamp, name: name, place: place, duration: duration, isRemote: isRemote)
        }
    }
    
    func saveEvent(_ event: Storable) {
        let data = event.firebaseDictionary
        firestore.collection("events").addDocument(data: data)
    }
}
