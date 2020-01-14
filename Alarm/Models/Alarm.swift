//
//  Alarm.swift
//  Alarm
//
//  Created by Devin Singh on 1/13/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation

class Alarm: Codable {
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
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
}


extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return rhs.enabled == lhs.enabled && rhs.fireDate == lhs.fireDate && rhs.fireTimeAsString == lhs.fireTimeAsString
    }
}
