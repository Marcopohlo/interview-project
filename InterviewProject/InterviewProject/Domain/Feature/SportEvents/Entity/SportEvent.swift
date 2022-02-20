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
    var name: String { get }
    var place: String { get }
    var duration: TimeInterval { get }
    var firebaseDictionary: [String: Any] { get }
    var realmObject: Object { get }
}

struct SportEvent: Hashable, Storable {
    var id: String
    var name: String
    var place: String
    var duration: TimeInterval
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
        object.name = name
        object.place = place
        object.duration = duration
        return object
    }
}

final class SportEventObject: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var place: String
    @Persisted var duration: TimeInterval
    
    var structure: SportEvent {
        SportEvent(id: id, name: name, place: place, duration: duration)
    }
}
