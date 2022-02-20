//
//  SportEventsData.swift
//  InterviewProject
//
//  Created by Marek Pohl on 19.02.2022.
//

import Foundation

struct SportEventsData: Hashable {
    var name: String
    var place: String
    var duration: Int
    
    var asDictionary: [String: Any] {
        let mirror = Mirror(reflecting: self)
        let dictionary = Dictionary(uniqueKeysWithValues: mirror.children.lazy.compactMap { (label: String?, value: Any) -> (String, Any)? in
            guard let label = label else {
                return nil
            }
            return (label, value)
        })
        return dictionary
    }
}
