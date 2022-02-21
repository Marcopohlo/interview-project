//
//  SportEvent.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Foundation
import RealmSwift

protocol Storable {
    var id: String { get }
    var timestamp: TimeInterval { get }
    var name: String { get }
    var place: String { get }
    var duration: TimeInterval { get }
    var isRemote: Bool { get }
    
    var firebaseDictionary: [String: Any] { get }
    var realmObject: Object { get }
}

struct SportEvent: Hashable, Storable {
    var id: String
    var timestamp: TimeInterval
    var name: String
    var place: String
    var duration: TimeInterval
    var isRemote: Bool
    
    var firebaseDictionary: [String: Any] {
        let mirror = Mirror(reflecting: self)
        let dictionary = Dictionary(uniqueKeysWithValues: mirror.children.lazy.compactMap { (label: String?, value: Any) -> (String, Any)? in
            guard let label = label else {
                return nil
            }
            return (label, value)
        })
        return dictionary
    }
    
    var realmObject: Object {
        let object = SportEventObject()
        object.id = id
        object.timestamp = timestamp
        object.name = name
        object.place = place
        object.duration = duration
        return object
    }
}

final class SportEventObject: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var timestamp: TimeInterval
    @Persisted var name: String
    @Persisted var place: String
    @Persisted var duration: TimeInterval
    @Persisted var isRemote: Bool
    
    var structure: SportEvent {
        SportEvent(id: id, timestamp: timestamp, name: name, place: place, duration: duration, isRemote: isRemote)
    }
}
