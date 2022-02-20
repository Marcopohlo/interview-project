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
    
    func loadData() async throws -> [SportEventsData] {
        try await Firestore.firestore().collection("events").getDocuments(source: .server).documents.map { snapshot in
            let data = snapshot.data()
            let name = data["name"] as? String ?? ""
            let place = data["place"] as? String ?? ""
            let duration = data["duration"] as? Int ?? 0

            return SportEventsData(name: name, place: place, duration: duration)
        }
    }
    
    func saveEvent(_ event: SportEventsData) {
        let data = event.asDictionary
        Firestore.firestore().collection("events").addDocument(data: data)
    }
}
