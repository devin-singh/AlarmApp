//
//  Alarm.swift
//  Alarm
//
//  Created by Devin Ghumman on 1/13/20.
//  Copyright © 2020 Devin Ghumman. All rights reserved.
//

import Foundation

class Alarm {
    var fireDate: Date
    var name: String
    var enabled: Bool
    let uuid: String
    var fireTimeAsString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: fireDate)
        }
    }
    
    init(fireDate: Date, name: String, enabled: Bool) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        uuid = UUID().uuidString
    }
}


extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return rhs.enabled == lhs.enabled && rhs.fireDate == lhs.fireDate && rhs.fireTimeAsString == lhs.fireTimeAsString
    }
}