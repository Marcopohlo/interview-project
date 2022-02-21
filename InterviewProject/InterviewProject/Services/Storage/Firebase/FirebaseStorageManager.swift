//
//  FirebaseStorageManager.swift
//  InterviewProject
//
//  Created by Marek Pohl on 20.02.2022.
//

import Firebase

final class FirebaseStorageManager: StorageManagerProtocol {
    var type: StorageType = .server
    
    func start() {
        FirebaseApp.configure()
    }
    
    func loadData() async throws -> [Storable] {
        try await Firestore.firestore().collection("events").getDocuments(source: .server).documents.map { snapshot in
            let data = snapshot.data()
            let id = data["id"] as? String ?? ""
            let timestamp = data["timestamp"] as? TimeInterval ?? 0
            let name = data["name"] as? String ?? ""
            let place = data["place"] as? String ?? ""
            let duration = data["duration"] as? TimeInterval ?? 0

            return SportEvent(id: id, timestamp: timestamp, name: name, place: place, duration: duration)
        }
    }
    
    func saveEvent(_ event: Storable) {
        let data = event.firebaseDictionary
        Firestore.firestore().collection("events").addDocument(data: data)
    }
}
