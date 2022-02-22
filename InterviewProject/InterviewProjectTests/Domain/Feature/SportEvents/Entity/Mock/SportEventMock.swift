//
//  SportEventMock.swift
//  InterviewProjectTests
//
//  Created by Marek Pohl on 22.02.2022.
//

import Foundation
@testable import InterviewProject
import RealmSwift

struct SportEventMock: Storable {
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
    
    lazy var mockTimestampComponents: DateComponents = {
        DateComponents(year: 2022, month: 2, day: 22, hour: 10, minute: 0, second: 0, nanosecond: 0)
    }()
    
    init() {
        let dateComponents = DateComponents(year: 2022, month: 2, day: 22, hour: 10, minute: 0, second: 0, nanosecond: 0)
        id = UUID().uuidString
        timestamp = Calendar(identifier: .gregorian).date(from: dateComponents)?.timeIntervalSince1970 ?? 0
        name = "Mock Event"
        place = "Prague"
        duration = 3600
        isRemote = true
    }
}
